


gen y = y_gr18 - m18

keep y k l18 sector year okato_regioncode services manuf

drop if services != 1

drop if y < 0

drop if k < 0

drop if l18 < 0

drop if (y ==. | k==. | l18==.)





keep if okato_regioncode == 41


***I delete sectors in which there are less then 5 firms

bysort sector: egen sec = sum(sector)
gen sector_count = sec/sector
drop if sector_count < 5

***Generating alpha

bysort sector: egen sumY_12 = sum(y) if year == 2012

bysort sector: egen sumY_13 = sum(y) if year == 2013

bysort sector: egen sumY_14 = sum(y) if year == 2014

bysort sector: egen sumY_15 = sum(y) if year == 2015

bysort sector: egen sumY_16 = sum(y) if year == 2016

bysort sector: egen sumY_17 = sum(y) if year == 2017

bysort sector: egen sumY_18 = sum(y) if year == 2018

bysort sector: egen sumY_19 = sum(y) if year == 2019

bysort sector: egen sumY_20 = sum(y) if year == 2020



bysort sector: egen sumL_12 = sum(l18) if year == 2012

bysort sector: egen sumL_13 = sum(l18) if year == 2013

bysort sector: egen sumL_14 = sum(l18) if year == 2014

bysort sector: egen sumL_15 = sum(l18) if year == 2015

bysort sector: egen sumL_16 = sum(l18) if year == 2016

bysort sector: egen sumL_17 = sum(l18) if year == 2017

bysort sector: egen sumL_18 = sum(l18) if year == 2018

bysort sector: egen sumL_19 = sum(l18) if year == 2019

bysort sector: egen sumL_20 = sum(l18) if year == 2020




bysort sector: gen alpha_12 = 1 - sumL_12 / sumY_12

bysort sector: gen alpha_13 = 1 - sumL_13 / sumY_13

bysort sector: gen alpha_14 = 1 - sumL_14 / sumY_14

bysort sector: gen alpha_15 = 1 - sumL_15 / sumY_15

bysort sector: gen alpha_16 = 1 - sumL_16 / sumY_16

bysort sector: gen alpha_17 = 1 - sumL_17 / sumY_17

bysort sector: gen alpha_18 = 1 - sumL_18 / sumY_18

bysort sector: gen alpha_19 = 1 - sumL_19 / sumY_19

bysort sector: gen alpha_20 = 1 - sumL_20 / sumY_20




drop if (alpha_12 < 0 | alpha_12 > 1) & year == 2012
drop if (alpha_13 < 0 | alpha_13 > 1) & year == 2013
drop if (alpha_14 < 0 | alpha_14 > 1) & year == 2014
drop if (alpha_15 < 0 | alpha_15 > 1) & year == 2015
drop if (alpha_16 < 0 | alpha_16 > 1) & year == 2016
drop if (alpha_17 < 0 | alpha_17 > 1) & year == 2017
drop if (alpha_18 < 0 | alpha_18 > 1) & year == 2018
drop if (alpha_19 < 0 | alpha_19 > 1) & year == 2019
drop if (alpha_20 < 0 | alpha_20 > 1) & year == 2020

* Now I'm computing tfpr, tfpq, mrpl, mrpk and making trimming:

gen tfpr_12 = y / ((k^alpha_12) * l18^(1-alpha_12) ) if year == 2012

gen tfpr_13 = y / ((k^alpha_13) * l18^(1-alpha_13) ) if year == 2013

gen tfpr_14 = y / ((k^alpha_14) * l18^(1-alpha_14) ) if year == 2014

gen tfpr_15 = y / ((k^alpha_15) * l18^(1-alpha_15) ) if year == 2015

gen tfpr_16 = y / ((k^alpha_16) * l18^(1-alpha_16) ) if year == 2016

gen tfpr_17 = y / ((k^alpha_17) * l18^(1-alpha_17) ) if year == 2017

gen tfpr_18 = y / ((k^alpha_18) * l18^(1-alpha_18) ) if year == 2018

gen tfpr_19 = y / ((k^alpha_19) * l18^(1-alpha_19) ) if year == 2019

gen tfpr_20 = y / ((k^alpha_20) * l18^(1-alpha_20) ) if year == 2020




winsor tfpr_12, p(.02) gen(tfpr_12_w)

winsor tfpr_13, p(.02) gen(tfpr_13_w)

winsor tfpr_14, p(.02) gen(tfpr_14_w)

winsor tfpr_15, p(.02) gen(tfpr_15_w)

winsor tfpr_16, p(.02) gen(tfpr_16_w)

winsor tfpr_17, p(.02) gen(tfpr_17_w)

winsor tfpr_18, p(.02) gen(tfpr_18_w)

winsor tfpr_19, p(.02) gen(tfpr_19_w)

winsor tfpr_20, p(.02) gen(tfpr_20_w)




drop if tfpr_12 != tfpr_12_w & year==2012

drop if tfpr_13 != tfpr_13_w & year==2013

drop if tfpr_14 != tfpr_14_w & year==2014

drop if tfpr_15 != tfpr_15_w & year==2015

drop if tfpr_16 != tfpr_16_w & year==2016

drop if tfpr_17 != tfpr_17_w & year==2017

drop if tfpr_18 != tfpr_18_w & year==2018

drop if tfpr_19 != tfpr_19_w & year==2019

drop if tfpr_20 != tfpr_20_w & year==2020

drop tfpr_12_w tfpr_13_w tfpr_14_w tfpr_15_w tfpr_16_w tfpr_17_w tfpr_18_w tfpr_19_w tfpr_20_w 


gen tfpq_12 = (y)^(7/6) / ((k^alpha_12) * l18^(1-alpha_12) ) if year == 2012

gen tfpq_13 = (y)^(7/6) / ((k^alpha_13) * l18^(1-alpha_13) ) if year == 2013

gen tfpq_14 = (y)^(7/6) / ((k^alpha_14) * l18^(1-alpha_14) ) if year == 2014

gen tfpq_15 = (y)^(7/6) / ((k^alpha_15) * l18^(1-alpha_15) ) if year == 2015

gen tfpq_16 = (y)^(7/6) / ((k^alpha_16) * l18^(1-alpha_16) ) if year == 2016

gen tfpq_17 = (y)^(7/6) / ((k^alpha_17) * l18^(1-alpha_17) ) if year == 2017

gen tfpq_18 = (y)^(7/6) / ((k^alpha_18) * l18^(1-alpha_18) ) if year == 2018

gen tfpq_19 = (y)^(7/6) / ((k^alpha_19) * l18^(1-alpha_19) ) if year == 2019

gen tfpq_20 = (y)^(7/6) / ((k^alpha_20) * l18^(1-alpha_20) ) if year == 2020



***** I'm doing winsoring with TFPQ

winsor tfpq_12, p(.02) gen(tfpq_12_w)

winsor tfpq_13, p(.02) gen(tfpq_13_w)

winsor tfpq_14, p(.02) gen(tfpq_14_w)

winsor tfpq_15, p(.02) gen(tfpq_15_w)

winsor tfpq_16, p(.02) gen(tfpq_16_w)

winsor tfpq_17, p(.02) gen(tfpq_17_w)

winsor tfpq_18, p(.02) gen(tfpq_18_w)

winsor tfpq_19, p(.02) gen(tfpq_19_w)

winsor tfpq_20, p(.02) gen(tfpq_20_w)




drop if tfpq_12 != tfpq_12_w & year==2012

drop if tfpq_13 != tfpq_13_w & year==2013

drop if tfpq_14 != tfpq_14_w & year==2014

drop if tfpq_15 != tfpq_15_w & year==2015

drop if tfpq_16 != tfpq_16_w & year==2016

drop if tfpq_17 != tfpq_17_w & year==2017

drop if tfpq_18 != tfpq_18_w & year==2018

drop if tfpq_19 != tfpq_19_w & year==2019

drop if tfpq_20 != tfpq_20_w & year==2020


drop tfpq_12_w tfpq_13_w tfpq_14_w tfpq_15_w tfpq_16_w tfpq_17_w tfpq_18_w tfpq_19_w tfpq_20_w 


gen tfpq = tfpq_12 if year == 2012
replace tfpq = tfpq_13 if year == 2013
replace tfpq = tfpq_14 if year == 2014
replace tfpq = tfpq_15 if year == 2015
replace tfpq = tfpq_16 if year == 2016
replace tfpq = tfpq_17 if year == 2017
replace tfpq = tfpq_18 if year == 2018
replace tfpq = tfpq_19 if year == 2019
replace tfpq = tfpq_20 if year == 2020



gen mrpk_12 = alpha_12 * (6/7) * (y / k) if year == 2012

gen mrpk_13 = alpha_13 * (6/7) * (y / k) if year == 2013

gen mrpk_14 = alpha_14 * (6/7) * (y / k) if year == 2014

gen mrpk_15 = alpha_15 * (6/7) * (y / k) if year == 2015

gen mrpk_16 = alpha_16 * (6/7) * (y / k) if year == 2016

gen mrpk_17 = alpha_17 * (6/7) * (y / k) if year == 2017

gen mrpk_18 = alpha_18 * (6/7) * (y / k) if year == 2018

gen mrpk_19 = alpha_19 * (6/7) * (y / k) if year == 2019

gen mrpk_20 = alpha_20 * (6/7) * (y / k) if year == 2020


gen mrpk = mrpk_12 if year==2012
replace mrpk = mrpk_13 if year==2013
replace mrpk = mrpk_14 if year==2014
replace mrpk = mrpk_15 if year==2015
replace mrpk = mrpk_16 if year==2016
replace mrpk = mrpk_17 if year==2017
replace mrpk = mrpk_18 if year==2018
replace mrpk = mrpk_19 if year==2019
replace mrpk = mrpk_20 if year==2020




gen mrpl_12 = (1 - alpha_12) * (6/7) * (y / l18) if year == 2012

gen mrpl_13 = (1 - alpha_13) * (6/7) * (y / l18) if year == 2013

gen mrpl_14 = (1 - alpha_14) * (6/7) * (y / l18) if year == 2014

gen mrpl_15 = (1 - alpha_15) * (6/7) * (y / l18) if year == 2015

gen mrpl_16 = (1 - alpha_16) * (6/7) * (y / l18) if year == 2016

gen mrpl_17 = (1 - alpha_17) * (6/7) * (y / l18) if year == 2017

gen mrpl_18 = (1 - alpha_18) * (6/7) * (y / l18) if year == 2018

gen mrpl_19 = (1 - alpha_19) * (6/7) * (y / l18) if year == 2019

gen mrpl_20 = (1 - alpha_20) * (6/7) * (y / l18) if year == 2020


*** Computing TFP efficient

bysort sector: egen tfp_se12 = sum(tfpq_12^6) if year == 2012

bysort sector: egen tfp_se13 = sum(tfpq_13^6) if year == 2013

bysort sector: egen tfp_se14 = sum(tfpq_14^6) if year == 2014

bysort sector: egen tfp_se15 = sum(tfpq_15^6) if year == 2015

bysort sector: egen tfp_se16 = sum(tfpq_16^6) if year == 2016

bysort sector: egen tfp_se17 = sum(tfpq_17^6) if year == 2017

bysort sector: egen tfp_se18 = sum(tfpq_18^6) if year == 2018

bysort sector: egen tfp_se19 = sum(tfpq_19^6) if year == 2019

bysort sector: egen tfp_se20 = sum(tfpq_20^6) if year == 2020


gen TFP_se12 = tfp_se12 ^ 0.1667

gen TFP_se13 = tfp_se13 ^ 0.1667

gen TFP_se14 = tfp_se14 ^ 0.1667

gen TFP_se15 = tfp_se15 ^ 0.1667

gen TFP_se16 = tfp_se16 ^ 0.1667

gen TFP_se17 = tfp_se17 ^ 0.1667

gen TFP_se18 = tfp_se18 ^ 0.1667

gen TFP_se19 = tfp_se19 ^ 0.1667

gen TFP_se20 = tfp_se20 ^ 0.1667





bysort sector: egen sumY_12n = sum(y) if year == 2012

bysort sector: egen sumY_13n = sum(y) if year == 2013

bysort sector: egen sumY_14n = sum(y) if year == 2014

bysort sector: egen sumY_15n = sum(y) if year == 2015

bysort sector: egen sumY_16n = sum(y) if year == 2016

bysort sector: egen sumY_17n = sum(y) if year == 2017

bysort sector: egen sumY_18n = sum(y) if year == 2018

bysort sector: egen sumY_19n = sum(y) if year == 2019

bysort sector: egen sumY_20n = sum(y) if year == 2020



bysort sector: egen sumL_12n = sum(l18) if year == 2012

bysort sector: egen sumL_13n = sum(l18) if year == 2013

bysort sector: egen sumL_14n = sum(l18) if year == 2014

bysort sector: egen sumL_15n = sum(l18) if year == 2015

bysort sector: egen sumL_16n = sum(l18) if year == 2016

bysort sector: egen sumL_17n = sum(l18) if year == 2017

bysort sector: egen sumL_18n = sum(l18) if year == 2018

bysort sector: egen sumL_19n = sum(l18) if year == 2019

bysort sector: egen sumL_20n = sum(l18) if year == 2020


egen Y_12 = sum(y) if year == 2012

egen Y_13 = sum(y) if year == 2013

egen Y_14 = sum(y) if year == 2014

egen Y_15 = sum(y) if year == 2015

egen Y_16 = sum(y) if year == 2016

egen Y_17 = sum(y) if year == 2017

egen Y_18 = sum(y) if year == 2018

egen Y_19 = sum(y) if year == 2019

egen Y_20 = sum(y) if year == 2020


replace sumY_12 = sumY_12n
replace sumY_13 = sumY_13n
replace sumY_14 = sumY_14n
replace sumY_15 = sumY_15n
replace sumY_16 = sumY_16n
replace sumY_17 = sumY_17n
replace sumY_18 = sumY_18n
replace sumY_19 = sumY_19n
replace sumY_20 = sumY_20n



replace sumL_12 = sumL_12n
replace sumL_13 = sumL_13n
replace sumL_14 = sumL_14n
replace sumL_15 = sumL_15n
replace sumL_16 = sumL_16n
replace sumL_17 = sumL_17n
replace sumL_18 = sumL_18n
replace sumL_19 = sumL_19n
replace sumL_20 = sumL_20n


gen Share_12 = sumY_12 / Y_12

gen Share_13 = sumY_13 / Y_13

gen Share_14 = sumY_14 / Y_14

gen Share_15 = sumY_15 / Y_15

gen Share_16 = sumY_16 / Y_16

gen Share_17 = sumY_17 / Y_17

gen Share_18 = sumY_18 / Y_18

gen Share_19 = sumY_19 / Y_19

gen Share_20 = sumY_20 / Y_20


bysort sector: gen f_share_12 = y / sumY_12 if year == 2012

bysort sector: gen f_share_13 = y / sumY_13 if year == 2013

bysort sector: gen f_share_14 = y / sumY_14 if year == 2014

bysort sector: gen f_share_15 = y / sumY_15 if year == 2015

bysort sector: gen f_share_16 = y / sumY_16 if year == 2016

bysort sector: gen f_share_17 = y / sumY_17 if year == 2017

bysort sector: gen f_share_18 = y / sumY_18 if year == 2018

bysort sector: gen f_share_19 = y / sumY_19 if year == 2019

bysort sector: gen f_share_20 = y / sumY_20 if year == 2020



*** Computing observed TFP

bysort sector: egen av_mrpk1_12 = sum(f_share_12 / mrpk_12) if year==2012

bysort sector: egen av_mrpk1_13 = sum(f_share_13 / mrpk_13) if year==2013

bysort sector: egen av_mrpk1_14 = sum(f_share_14 / mrpk_14) if year==2014

bysort sector: egen av_mrpk1_15 = sum(f_share_15 / mrpk_15) if year==2015

bysort sector: egen av_mrpk1_16 = sum(f_share_16 / mrpk_16) if year==2016

bysort sector: egen av_mrpk1_17 = sum(f_share_17 / mrpk_17) if year==2017

bysort sector: egen av_mrpk1_18 = sum(f_share_18 / mrpk_18) if year==2018

bysort sector: egen av_mrpk1_19 = sum(f_share_19 / mrpk_19) if year==2019

bysort sector: egen av_mrpk1_20 = sum(f_share_20 / mrpk_20) if year==2020


bysort sector: gen av_mrpk_12 = 1 / av_mrpk1_12 if year==2012

bysort sector: gen av_mrpk_13 = 1 / av_mrpk1_13 if year==2013

bysort sector: gen av_mrpk_14 = 1 / av_mrpk1_14 if year==2014

bysort sector: gen av_mrpk_15 = 1 / av_mrpk1_15 if year==2015

bysort sector: gen av_mrpk_16 = 1 / av_mrpk1_16 if year==2016

bysort sector: gen av_mrpk_17 = 1 / av_mrpk1_17 if year==2017

bysort sector: gen av_mrpk_18 = 1 / av_mrpk1_18 if year==2018

bysort sector: gen av_mrpk_19 = 1 / av_mrpk1_19 if year==2019

bysort sector: gen av_mrpk_20 = 1 / av_mrpk1_20 if year==2020




bysort sector: egen av_mrpl1_12 = sum(f_share_12 / mrpl_12) if year==2012

bysort sector: egen av_mrpl1_13 = sum(f_share_13 / mrpl_13) if year==2013

bysort sector: egen av_mrpl1_14 = sum(f_share_14 / mrpl_14) if year==2014

bysort sector: egen av_mrpl1_15 = sum(f_share_15 / mrpl_15) if year==2015

bysort sector: egen av_mrpl1_16 = sum(f_share_16 / mrpl_16) if year==2016

bysort sector: egen av_mrpl1_17 = sum(f_share_17 / mrpl_17) if year==2017

bysort sector: egen av_mrpl1_18 = sum(f_share_18 / mrpl_18) if year==2018

bysort sector: egen av_mrpl1_19 = sum(f_share_19 / mrpl_19) if year==2019

bysort sector: egen av_mrpl1_20 = sum(f_share_20 / mrpl_20) if year==2020



bysort sector: gen av_mrpl_12 = 1 / av_mrpl1_12 if year==2012

bysort sector: gen av_mrpl_13 = 1 / av_mrpl1_13 if year==2013

bysort sector: gen av_mrpl_14 = 1 / av_mrpl1_14 if year==2014

bysort sector: gen av_mrpl_15 = 1 / av_mrpl1_15 if year==2015

bysort sector: gen av_mrpl_16 = 1 / av_mrpl1_16 if year==2016

bysort sector: gen av_mrpl_17 = 1 / av_mrpl1_17 if year==2017

bysort sector: gen av_mrpl_18 = 1 / av_mrpl1_18 if year==2018

bysort sector: gen av_mrpl_19 = 1 / av_mrpl1_19 if year==2019

bysort sector: gen av_mrpl_20 = 1 / av_mrpl1_20 if year==2020


gen av_mrpl = av_mrpl_12 if year ==2012
replace av_mrpl = av_mrpl_13 if year ==2013
replace av_mrpl = av_mrpl_14 if year ==2014
replace av_mrpl = av_mrpl_15 if year ==2015
replace av_mrpl = av_mrpl_16 if year ==2016
replace av_mrpl = av_mrpl_17 if year ==2017
replace av_mrpl = av_mrpl_18 if year ==2018
replace av_mrpl = av_mrpl_19 if year ==2019
replace av_mrpl = av_mrpl_20 if year ==2020


gen av_mrpk = av_mrpk_12 if year ==2012
replace av_mrpk = av_mrpk_13 if year ==2013
replace av_mrpk = av_mrpk_14 if year ==2014
replace av_mrpk = av_mrpk_15 if year ==2015
replace av_mrpk = av_mrpk_16 if year ==2016
replace av_mrpk = av_mrpk_17 if year ==2017
replace av_mrpk = av_mrpk_18 if year ==2018
replace av_mrpk = av_mrpk_19 if year ==2019
replace av_mrpk = av_mrpk_20 if year ==2020



bysort sector: egen tfp_s12 = sum( (tfpq_12 * ((av_mrpl_12 / mrpl_12)^(1-alpha_12)) * (av_mrpk_12 / mrpk_12)^alpha_12 )^6 ) if year == 2012

bysort sector: egen tfp_s13 = sum( (tfpq_13 * ((av_mrpl_13 / mrpl_13)^(1-alpha_13)) * (av_mrpk_13 / mrpk_13)^alpha_13 )^6 ) if year == 2013

bysort sector: egen tfp_s14 = sum( (tfpq_14 * ((av_mrpl_14 / mrpl_14)^(1-alpha_14)) * (av_mrpk_14 / mrpk_14)^alpha_14 )^6 ) if year == 2014

bysort sector: egen tfp_s15 = sum( (tfpq_15 * ((av_mrpl_15 / mrpl_15)^(1-alpha_15)) * (av_mrpk_15 / mrpk_15)^alpha_15 )^6 ) if year == 2015

bysort sector: egen tfp_s16 = sum( (tfpq_16 * ((av_mrpl_16 / mrpl_16)^(1-alpha_16)) * (av_mrpk_16 / mrpk_16)^alpha_16 )^6 ) if year == 2016

bysort sector: egen tfp_s17 = sum( (tfpq_17 * ((av_mrpl_17 / mrpl_17)^(1-alpha_17)) * (av_mrpk_17 / mrpk_17)^alpha_17 )^6 ) if year == 2017

bysort sector: egen tfp_s18 = sum( (tfpq_18 * ((av_mrpl_18 / mrpl_18)^(1-alpha_18)) * (av_mrpk_18 / mrpk_18)^alpha_18 )^6 ) if year == 2018

bysort sector: egen tfp_s19 = sum( (tfpq_19 * ((av_mrpl_19 / mrpl_19)^(1-alpha_19)) * (av_mrpk_19 / mrpk_19)^alpha_19 )^6 ) if year == 2019

bysort sector: egen tfp_s20 = sum( (tfpq_20 * ((av_mrpl_20 / mrpl_20)^(1-alpha_20)) * (av_mrpk_20 / mrpk_20)^alpha_20 )^6 ) if year == 2020


bysort sector year: egen tfp_s_cont = sum( (tfpq * (av_mrpk / mrpk)^alpha_12 )^6 )

gen TFP_s_cont=tfp_s_cont^(1/6)


gen TFP_s12 = tfp_s12 ^ (1/6)

gen TFP_s13 = tfp_s13 ^ (1/6)

gen TFP_s14 = tfp_s14 ^ (1/6)

gen TFP_s15 = tfp_s15 ^ (1/6)

gen TFP_s16 = tfp_s16 ^ (1/6)

gen TFP_s17 = tfp_s17 ^ (1/6)

gen TFP_s18 = tfp_s18 ^ (1/6)

gen TFP_s19 = tfp_s19 ^ (1/6)

gen TFP_s20 = tfp_s20 ^ (1/6)



gen Share = Share_12 if year==2012

replace Share = Share_13 if year==2013
replace Share = Share_14 if year==2014
replace Share = Share_15 if year==2015
replace Share = Share_16 if year==2016
replace Share = Share_17 if year==2017
replace Share = Share_18 if year==2018
replace Share = Share_19 if year==2019
replace Share = Share_20 if year==2020



duplicates drop Share, force

clear


egen TFP_12 = sum(Share_12 * ln(TFP_s12)) if year==2012

egen TFP_13 = sum(Share_13 * ln(TFP_s13)) if year==2013

egen TFP_14 = sum(Share_14 * ln(TFP_s14)) if year==2014

egen TFP_15 = sum(Share_15 * ln(TFP_s15)) if year==2015

egen TFP_16 = sum(Share_16 * ln(TFP_s16)) if year==2016

egen TFP_17 = sum(Share_17 * ln(TFP_s17)) if year==2017

egen TFP_18 = sum(Share_18 * ln(TFP_s18)) if year==2018

egen TFP_19 = sum(Share_19 * ln(TFP_s19)) if year==2019

egen TFP_20 = sum(Share_20 * ln(TFP_s20)) if year==2020



replace TFP_12 = exp(TFP_12)
replace TFP_13 = exp(TFP_13)
replace TFP_14 = exp(TFP_14)
replace TFP_15 = exp(TFP_15)
replace TFP_16 = exp(TFP_16)
replace TFP_17 = exp(TFP_17)
replace TFP_18 = exp(TFP_18)
replace TFP_19 = exp(TFP_19)
replace TFP_20 = exp(TFP_20)


egen TFP_cont = sum(Share * ln(TFP_s_cont))
replace TFP_cont = exp(TFP_cont)

gen TFP_gap_cont = TFP_cont / TFP_e


egen TFP_e12 = sum(Share_12 * ln(TFP_se12))

egen TFP_e13 = sum(Share_13 * ln(TFP_se13))

egen TFP_e14 = sum(Share_14 * ln(TFP_se14))

egen TFP_e15 = sum(Share_15 * ln(TFP_se15))

egen TFP_e16 = sum(Share_16 * ln(TFP_se16))

egen TFP_e17 = sum(Share_17 * ln(TFP_se17))

egen TFP_e18 = sum(Share_18 * ln(TFP_se18))

egen TFP_e19 = sum(Share_19 * ln(TFP_se19))

egen TFP_e20 = sum(Share_20 * ln(TFP_se20))




replace TFP_e12 = exp(TFP_e12)
replace TFP_e13 = exp(TFP_e13)
replace TFP_e14 = exp(TFP_e14)
replace TFP_e15 = exp(TFP_e15)
replace TFP_e16 = exp(TFP_e16)
replace TFP_e17 = exp(TFP_e17)
replace TFP_e18 = exp(TFP_e18)
replace TFP_e19 = exp(TFP_e19)
replace TFP_e20 = exp(TFP_e20)



* And - TFP gap - the end

gen TFP_gap_12 = TFP_e12 / TFP_12 - 1

gen TFP_gap_13 = TFP_e13 / TFP_13 - 1

gen TFP_gap_14 = TFP_e14 / TFP_14 - 1

gen TFP_gap_15 = TFP_e15 / TFP_15 - 1

gen TFP_gap_16 = TFP_e16 / TFP_16 - 1

gen TFP_gap_17 = TFP_e17 / TFP_17 - 1

gen TFP_gap_18 = TFP_e18 / TFP_18 - 1

gen TFP_gap_19 = TFP_e19 / TFP_19 - 1

gen TFP_gap_20 = TFP_e20 / TFP_20 - 1

gen TFP_gap = 0

replace TFP_gap = TFP_gap_12 if year == 2012
replace TFP_gap = TFP_gap_13 if year == 2013
replace TFP_gap = TFP_gap_14 if year == 2014
replace TFP_gap = TFP_gap_15 if year == 2015
replace TFP_gap = TFP_gap_16 if year == 2016
replace TFP_gap = TFP_gap_17 if year == 2017
replace TFP_gap = TFP_gap_18 if year == 2018
replace TFP_gap = TFP_gap_19 if year == 2019
replace TFP_gap = TFP_gap_20 if year == 2020


gen TFP_e = 0
replace TFP_e = TFP_e12 if year == 2012
replace TFP_e = TFP_e13 if year == 2013
replace TFP_e = TFP_e14 if year == 2014
replace TFP_e = TFP_e15 if year == 2015
replace TFP_e = TFP_e16 if year == 2016
replace TFP_e = TFP_e17 if year == 2017
replace TFP_e = TFP_e18 if year == 2018
replace TFP_e = TFP_e19 if year == 2019
replace TFP_e = TFP_e20 if year == 2020




clear



