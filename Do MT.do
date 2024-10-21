

gen TFP = (TFPgap + 1)^(-1) * TFP_e

clear


reg TFPgap TFP_e

gen TFPgap_2018 = TFPgap if year == 2018

gen TFP_2018 = TFP if year == 2018

gen TFPgap2 = TFP / TFP_e

replace TFPgap2 = TFPgap2*100

replace TFP_2018 = ln(TFP_2018)
replace TFPgap_2018 = ln(TFPgap_2018)

plot TFP TFP_e

scatter TFPgap_2018 TFP_2018
scatter TFPgap TFP if year == 2018

reg TFPgap TFP i.region

sort region year


egen id = group(region)

tsset id year

xtreg TFPgap TFP if (year == 2012|year==2013|year==2014) , fe i(id) vce(robust)


reg TFPgap TFP i.id if (year == 2012|year==2013|year==2014)

cd
h outreg2

ssc install outreg2 

outreg2 using reg3.tex, tex

**xtreg TFPgap TFP if (year == 2012|year==2013|year==2014), fe i(id)
** outreg2 using reg3, replace drop(ST*) addtext(State FE, YES, Year FE, YES)

xtreg TFPgap TFP i.region if (year == 2013|year==2014), fe
predict individual_effect3, u


gen ov12 = individual_effect2 - individual_effect3 + individual_effect1


gen ov13 = individual_effect3 - individual_effect2 + individual_effect1

gen ov14 = individual_effect3 + individual_effect2 - individual_effect1

drop ov14
replace individual_effect1 = individual_effect1[_n-1] if missing(individual_effect1) 


gen y12_clean = TFPgap - ov12

gen TFP12 = TFP if year ==2012

reg y12_clean TFP12, nocons


drawnorm X, n(729) means(0) sds(1)


kdensity X

clear





*** generating shares

keep y_gr18 m18 stateowned2 okato_regioncode year

gen y = y_gr18 - m18

drop m18

drop if okato_regioncode ==.

drop if stateowned2 ==.

drop so sum_f state_share idd

* You need to recalculate everything and then do merge (also include voting results in the data)

bysort okato_regioncode year: egen so = sum(stateowned2)

gen e = 1

bysort okato_regioncode year: egen sum_f = sum(e)

gen state_share = so / sum_f

gen idd = okato_regioncode * year

duplicates drop idd, force

drop y y_gr18 stateowned2 e

egen id = group(okato_regioncode)

drop id

gen region = okato_regioncode




drop if res_share < 0.5

gen Eff = TFP / TFP_e

gen res_share = NR/RDP

gen log_RDP = ln(RDP)

correlate Eff state_share if year == 2018

scatter TFPgap res_share if year == 2017


xtreg Eff res_share i.year if (year == 2017|year==2018|year==2019|year==2020), fe

help xtreg

outreg2 using res_share2.tex

xtreg TFPgap state_share TFP RDP i.year, fe

xtreg TFPgap state_share res_share TFP RDP i.year if (year == 2017|year==2018|year==2019|year==2020), fe

scatter TFPgap RDP if year==2018

xtreg TFPgap state_share res_share TFP RDP i.year, fe




outreg2 using sub_sample2.tex

gen log_TFPgap = ln(TFPgap)
gen log_NR = ln(NR)

clear

drop NR log_NR

merge 1:1 year region using "Regional shares"
drop if _merge==2

drop _merge

scatter TFPgap state_share if year == 2018

gen logTFPgap = log(TFPgap)

correlate logTFPgap state_share if year 
egen id = group(region)

tsset id year


xtreg TFPgap state_share i.id if (year == 2012|year==2013), fe
predict gamma_1, u

xtreg TFPgap state_share i.id if (year == 2012|year==2014), fe
predict gamma_2, u

xtreg TFPgap state_share i.id if (year == 2013|year==2014), fe
predict gamma_3, u

replace gamma_1 = gamma_1[_n-1] if missing(gamma_1)

replace gamma_2 = gamma_2[_n-1] if missing(gamma_2) 

replace gamma_3 = gamma_3[_n+1] if missing(gamma_3)






xtreg TFPgap state_share if (year == 2012|year==2014), fe

xtreg TFPgap state_share, fe

reg TFPgap state_share if year == 2018

replace state_share = state_share*100

gen y = TFPgap - z1

reg TFPgap state_share z3 if year==2014, nocons

summarize z1 z2 z3

outreg2 using shares.tex, append

scatter y state_share if year ==2012

reg y state_share

egen st_sh_m = mean(state_share) if year==2012

gen x = state_share - st_sh_m if year==2012

egen gap_m = mean(TFPgap) if year == 2012

gen gap_st = TFPgap - gap_m if year==2012

reg TFPgap state_share z1

summarize gamma_1 if year==2012

clear

drop if year != 2012

reg TFPgap state_share i.id if (year==2013 | year ==2014)

outreg2 using reg_id_23.tex


reg TFPgap reg_share if year==2018

scatter TFPgap reg_share if year==2018

drop z1 z2 z3 gamma_1 gamma_2 gamma_3


#Robustness check

gen r = region

keep if (r == 27 | r ==47 | r==11 | r==41 |r==28 | r==45 | r==15 | r==24 | r==61 | r==33 | r==97 | r==14 | r==63 | r==60 | r==79 |r==91 | r==90 | r==96 | r==12 | r==80 | r==37 | r==69 | r==1 | r==95 | r==25 | r==10 | r==44 | r==77 | r==5)

clear




*** The next is firm number shares of 3 industries

gen y = y_gr18 - m18

keep manuf services industry year stateowned2 okato_regioncode

gen Agr = 1 if manuf==0 & services==0

replace Agr = 0 if Agr==.

bysort okato_regioncode year: egen Manuf_sum = sum(manuf)

bysort okato_regioncode year: egen Servic_sum = sum(services)

bysort okato_regioncode year: egen Agr_sum = sum(Agr)

bysort okato_regioncode year: gen Firm_sum = Manuf_sum+Servic_sum+Agr_sum

bysort okato_regioncode year: gen Manuf_share = Manuf_sum/Firm_sum

bysort okato_regioncode year: gen Servic_share = Servic_sum/Firm_sum

bysort okato_regioncode year: gen Agr_share = 1-Servic_share-Manuf_share

drop if okato_regioncode==.

gen idd = okato_regioncode*year

duplicates drop idd, force



drop stateowned2 manuf services industry Agr idd

* gen region = okato_regioncode

merge 1:1 year okato_regioncode using "TFPgap data"
drop if _merge != 3

drop _merge

clear

scatter logTFPgap log_RDP if year == 2018

rename Servic_share Service_share

scatter Servic_share log_RDP if year == 2018

scatter logTFPgap Service_share if year == 2018

scatter logTFPgap Agr_share if year == 2018

scatter logTFPgap Manuf_share if year == 2018

* Regression analysis

tsset id year

xtreg TFPgap Service_share Agr_share RDP TFP, fe i(id) vce(robust)

outreg2 using Sectors.tex

scatter Eff Service_share if year == 2018

scatter Eff TFP if year == 2018

gen logTFP = log(TFP)

scatter log_TFPgap logTFP if year == 2018

clear

*** The next is revenue shares of 3 industries

gen y = y_gr18 - m18

keep y manuf services industry year okato_regioncode

gen Agr = 1 if manuf==0 & services==0

replace Agr = 0 if Agr==.

bysort okato_regioncode year: egen Manuf_sum = sum(manuf)

bysort okato_regioncode year: egen Servic_sum = sum(services)

bysort okato_regioncode year: egen Agr_sum = sum(Agr)

bysort okato_regioncode year: gen Firm_sum = Manuf_sum+Servic_sum+Agr_sum

bysort okato_regioncode year: gen Manuf_share = Manuf_sum/Firm_sum

bysort okato_regioncode year: gen Servic_share = Servic_sum/Firm_sum

bysort okato_regioncode year: gen Agr_share = 1-Servic_share-Manuf_share

drop if okato_regioncode==.

gen idd = okato_regioncode*year

duplicates drop idd, force



drop stateowned2 manuf services industry Agr idd


*** The next is labour shares (?) of 3 industries - which framework is better?
