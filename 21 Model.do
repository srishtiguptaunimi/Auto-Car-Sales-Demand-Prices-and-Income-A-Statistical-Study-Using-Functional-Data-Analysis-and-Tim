import delimited "C:\Users\Sristhi\Downloads\Final_data_monthly.csv", encoding(UTF-8) parselocale(en_US) groupseparator(.) decimalseparator(,) 
generate total_sales = das+fas+dltas+fltas
generate disp_income = di
generate time = tm(1970jan)+_n-1
tsset time, monthly
graph matrix total_sales disp_income ur acpi appi ptcpi mvicpi pop
graph twoway (scatter total_sales aap agp disp_income ur acpi appi ptcpi mvicpi)
 graph matrix total_sales disp_income ur acpi appi ptcpi mvicpi pop
graph matrix total_sales disp_income ur acpi appi ptcpi mvicpi pop, diagonal(, size(tiny))
graph matrix total_sales disp_income ur acpi appi ptcpi mvicpi pop, half msymbol(Oh)
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\Graph1 all variables.gph"
gen lagtotal_sales = total_sales[_n-1]
gen lagaap = aap[_n-1]
gen lagagp = agp[_n-1]
. gen ladisp_income = disp_income[_n-1]
. gen latime = time[_n-1]
drop latime
. gen laur = ur[_n-1]
. gen lacpi = acpi[_n-1]
gen laappi = appi[_n-4]
gen l2appi = appi[_n-1]
drop laappi
drop l2appi
ac total_sales
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\Total sales autocorrelation.gph"
ac total_sales if tin(Jan 2005 - Dec  2020)
ac total_sales if tin(2005m1 - 2020m12)
ac total_sales in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\Total sales autocorrelation 2005 to 2020.gph"
ac aap in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\aap autocorrelation.gph"
ac agp in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\agp aR.gph"
ac disp_income in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\disp income ar.gph"
ac ur in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\UR AR.gph"
ac acpi in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\acpi AR.gph"
ac appi in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\appi AR.gph"
ac ptcpi in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\ptcpi aR.gph"
ac mvicpi in 457/648
graph save "Graph" "C:\Users\Sristhi\Desktop\microeconomics\Graphs\mvicpi AR.gph"
wntestb total_sales
wntestb aap
wntestb agp
ipolate agp time, generate(agp2)
replace aap = 40107 in 637
wntestb disp_income
wntestb ur
wntestb acpi
wntestb appi
wntestb appi
wntestb ptcpi
wntestb mvicpi
wntestb pop
reg total_sales aap agp disp_income acpi appi ptcpi mvicpi
reg total_sales aap agp disp_income acpi appi ptcpi mvicpi pop ur z
predict e_ols, resid
predict res_ols
twoway scatter e_ols res_ols
reg total_sales aap agp disp_income acpi appi ptcpi mvicpi pop ur z if tin(2005m1,2020m12)
predict e_ols1, residual
predict res_ols1
dfuller e_ols1, lag(10)
dfuller d.e_ols, lag(10)
estat dwatson
estat durbinalt
estat bgodfrey
varsoc total_sales aap agp di ur acpi appi ptcpi mvicpi z pop disp_income
dfuller e_ols1, lag(10)
ssc install ardl
which ardl
dfuller pop, lag(4)
dfuller d.pop, lag(4)
generate ltotal_sales = log(total_sales)
generate laap = log(aap)
generate lagp = log(agp)
generate ldisp_income = log(disp_income)
generate lur = log(ur)
generate l_acpi = log(acpi)
generate l_ptcpi = log(ptcpi)
generate l_mvicpi = log(mvicpi)
generate l_pop = log(pop)
generate l_appi = log(appi)
reg total_sales aap agp disp_income acpi appi ptcpi mvicpi pop ur z if tin(2005m1,2020m12)
vif
reg total_sales aap agp disp_income acpi appi ptcpi mvicpi ur z if tin(2005m1,2020m12)
vif
reg total_sales aap agp disp_income acpi appi ptcpi ur z if tin(2005m1,2020m12)
vif
reg total_sales aap agp disp_income acpi appi ptcpi ur z if tin(2005m1,2020m12)
varsoc total_sales aap agp di ur acpi appi ptcpi z disp_income
varsoc total_sales aap agp ur acpi appi ptcpi z disp_income
drop di
reg total_sales aap agp disp_income acpi appi ptcpi ur z if tin(2005m1,2020m12)
vif
reg d.total_sales d.aap d.agp d.disp_income acpi appi d.ptcpi d.mvicpi ur z if tin(2005m1,2020m12)
vif
vecrank ltotal_sales laap lagp lur l_acpi l_ptcpi l_appi if tin(2005m1,2020m12), trend(trend) lags(4)
vecrank ltotal_sales laap lagp lur l_acpi l_ptcpi l_appi if tin(2005m1,2020m12), trend(trend) lags(4) max
vecrank ltotal_sales laap lagp lur l_acpi l_ptcpi l_appi l_pop l_mvicpi if tin(2005m1,2020m12), trend(trend) lags(4) max
ardl total_sales aap agp disp_income ur acpi appi ptcpi mvicpi, maxlags(2) aic
ardl total_sales aap agp disp_income ur acpi appi ptcpi mvicpi pop, maxlags(2) aic
matrix list e(lags)
ardl total_sales aap agp disp_income ur acpi appi ptcpi mvicpi pop, lags(2 0 1 2 2 1 0 1 1 2) ec btest
ardl total_sales aap agp disp_income ur acpi appi ptcpi mvicpi pop, lags(2 0 1 2 2 1 0 1 1 2) ec
ardl total_sales aap agp disp_income ur acpi appi ptcpi mvicpi pop, lags(2 0 1 2 2 1 0 1 1 2) regstore(ecreg)
estimate restore ecreg
regress
estat dwatson
estat bgodfrey
estat imtest, white
ssc install cusum6
cusum6 total_sales aap agp disp_income ur acpi appi ptcpi mvicpi pop, cs(cusum) lw(lower) uw(upper)
replace agp = 1.32 in 288
cusum6 total_sales aap agp disp_income ur acpi appi ptcpi mvicpi pop, cs(cusum) lw(lower) uw(upper)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(trend) lags(4)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(trend) lags(4), if tin(2005m1,2020m12)
predict e_VEC, residual
predict res_VEC
drop res_VEC
predict res_VEC
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, lags(4), if tin(2005m1,2020m12)
veclmar, mlag(4)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(constant) lags(4), if tin(2005m1,2020m12)
veclmar, mlag(4)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, lags(4) trend(trend), if tin(2005m1,2020m12)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(trend) rank(5) lags(4)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(rtrend) lags(4), if tin(2005m1,2020m12)
veclmar, mlag(4)
vecnorm, jbera skewness kurtosis
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(rtrend) rank(5) lags(4)
veclmar, mlag(4)
vecnorm, jbera skewness kurtosis
vecstable
prais total_sales disp_income mvicpi ptcpi appi acpi ur agp aap, corc
reg total_sales aap agp disp_income acpi appi ptcpi ur pop if tin(2005m1,2020m12)
vec ltotal_sales laap lagp ldisp_income lur l_acpi l_ptcpi l_mvicpi l_pop l_appi, trend(rtrend) rank(1) lags(4), if tin(2005m1,2020m12)
