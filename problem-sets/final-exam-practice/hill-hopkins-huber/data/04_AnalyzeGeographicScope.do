/* AnalyzeGeographicScope.do
  Estimate the effect of changing Hispanic population on
  change in Republican vote share from 2012 to 2016.
  This version iterates over increasingly large distance
  definitions of geographic context.
*/

* Global options.
global OUTREG2OPTIONS tex(fragment) sdec(2) 2aster auto(2) nocons rdec(3) label
global OUTREG1OPTIONS se bracket rdec(3) 3aster 
global TABLELOC "Tables"

use "GeographicScopeData.dta", clear

*++++++++++++++++++++++++
* Set up model specifications.
*++++++++++++++++++++++++
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
  
local notes="Weighted to number of votes 2012"

*****************************
* Regression models
*****************************
* Variables to present in the production tables (in order).
local keepvars = "`iv_c_1611' `iv_pc_1611' `iv_c_1600' `iv_pc_1600' l11_hispanic l00_hispanic l11_foreign l00_foreign"

local distances `" "01" "05" "10" "'
foreach dist in `distances' {
  local repl "replace"
  local outregfile = "$TABLELOC/AppendixTable06_GeogScopeDistance`dist'_WeightedFullSample"

  *
  *
  * Changes 2011 to 2016
  *
  *

  local outputvars = "`iv_c_1611'"
  local modeltitle = "Bivariate Change, 2011 to 2016"
  local modeltitle2 = "`dist' miles"

	regress `dv' `iv_c_1611' if geog_scope == "`dist' mile"  [aweight=weight], robust
 	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") addnote(`notes') keep(`keepvars') addtext("Control for levels","No","County fixed effects","No","Additional Census controls","No","Republican share 2012","No")  `repl'
  local repl "append"

	local modeltitle = "Change 2011 to 2016, Other Changes, Levels 2011, 2012 Republican Vote Share"

	regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' rv12d_* if geog_scope == "`dist' mile" [aweight=weight], robust
	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

  * Low-diversity only.
	regress `dv' `iv_c_1611' `cv_c_1611' `cv_l_1611' rv12d_* if geog_scope == "`dist' mile" & low_diversity11 == 1 & low_diversity16 == 1 [aweight=weight], robust
	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2',Low,diversity") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

	*
	*
	* Proportional Changes 2011 to 2016
	*
	*

	local modeltitle = "Proportional Change 2011 to 2016, Other Changes, Levels 2011, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1611' `cv_c_1611' `cv_l_1611'  rv12d_* if geog_scope == "`dist' mile" [aweight=weight], robust
	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

	*
	*
	* Changes 2000 to 2016
	*
	*

	local outputvars = "`iv_c_1600'"
	local modeltitle = "Bivariate Change, 2000 to 2016"

	regress `dv' `iv_c_1600' if geog_scope == "`dist' mile" [aweight=weight], robust
 	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","No","County fixed effects","No","Additional Census controls","No","Republican share 2012","No") append

	local modeltitle = "Change 2000 to 2016, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_c_1600' `cv_c_1600' `cv_l_1600' rv12d_* if geog_scope == "`dist' mile" [aweight=weight], robust
	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

  * Low-diversity only.
	regress `dv' `iv_c_1600' `cv_c_1600' `cv_l_1600' rv12d_* if geog_scope == "`dist' mile" & low_diversity11 == 1 & low_diversity16 == 1 [aweight=weight], robust
	 outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2',Low,diversity") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

	*
	*
	* Proportional Changes 2000 to 2016
	*
	*


	regress `dv' `iv_pc_1600' if geog_scope == "`dist' mile" [aweight=weight], robust

	local modeltitle = "Proportional Change 2000 to 2016, Other Changes, Levels 2000, 2012 Republican Vote Share"

	regress `dv' `iv_pc_1600' `cv_c_1600' `cv_l_1600'  rv12d_* if geog_scope == "`dist' mile" [aweight=weight], robust
	 *outreg2 using `outregfile'.tex, $OUTREG2OPTIONS ctitle("`modeltitle2'") keep(`keepvars') addtext("Control for levels","Yes","County fixed effects","Yes","Additional Census controls","Yes","Republican share 2012","Yes") append

}
