/* AnalyzePooledPrecinctLevelFiles.do
  Estimate the effect of changing Hispanic population on
  change in Republican vote share from 2012 to 2016.
*/

* Global options.
global OUTREG2OPTIONS tex(fragment) sdec(2) 2aster auto(2) nocons rdec(3) label
global OUTREG1OPTIONS se bracket rdec(3) 3aster 
global TABLELOC "Tables"

use "PrecinctData.dta", clear

*++++++++++++++++++++++++
* Some stats for the paper.
*++++++++++++++++++++++++
* Summary of total votes cast in our precincts.
preserve
collapse (sum) Total_Voters_2016_Prct
format Total_Voters_2016_Prct %16.0g
di "Total 2016 votes cast in our precincts:"
cl
restore
* Correlation b/w pct non-citizen foreign born and pct Hispanic.
corr d1611_hispanic d1611_foreign
* Correlation b/w housing and pct Hispanic.
corr d1611_hispanic d1611_rent d1611_rent_income d1611_housing_150
* Summary of precinct population 2016.
summ CTTOTPOP16_WGT, detail
* Summary of change in proportion Hispanic.
summ d1611_hispanic, detail
summ d1600_hispanic, detail

*++++++++++++++++++++++++
* Set up model specifications.
*++++++++++++++++++++++++
local iv_c_1611 = "d1611_hispanic"
local iv_pc_1611 = "dprop1611_hispanic"
local cv_c_1611 = "d1611_poor d1611_unemp d1611_mfg d1611_pop"
local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_mfg l11_density l11_black l11_educba i.countyid "

local iv_c_1600 = "d1600_hispanic"
local iv_pc_1600 = "dprop1600_hispanic"
local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

local iv_c_1100 = "d1100_hispanic"
local iv_pc_1100 = "dprop1100_hispanic"
local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"

qui regress gop_propvote_change `iv_pc_1611' `iv_pc_1100' `cv_c_1611' `cv_c_1100' `cv_l_1600'  rv12d_* [aweight=weight], robust
keep if e(sample)

* Outsheet the main variables for graphing in R.
outsheet gop_propvote_change d1611_hispanic dprop1611_hispanic_notopcode d1600_hispanic dprop1600_hispanic_notopcode using "Figure01DataForR.csv", comma replace

* Loop over model types and run regressions.
forvalues modelgroups = 1(1)14 {

	preserve

	local resultsctr = 1

	gen m_modeltitle= ""
	gen m_iv = ""
	gen m_beta=.
	gen m_se=.
	gen m_notes = ""

	if `modelgroups'==1 {
	
		local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_hispanic"
		local iv_pc_1611 = "dprop1611_hispanic"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"
			
		local notes="Precinct-level analysis; Weighted to number of votes 2012; Proportional changes top and bottom coded at 1 and -1"
		local outregfile = "$TABLELOC/Table01_WeightedFullSample"
	}
	else if `modelgroups'==2 {
	
		local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_hispanic"
		local iv_pc_1611 = "dprop1611_hispanic"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"

		local notes="Precinct-level analysis; Unweighted; Full sample; Proportional changes top and bottom coded at 1 and -1"
		replace weight=1 if weight!=0 & weight!=.
		local outregfile = "$TABLELOC/AppendixTable01_UnweightedFullSample"
	}
	else if `modelgroups'==3 {
	
		local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_hispanic"
		local iv_pc_1611 = "dprop1611_hispanic"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"

		local notes="Precinct-level analysis; Weighted to number of votes 2012; Low Education Sample; Proportional changes top and bottom coded at 1 and -1"
		local outregfile = "$TABLELOC/AppendixTableNOTUSED_WeightedLowEducationSample"
		summ l16_educba, detail
		keep if l16_educba<=r(p25)
	}
	else if `modelgroups'==4 {
	
		local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_foreign"
		local iv_pc_1611 = "dprop1611_foreign"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_foreign l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_foreign"
		local iv_pc_1600 = "dprop1600_foreign"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_foreign l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_foreign"
		local iv_pc_1100 = "dprop1100_foreign"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"
			
		local notes="Precinct-level analysis; Weighted to number of votes 2012; Full sample; Foreign Born; Proportional changes top and bottom coded at 1 and -1"
		local outregfile = "$TABLELOC/AppendixTable07_ForeignBorn"
	}
	else if `modelgroups'>=5 & `modelgroups'<=11 {
    * Models by state.	
		local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_hispanic"
		local iv_pc_1611 = "dprop1611_hispanic"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"
			
		local notes="Precinct-level analysis; Weighted to number of votes 2012; Full sample; Proportional changes top and bottom coded at 1 and -1"

		if `modelgroups'== 5 {
			keep if st=="FL"
			local outregfile = "$TABLELOC/AppendixTable11_JustFlorida"
		}
		else if `modelgroups'==6 {
			keep if st=="GA"
			local outregfile = "$TABLELOC/AppendixTable12_JustGeorgia"
		}
		else if `modelgroups'==7 {
			keep if st=="MI"
			local outregfile = "$TABLELOC/AppendixTable13_JustMichigan"
		}
		else if `modelgroups'==8 {
			keep if st=="NV"
			local outregfile = "$TABLELOC/AppendixTable14_JustNevada"
		}
		else if `modelgroups'==9 {
			keep if st=="OH"
			local outregfile = "$TABLELOC/AppendixTable15_JustOhio"
		}
		else if `modelgroups'==10 {
			keep if st=="PA"
			local outregfile = "$TABLELOC/AppendixTable16_JustPennsylvania"
		}
		else if `modelgroups'==11 {
			keep if st=="WA"
			local outregfile = "$TABLELOC/AppendixTable17_JustWashington"
		}
	}
	else if `modelgroups'==12 {
	
		local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_hispanic_quartiles_*"
		local iv_pc_1611 = "dprop1611_hispanic_quartiles_*"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic_quartiles_*"
		local iv_pc_1600 = "dprop1600_hispanic_quartiles_*"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"
			
		local notes="Precinct-level analysis; Weighted to number of votes 2012; Full sample"
		local outregfile = "$TABLELOC/AppendixTable10_WeightedFullSample_Quartiles"
  }
	else if `modelgroups'==13 {
	
		local dv = "GOPPCT16"
		local iv_c_1611 = "d1611_hispanic"
		local iv_pc_1611 = "dprop1611_hispanic"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"
			
		local notes="Dependent variable is GOP vote share 2016; Precinct-level analysis; Weighted to number of votes 2012; Full sample; Proportional changes top and bottom coded at 1 and -1"
		local outregfile = "$TABLELOC/AppendixTable06_LevelsDV_WeightedFullSample"
	}
	else if `modelgroups'==14 {
	
    local dv = "gop_propvote_change"
		local iv_c_1611 = "d1611_hispanic"
		local iv_pc_1611 = "dprop1611_hispanic"
		local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
		local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba i.countyid "

		local iv_c_1100 = "d1100_hispanic"
		local iv_pc_1100 = "dprop1100_hispanic"
		local cv_c_1100 = "d1100_poor d1100_unemp d1100_mfg d1100_pop"

		local notes="Precinct-level analysis; Weighted to number of votes 2012; Low diversity sample (non-white, non-Hispanic population 2011 < .15); Proportional changes top and bottom coded at 1 and -1"
		local outregfile = "$TABLELOC/AppendixTable08_WeightedLowDiversitySample"
		keep if l11_notwhite_nothispanic <= .15
    * Calculate low-diversity in 2016.
    qui g low_diversity16 = (l16_notwhite_nothispanic <= .15)
    label var low_diversity16 "Non-white, non-Hispanic population 2016 < .15"
	}
	
	else {
    di "error!"
    break
	}
		
  
  *****************************
  * Regression models
  *****************************
  * Variables to present in the production tables (in order).
  local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hispanic l00_hispanic l11_foreign l00_foreign"
	
	*
	*
	* Changes 2011 to 2016
	*
	*

	local outputvars = "`iv_c_1611'"
	local modeltitle = "Bivariate Change, 2011 to 2016"
	local modeltitle2 = "Change in, GOP share"
	* Model title blank.
	local modeltitle2 = " "

	regress `dv' `iv_c_1611' [aweight=weight], robust
	* Latex version.
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") addnote(`notes') keep(`keepvars') addtext("Control for levels","No","County fixed effects","No","Additional Census controls","No","Republican share 2012","No")  replace
	include 99_saveresults.do

	local modeltitle = "Change 2011 to 2016, Other Changes, Levels 2011"

	regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","No") append
	include 99_saveresults.do

	local modeltitle = "Change 2011 to 2016, Other Changes, Levels 2011, 2012 Republican Vote Share"

	regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' rv12d_* [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Proportional Changes 2011 to 2016
	*
	*

	local outputvars = "`iv_pc_1611'"
	local modeltitle = "Bivariate Proportional Change 2011 to 2016"

	regress `dv' `iv_pc_1611' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2011 to 2016, Other Changes, Levels 2011"

	regress `dv' `iv_pc_1611' `cv_c_1611' `cv_l_1611' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2011 to 2016, Other Changes, Levels 2011, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1611' `cv_c_1611' `cv_l_1611'  rv12d_* [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Changes 2000 to 2016
	*
	*

	local outputvars = "`iv_c_1600'"
	local modeltitle = "Bivariate Change, 2000 to 2016"

	regress `dv' `iv_c_1600' [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","No","County fixed effects","No","Additional Census controls","No","Republican share 2012","No") append
	include 99_saveresults.do

	local modeltitle = "Change 2000 to 2016, Other Changes, Levels 2000"

	regress `dv' `iv_c_1600' `cv_c_1600' `cv_l_1600' [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","No") append
	include 99_saveresults.do

	local modeltitle = "Change 2000 to 2016, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_c_1600' `cv_c_1600' `cv_l_1600' rv12d_* [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Proportional Changes 2000 to 2016
	*
	*

	local outputvars = "`iv_pc_1600'"
	local modeltitle = "Bivariate Proportional Change 2000 to 2016"

	regress `dv' `iv_pc_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2000 to 2016, Other Changes, Levels 2000"

	regress `dv' `iv_pc_1600' `cv_c_1600' `cv_l_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2000 to 2016, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1600' `cv_c_1600' `cv_l_1600'  rv12d_* [aweight=weight], robust
	outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Changes 2011 to 2016 AND 2000 TO 2011
	*
	*

	local outputvars = "`iv_c_1611' `iv_c_1100'"
	local modeltitle = "Changes 2011 to 2016 and 2000 to 2011"

	regress `dv' `iv_c_1611' `iv_c_1100'  [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Changes 2011 to 2016 and 2000 to 2011, Other Changes, Levels 2000"

	regress `dv' `iv_c_1611' `iv_c_1100' `cv_c_1611' `cv_c_1100' `cv_l_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Changes 2011 to 2016 and 2000 to 2011, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_c_1611' `iv_c_1100' `cv_c_1611' `cv_c_1100' `cv_l_1600' rv12d_* [aweight=weight], robust
	include 99_saveresults.do

	*
	*
	* Proportional Changes 2011 to 2016 AND 2000 TO 2011
	*
	*

	local outputvars = "`iv_pc_1611' `iv_pc_1100'"
	local modeltitle = "Proportional Changes 2011 to 2016 and 2000 to 2011"

	regress `dv' `iv_pc_1611' `iv_pc_1100' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Changes 2011 to 2016 and 2000 to 2011, Other Changes, Levels 2000"

	regress `dv' `iv_pc_1611' `iv_pc_1100' `cv_c_1611' `cv_c_1100' `cv_l_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Changes 2011 to 2016 and 2000 to 2011, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1611' `iv_pc_1100' `cv_c_1611' `cv_c_1100' `cv_l_1600'  rv12d_* [aweight=weight], robust
	include 99_saveresults.do

	keep m_*
	drop if m_modeltitle==""
	outsheet using `outregfile'_summaryresultstograph.csv, comma replace
	restore

}

******************
******************
* Main results by decile of 2012 GOP vote share.
******************
******************
local dv = "gop_propvote_change"
local iv_c_1611 = "d1611_hispanic"
local iv_pc_1611 = "dprop1611_hispanic"
local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "
local outputvars = "`iv_c_1611'"
local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hispanic l00_hispanic l11_foreign l00_foreign"
local outregfile = "$TABLELOC/AppendixTable09_WeightedFullSample_By2012Decile"

* Pooled extimate.
regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight], robust
outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("Pooled") addnote(`notes') keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes") replace
* By decile.
forvalues i=1/10 {
  regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight] if decile_repvote12 == `i', robust
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("Decile `i'") addnote(`notes') keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes") append
}

******************
******************
* Main results by quartiles of precinct population density
* and quartiles of Autor Dorn Hanson trade exposure.
******************
******************
local dv = "gop_propvote_change"
local iv_c_1611 = "d1611_hispanic"
local iv_pc_1611 = "dprop1611_hispanic"
local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba i.countyid "
local outputvars = "`iv_c_1611'"
local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hispanic l00_hispanic l11_foreign l00_foreign"

* Population density.
local outregfile = "$TABLELOC/AppendixTable03_WeightedFullSample_ByPopDens"
* Pooled extimate.
regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight], robust
outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("Pooled") addnote(`notes') keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes") replace
* By quartile.
forvalues i=1/4 {
  regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight] if quartile_popdens == `i', robust
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("Quartile `i'") addnote(`notes') keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes") append
}

* Trade exposure.
local outregfile = "$TABLELOC/AppendixTable04_WeightedFullSample_ByChinaTradeExposure"
* Pooled extimate.
regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight], robust
outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("Pooled") addnote(`notes') keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes") replace
* By quartile.
forvalues i=1/4 {
  regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' [aweight=weight] if quartile_exposure == `i', robust
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("Quartile `i'") addnote(`notes') keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes") append
}


******************
******************
* Robusntess. Low educ +
* Econ distress + County level.
******************
******************

use "PrecinctData.dta", clear
local notes="Precinct-level analysis; Weighted to number of votes 2012; Proportional changes top and bottom coded at 1 and -1"
local clustervar ""

forvalues modelgroups = 1(1)3 {

	preserve

	local resultsctr = 1

	if `modelgroups'==1 {
    * Low education.
    summ l16_educba, detail
		keep if l16_educba<=r(p25)
    local ctitle = "Low, education"
    local outregfile = "$TABLELOC/AppendixTable02_WeightedRobustness-LowEduc"
    local iv_c_1611 = "d1611_hispanic"
    local iv_pc_1611 = "dprop1611_hispanic"
    local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
    local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba"

    local iv_c_1600 = "d1600_hispanic"
    local iv_pc_1600 = "dprop1600_hispanic"
    local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
    local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba"
    * Variables to present in the production tables (in order).
    local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hispanic l00_hispanic"

	}
	else if `modelgroups'==2 {
    * Econ distress := top 10% in increase in 
    * unemployment or poverty, or bottom 10% in
    * population growth rate.
    foreach var of varlist d1600_unemp d1600_poor {
      summ `var', detail
      gen above90_`var' = (`var' > r(p90))
    }    
    summ d1600_pop, detail
    gen below10_d1600_pop = (d1600_pop < r(p10))
    keep if below10_d1600_pop | above90_d1600_poor | above90_d1600_unemp 
    local ctitle = "Economic, distress"
    local outregfile = "$TABLELOC/AppendixTable02_WeightedRobustness-EconDistress"
    local iv_c_1611 = "d1611_hispanic"
    local iv_pc_1611 = "dprop1611_hispanic"
    local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
    local cv_l_1611 = "l11_hispanic l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba"

    local iv_c_1600 = "d1600_hispanic"
    local iv_pc_1600 = "dprop1600_hispanic"
    local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
    local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba"
    * Variables to present in the production tables (in order).
    local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hispanic l00_hispanic"

	}
	else if `modelgroups'==3 {
    * County level changes as predictors.
    * Rename precinct-level hispanic variables.
    rename *hispanic* *hisp_prc*
    joinby stcofips using "CountyHispanicChanges.dta", unmatched(master)
    tab _merge
    drop _merge
    * Correlate county and precinct hispanic variables.
    corr d1611_hispanic d1611_hisp_prc
    corr dprop1611_hispanic dprop1611_hisp_prc
    corr l11_hispanic l11_hisp_prc
    corr l00_hispanic l00_hisp_prc

    local ctitle = "County, population, changes"
    * Cluster SEs on the county.
    local clustervar "cluster(stcofips)"
    local outregfile = "$TABLELOC/AppendixTable05_WeightedRobustness-CountyChanges"
    local iv_c_1611 = "d1611_hisp_prc d1611_hispanic"
    local iv_pc_1611 = "dprop1611_hisp_prc dprop1611_hispanic"
    local cv_c_1611 = "d1611_poor d1611_unemp d1611_rent d1611_rent_income d1611_housing_150 d1611_mfg d1611_pop"
    local cv_l_1611 = "l11_hispanic l11_hisp_prc l11_poor l11_unemp l11_rent l11_rent_income l11_housing_150 l11_mfg l11_density l11_black l11_educba"

    local iv_c_1600 = "d1600_hisp_prc d1600_hispanic"
    local iv_pc_1600 = "dprop1600_hisp_prc dprop1600_hispanic"
    local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
    local cv_l_1600 = "l00_hispanic l00_hisp_prc l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba"
    * Variables to present in the production tables (in order).
    local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hisp_prc l11_hispanic l00_hisp_prc l00_hispanic"

  }
	else {
		di "error!"
		break
	}
  
  *****************************
  * Regression models
  *****************************
	
	*
	*
	* Changes 2011 to 2016
	*
	*

	local outputvars = "`iv_c_1611'"
	local modeltitle2 = "`ctitle'"
  local repl "replace"
  
	local modeltitle = "Change 2011 to 2016, Other Changes, Levels 2011, 2012 Republican Vote Share"

	regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' rv12d_* [aweight=weight], robust `clustervar'
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") `repl'
  local repl "append"

	*
	*
	* Proportional Changes 2011 to 2016
	*
	*

	local outputvars = "`iv_pc_1611'"
	local modeltitle = "Bivariate Proportional Change 2011 to 2016"

	regress `dv' `iv_pc_1611' [aweight=weight], robust `clustervar'

	local modeltitle = "Proportional Change 2011 to 2016, Other Changes, Levels 2011"

	regress `dv' `iv_pc_1611' `cv_c_1611' `cv_l_1611' [aweight=weight], robust `clustervar'

	local modeltitle = "Proportional Change 2011 to 2016, Other Changes, Levels 2011, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1611' `cv_c_1611' `cv_l_1611'  rv12d_* [aweight=weight], robust `clustervar'
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

	*
	*
	* Changes 2000 to 2016
	*
	*

	local outputvars = "`iv_c_1600'"
	local modeltitle = "Bivariate Change, 2000 to 2016"
  
	local modeltitle = "Change 2000 to 2016, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_c_1600' `cv_c_1600' `cv_l_1600' rv12d_* [aweight=weight], robust `clustervar'
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

	*
	*
	* Proportional Changes 2000 to 2016
	*
	*

	local outputvars = "`iv_pc_1600'"
	local modeltitle = "Bivariate Proportional Change 2000 to 2016"

	regress `dv' `iv_pc_1600' [aweight=weight], robust `clustervar'

	local modeltitle = "Proportional Change 2000 to 2016, Other Changes, Levels 2000"

	regress `dv' `iv_pc_1600' `cv_c_1600' `cv_l_1600' [aweight=weight], robust `clustervar'

	local modeltitle = "Proportional Change 2000 to 2016, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1600' `cv_c_1600' `cv_l_1600'  rv12d_* [aweight=weight], robust `clustervar'
  outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

	restore
  
}
