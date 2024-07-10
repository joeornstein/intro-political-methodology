*******************************************************************************************************************************
clear
* Here you should replace "Folder with the path for the folder where the data files are stored.
use "${path}/CampanteDo_MainData.dta", clear

**********************************************
* Generating the relevant isolation measures *
**********************************************
egen GCISCmean=rowmean(GCISC19* GCISC2000)



egen LCISCmean1970=rowmean(LCISC1920 LCISC1930 LCISC1940 LCISC1950 LCISC1960 LCISC1970)

egen GCISC_C1mean1970=rowmean(GCISC_C11920 GCISC_C11930 GCISC_C11940 GCISC_C11950 GCISC_C11960 GCISC_C11970)
egen GCISC_norm2_C1mean1970=rowmean(GCISC_norm2_C11920 GCISC_norm2_C11930 GCISC_norm2_C11940 GCISC_norm2_C11950 GCISC_norm2_C11960 GCISC_norm2_C11970)
egen centr_GCISCmean1970=rowmean(centr_GCISC1920 centr_GCISC1930 centr_GCISC1940 centr_GCISC1950 centr_GCISC1960 centr_GCISC1970)


gen ALDadjmean1970 = 1-GCISC_norm2mean1970
gen ALDmean = 1-GCISCmean //Average Log Distance, the opposite of GCISC

gen centr_ALDmean1970 = 1-centr_GCISCmean1970
gen centr_SuitALD = 1-centr_SuitGCISC
gen ADmean1970 = 1-LCISCmean1970
gen centr_ALDmean = 1-centr_GCISCmean
gen ALD_C1mean1970 = 1-GCISC_C1mean1970



twoway (scatter corruptrate_avg ALDmean1970 , mlabel(state_code) xtitle("Average Log Distance")legend(label(1 "Corruption")))(lfit corruptrate_avg ALDmean1970 ) if state_code~=""
* Table 1 - Balancing Tests *
*****************************
quietly reg `x' logarea if year==1970, robust
outreg2 logarea using "${path}/Balance_`x'", bracket pvalue nocons title("Balancing Test") bdec(4) excel replace
foreach var in lat lon logborder waterpct logelevation_span lognavwatways arablesh logDCdistance dateofstatehood {
quietly reg `x' logarea logMaxDist `var' if year==1970, robust
outreg2 `var' using "${path}/Balance_`x'", bracket pvalue nocons title("Balancing Test") bdec(4) excel append
}
reg `x' logarea logMaxDist lat lon logborder waterpct logelevation_span lognavwatways arablesh logDCdistance dateofstatehood if year==1970, rob
test lat lon logborder waterpct logelevation_span lognavwatways arablesh logDCdistance dateofstatehood
}

**********************************



reg corruptrate_avg ALDmean1970 loginc  bacen logpop logarea logMaxDistSt govemp_sh urbans fract regu mining south northeast midwest if state_code~="" & year==1970, robust
* Isolation of largest city



 IV: centroid concentration (population)

 x
 twoway(scatter ALDmean1970 x, mlabel(state_code) xtitle("Population-Average Log Distance (not adjusted) to Centroid (residuals)") legend(label(1 "Capital Population-AvgLogDistance (not adjusted)"))) (lfit ALDmean1970 x) if state_code~="" & year==1970

 ivreg2 corruptrate_avg (ALDmean1970 = centr_ALDmean1970) loginc bacen logpop logarea logMaxDistSt govemp_sh urbans south northeast midwest if state_code~="" & year==1970, robust first


********************************************************************************
egen GCISCmean=rowmean(GCISC19* GCISC2000)
egen LCISCmean1970=rowmean(LCISC1920 LCISC1930 LCISC1940 LCISC1950 LCISC1960 LCISC1970)
gen ALDmean1970 = 1-GCISCmean1970 //Average Log Distance, the opposite of GCISC
gen centr_ALDmean1970 = 1-centr_GCISCmean1970
gen centr_SuitALD = 1-centr_SuitGCISC
gen ADmean1970 = 1-LCISCmean1970
gen centr_ALDmean = 1-centr_GCISCmean
gen ALD_C1mean1970 = 1-GCISC_C1mean1970
use "${path}/CampanteDo_Elections.dta", clear
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel replace
areg TurnoutState LogDist LogDistCentroid LogDens LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist LogDistCentroid using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
* By electoral cycle
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if ElectionCycle==1 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if ElectionCycle==2 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if ElectionCycle==3 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if ElectionCycle==4 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if ElectionCycle==5 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if ElectionCycle==6 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
* Presidential years vs off years
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if PresYear==1 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append
areg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor if OffYear==1 & TurnoutState<1, a(StateYearID) robust cluster(state_code)
outreg2 LogDist using "${path}/Turnout", bracket nocons title("Distance to the Capital and Turnout") bdec(4) excel append

* Testing for equality of presidential vs off year coefficients
set matsize 800
cap estimates drop pres
quietly xi: reg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor i.StateYearID if PresYear==1 & TurnoutState<1
estimates store pres
cap estimates drop off
quietly xi: reg TurnoutState LogDist LogPop18 LogLandarea LogMedHHInc atlst_hs atlstcol popshare_below5 popshare_from5to17 popshare_from18to24/*
	*/ popshare_from25to34-popshare_over85 popshare_hisp-popshare_multrace incgini_90 het_rel_90 het_race_90/*
	*/ pctpoor i.StateYearID if OffYear==1 & TurnoutState<1
estimates store off
suest pres off, vce(cluster stfips)
test [pres_mean=off_mean]: LogDist



*********************************************************
egen GCISCmean=rowmean(GCISC19* GCISC2000)
egen LCISCmean1970=rowmean(LCISC1920 LCISC1930 LCISC1940 LCISC1950 LCISC1960 LCISC1970)
gen centr_ALDmean1970 = 1-centr_GCISCmean1970
gen centr_SuitALD = 1-centr_SuitGCISC
gen ADmean1970 = 1-LCISCmean1970
gen centr_ALDmean = 1-centr_GCISCmean
gen ALD_C1mean1970 = 1-GCISC_C1mean1970

***************************************************
* Table 11: Contributions and Distance to Capital *
***************************************************
use "${path}/CampanteDo_ContribCounty.dta", clear

* By county
areg LogContribSumC LogDist, a(state_code) cluster(state_code)
outreg2 LogDist using "${path}/ContribCounty", bracket nocons title("Campaign contribution in state elections from real estate industry and distance to capital") bdec(4) excel replace
areg LogContribSumC LogDist LogPop18 LogMedHHinc , a(state_code) cluster(state_code)
outreg2 LogDist using "${path}/ContribCounty", bracket nocons title("Campaign Contribution from Real Estate Industry and Distance to Capital") bdec(4) excel append
areg LogContribSumC LogDist LogPop18 LogMedHHinc atlst_hs atlstcol het_race_90 het_rel_90 incgini_90 povrate LogLandarea popshare_* , a(state_code) cluster(state_code)
outreg2 LogDist using "${path}/ContribCounty", bracket nocons title("Campaign Contribution from Real Estate Industry and Distance to Capital") bdec(4) excel append
areg LogContribSumC LogDist LogPop18 LogMedHHinc atlst_hs atlstcol het_race_90 het_rel_90 incgini_90 povrate LogLandarea popshare_* if LogContribSumC~=0 , a(state_code) cluster(state_code)
outreg2 LogDist using "${path}/ContribCounty", bracket nocons title("Campaign contribution in state elections from real estate industry and distance to capital") bdec(4) excel append
* Low isolation vs high isolations states
areg LogContribSumC LogDist LogPop18 LogMedHHinc atlst_hs atlstcol het_race_90 het_rel_90 incgini_90 povrate LogLandarea popshare_* if GCISC>.3102733, a(state_code) cluster(state_code)
outreg2 LogDist using "${path}/ContribCounty", bracket nocons title("Campaign Contribution from Real Estate Industry and Distance to Capital") bdec(4) excel append
areg LogContribSumC LogDist LogPop18 LogMedHHinc atlst_hs atlstcol het_race_90 het_rel_90 incgini_90 povrate LogLandarea popshare_* if GCISC<.3102733, a(state_code) cluster(state_code)
outreg2 LogDist using "${path}/ContribCounty", bracket nocons title("Campaign Contribution from Real Estate Industry and Distance to Capital") bdec(4) excel append
* By zipcode
use "${path}/CampanteDo_ContribZip.dta", clear
areg LogContribSum LogDistCap, a(fips) cluster(state_code)
outreg2 LogDistCap using "${path}/ContribCounty", bracket nocons title("Campaign contribution in state elections from real estate industry and distance to capital") bdec(4) excel append


egen GCISCmean=rowmean(GCISC19* GCISC2000)
egen LCISCmean1970=rowmean(LCISC1920 LCISC1930 LCISC1940 LCISC1950 LCISC1960 LCISC1970)
gen centr_ALDmean1970 = 1-centr_GCISCmean1970
gen centr_SuitALD = 1-centr_SuitGCISC
gen ADmean1970 = 1-LCISCmean1970
gen centr_ALDmean = 1-centr_GCISCmean
gen ALD_C1mean1970 = 1-GCISC_C1mean1970
pca smart insured logbedspc, component(1)