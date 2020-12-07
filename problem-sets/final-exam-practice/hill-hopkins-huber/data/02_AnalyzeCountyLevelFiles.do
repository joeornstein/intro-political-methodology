/* AnalyzeCountyLevelFiles.do
  Estimate the effect of changing Hispanic population on
  change in Republican vote share from 2012 to 2016.
*/

use "CountyData.dta", clear

* Summary of precinct population 2016.
summ CTTOTPOP16, detail
* Summary of change in proportion Hispanic.
summ d1610_hispanic, detail
summ d1600_hispanic, detail

**********************
* Regression models.
**********************
forvalues ctr = 2(1)10 {
 label var rv12d_`ctr' "Decile `ctr' of Republican Vote 2012"
 }

local iv_c_1610 = "d1610_hispanic"
local iv_pc_1610 = "dprop1610_hispanic"
local cv_c_1610 = "d1610_poor d1610_unemp d1610_mfg d1610_pop"
local cv_l_1610 = "l10_hispanic l10_poor l10_unemp l10_mfg l10_density l10_black l10_educba"

local iv_c_1600 = "d1600_hispanic"
local iv_pc_1600 = "dprop1600_hispanic"
local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba"

local iv_c_1000 = "d1000_hispanic"
local iv_pc_1000 = "dprop1000_hispanic"
local cv_c_1000 = "d1000_poor d1000_unemp d1000_mfg d1000_pop"

qui regress gop_propvote_change `iv_pc_1610' `iv_pc_1000' `cv_c_1610' `cv_c_1000' `cv_l_1600'  rv12d_* [aweight=weight], robust
keep if e(sample)

forvalues modelgroups = 1(1)2 {

	preserve

	local resultsctr = 1

	gen m_modeltitle= ""
	gen m_iv = ""
	gen m_beta=.
	gen m_se=.
	gen m_notes = ""

	if `modelgroups'==1 {
	
		local iv_c_1610 = "d1610_hispanic"
		local iv_pc_1610 = "dprop1610_hispanic"
		local cv_c_1610 = "d1610_poor d1610_unemp d1610_mfg d1610_pop"
		local cv_l_1610 = "l10_hispanic l10_poor l10_unemp l10_mfg l10_density l10_black l10_educba"

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba"

		local iv_c_1000 = "d1000_hispanic"
		local iv_pc_1000 = "dprop1000_hispanic"
		local cv_c_1000 = "d1000_poor d1000_unemp d1000_mfg d1000_pop"
			
		local notes="County-level analysis; Weighted; Full Sample; Proportional changes top and bottom coded at 1 and -1"
		local outregfile = "Tables\CountyAnalysisTable01_WeightedFullSample"
	}
	else if `modelgroups'==2 {
	
		local iv_c_1610 = "d1610_hispanic"
		local iv_pc_1610 = "dprop1610_hispanic"
		local cv_c_1610 = "d1610_poor d1610_unemp d1610_mfg d1610_pop"
		local cv_l_1610 = "l10_hispanic l10_poor l10_unemp l10_mfg l10_density l10_black l10_educba"

		local iv_c_1600 = "d1600_hispanic"
		local iv_pc_1600 = "dprop1600_hispanic"
		local cv_c_1600 = "d1600_poor d1600_unemp d1600_mfg d1600_pop"
		local cv_l_1600 = "l00_hispanic l00_poor l00_unemp l00_mfg l00_density l00_black l00_educba"

		local iv_c_1000 = "d1000_hispanic"
		local iv_pc_1000 = "dprop1000_hispanic"
		local cv_c_1000 = "d1000_poor d1000_unemp d1000_mfg d1000_pop"

		local notes="County-level analysis; Unweighted; Full Sample; Proportional changes top and bottom coded at 1 and -1"
		replace weight=1 if weight!=0 & weight!=.
		local outregfile = "Tables\CountyAnalysisTable01_UnweightedFullSample"
	}
	else {
		di "error!"
		break
	}
	
  *****************************
  * Regression models
  *****************************
  * Variables to present in the production tables (in order).
  local keepvars = "`iv_c_1610' `iv_pc_1610' `iv_c_1600' `iv_pc_1600' l10_hispanic l00_hispanic l10_foreign l00_foreign"

	*
	*
	* Changes 2010 to 2016
	*
	*

	local outputvars = "`iv_c_1610'"
	local modeltitle = "Bivariate Change 2010 to 2016"
	local modeltitle2 = "Change in, GOP share"
  * Model title blank.
	local modeltitle2 = " "

	regress gop_propvote_change `iv_c_1610' [aweight=weight], robust
  * Latex version.
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) addnote(`notes') rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","No","Additional Census controls","No","Republican share 2012","No")  replace
	include 99_saveresults.do

	local modeltitle = "Change 2010 to 2016; Other Changes; Levels 2010"

	regress gop_propvote_change `iv_c_1610' `cv_c_1610' `cv_l_1610' [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","No") append
	include 99_saveresults.do

	local modeltitle = "Change 2010 to 2016; Other Changes; Levels 2010; 2012 Republican Vote Share"

	regress gop_propvote_change `iv_c_1610' `cv_c_1610' `cv_l_1610' rv12d_* [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Proportional Changes 2010 to 2016
	*
	*

	local outputvars = "`iv_pc_1610'"
	local modeltitle = "Bivariate Proportional Change 2010 to 2016"

	regress gop_propvote_change `iv_pc_1610' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2010 to 2016; Other Changes; Levels 2010"

	regress gop_propvote_change `iv_pc_1610' `cv_c_1610' `cv_l_1610' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2010 to 2016; Other Changes; Levels 2010; 2012 Republican Vote Share"

	regress gop_propvote_change `iv_pc_1610' `cv_c_1610' `cv_l_1610'  rv12d_* [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Changes 2000 to 2016
	*
	*

	local outputvars = "`iv_c_1600'"
	local modeltitle = "Bivariate Changes 2000 to 2016"

	regress gop_propvote_change `iv_c_1600' [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","No","Additional Census controls","No","Republican share 2012","No") append
	include 99_saveresults.do

	local modeltitle = "Change 2000 to 2016; Other Changes; Levels 2000"

	regress gop_propvote_change `iv_c_1600' `cv_c_1600' `cv_l_1600' [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","No") append
	include 99_saveresults.do

	local modeltitle = "Change 2000 to 2016; Other Changes; Levels 2000; 2012 Republican Vote Share"

	regress gop_propvote_change `iv_c_1600' `cv_c_1600' `cv_l_1600' rv12d_* [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Proportional Changes 2010 to 2016
	*
	*

	local outputvars = "`iv_pc_1600'"
	local modeltitle = "Bivariate Proportional Change 2000 to 2016"

	regress gop_propvote_change `iv_pc_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2000 to 2016; Other Changes; Levels 2000"

	regress gop_propvote_change `iv_pc_1600' `cv_c_1600' `cv_l_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Change 2000 to 2016; Other Changes; Levels 2000; 2012 Republican Vote Share"

	regress gop_propvote_change `iv_pc_1600' `cv_c_1600' `cv_l_1600'  rv12d_* [aweight=weight], robust
  outreg2 using `outregfile'.tex, tex(fragment) ctitle("`modeltitle2'") sdec(2) 2aster auto(2) rdec(3) lab nocons keep(`keepvars') addtext("Control for levels","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append
	include 99_saveresults.do

	*
	*
	* Changes 2010 to 2016 AND 2000 TO 2010
	*
	*

	local outputvars = "`iv_c_1610' `iv_c_1000'"
	local modeltitle = "Changes 2010 to 2016 and 2000 to 2010"

	regress gop_propvote_change `iv_c_1610' `iv_c_1000'  [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Changes 2010 to 2016 and 2000 to 2010; Other Changes; Levels 2000"

	regress gop_propvote_change `iv_c_1610' `iv_c_1000' `cv_c_1610' `cv_c_1000' `cv_l_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Changes 2010 to 2016 and 2000 to 2010; Other Changes; Levels 2000; 2012 Republican Vote Share"

	regress gop_propvote_change `iv_c_1610' `iv_c_1000' `cv_c_1610' `cv_c_1000' `cv_l_1600' rv12d_* [aweight=weight], robust
	include 99_saveresults.do

	*
	*
	* Proportional Changes 2010 to 2016 AND 2000 TO 2010
	*
	*

	local outputvars = "`iv_pc_1610' `iv_pc_1000'"
	local modeltitle = "Proportional Changes 2010 to 2016 and 2000 to 2010"

	regress gop_propvote_change `iv_pc_1610' `iv_pc_1000' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Changes 2010 to 2016 and 2000 to 2010; Other Changes; Levels 2000"

	regress gop_propvote_change `iv_pc_1610' `iv_pc_1000' `cv_c_1610' `cv_c_1000' `cv_l_1600' [aweight=weight], robust
	include 99_saveresults.do

	local modeltitle = "Proportional Changes 2010 to 2016 and 2000 to 2010; Other Changes; Levels 2000; 2012 Republican Vote Share"

	regress gop_propvote_change `iv_pc_1610' `iv_pc_1000' `cv_c_1610' `cv_c_1000' `cv_l_1600'  rv12d_* [aweight=weight], robust
	include 99_saveresults.do

	keep m_*
	drop if m_modeltitle==""
	outsheet using `outregfile'_summaryresultstograph.csv, comma replace
	restore

}

