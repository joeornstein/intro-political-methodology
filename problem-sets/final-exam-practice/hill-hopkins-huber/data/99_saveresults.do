* saveresults.do
* Save out coefficient estimates by model.

foreach ov of varlist `outputvars' {
	replace m_modeltitle = "`modeltitle'" in `resultsctr'
	local templabel : var label `ov'
	replace m_iv = "`templabel'" in `resultsctr'
	replace m_beta = _b[`ov'] in `resultsctr'
	replace m_se = _se[`ov'] in `resultsctr'
	replace m_notes = "`notes'" in `resultsctr'
	l m_* in `resultsctr'
	local resultsctr = `resultsctr' + 1
}

