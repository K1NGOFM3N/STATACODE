gen lvio = ln(vio)
gen lrob = ln(rob)
gen lmur = ln(mur)
tabulate year , generate(yr)
global yr_var = "yr2 yr3 yr4 yr5 yr6 yr7 yr8 yr9 yr10 yr11 yr12 yr13 yr14 yr15 yr16 yr17 yr18 yr19 yr20 yr21 yr22 yr23"

global basevars = "incarc_rate density avginc pop pb1064 pw1064 pm1029"
xtset stateid year

***LNVIO REGRESSION***********************************

reg lvio shall,r
estimates store reg1
reg lvio shall $basevars, r
estimates store reg2
esttab reg1 reg2
xtreg lvio shall $basevars, fe vce(cluster stateid)
estimates store reg3
xtreg lvio shall $basevars $yr_var, fe vce(cluster stateid)
estimates store reg4
esttab reg3 reg4
test $yr_var
***LNROB REGRESSION***********************************
reg lrob shall,r
estimates store reg1
reg lrob shall $basevars, r
estimates store reg2
esttab reg1 reg2
xtreg lrob shall $basevars, fe vce(cluster stateid)
estimates store reg3
xtreg lrob shall $basevars $yr_var, fe vce(cluster stateid)
estimates store reg4
esttab reg1 reg2 reg3 reg4 using q1hw3.rtf ,append  b(a3) t abs star(+ 0.10 * 0.05 ** 0.01 *** 0.001) ar2(3) scalars (N) sfmt(3) nogaps label title ("LOG_MURDER_crime_regressions")
test $yr_var
***LNMUR REGRESSION**************************************
reg lmur shall,r
estimates store reg1
reg lmur shall $basevars, r
estimates store reg2
esttab reg1 reg2
xtreg lmur shall $basevars, fe vce(cluster stateid)
estimates store reg3
xtreg lmur shall $basevars $yr_var, fe vce(cluster stateid)
estimates store reg4
esttab reg1 reg2 reg3 reg4 using q1hw3.rtf, replace  b(a3) t abs star(+ 0.10 * 0.05 ** 0.01 *** 0.001) ar2(3) scalars (N) sfmt(3) nogaps label title ("LOG_MURDER_crime_regressions")
test $yr_var
**question1 
reg lrob shall $basevars, vce(cluster stateid)
reg lrob shall $basevars $yr_var, vce(cluster stateid)

**question2
xtreg lrob shall $basevars, fe vce(cluster stateid)
xtreg lrob shall $basevars $yr_var, fe vce(cluster stateid)

**************
****10.2
**#

xtset code year


drop in 69
xtreg dem_ind log_gdppc, fe vce(cluster code)



gen y60=(year==1960)
gen y65 = year == 1965		
gen y70=(year==1970)
gen y75=(year==1975)
gen y80=(year==1980)
gen y85=(year==1985)
gen y90=(year==1990)
gen y95=(year==1995)		
gen y200=(year==2000)
global yeardum "y60 y70 y75 y80 y85 y90 y95 y200"
global basevars = "age_1 age_2 age_3 age_4 age_5 educ age_median"

reg dem_ind log_gdppc, vce(cluster code)
estimates store reg1
xtreg dem_ind log_gdppc, fe vce(cluster code)
estimates store reg2
xtreg dem_ind log_gdppc $basevars $yeardum, fe vce(cluster code)
estimates store reg3
esttab reg1 reg2 reg3  using q1hw3.rtf, replace  b(a3) t abs star(+ 0.10 * 0.05 ** 0.01 *** 0.001) ar2(3) scalars (N) sfmt(3) nogaps label title ("10.2 REGRESSION")
test $yeardum