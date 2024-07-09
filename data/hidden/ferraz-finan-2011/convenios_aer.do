#delimit ;
****************************************************************;
** This file creates table 9, which estimates the effects of 
** reelection incentives on matching grants
****************************************************************;

clear;
set mem 300m;

capture log close;
log using convenios_aer.log, replace;

use conveniosdata_aer.dta, replace;

gen ano2001 = ano==2001;
gen ano2002 = ano==2002;
gen ano2003 = ano==2003;
gen ano2004 = ano==2004;

gen tr_ano2001 = first*ano2001;
gen tr_ano2002 = first*ano2002;
gen tr_ano2003 = first*ano2003;
gen tr_ano2004 = first*ano2004;

global prefchar2 "pref_masc pref_idade_tse pref_escola party_d1  party_d3- party_d18";
global munichar2 "lpop purb p_secundario mun_novo lpib02 gini_ipea";

gen ano_lpib02 = ano*lpib02;
gen ano_purb = ano*purb;
gen ano_p_secundario = ano*p_secundario;
gen ano_mun_novo = ano*mun_novo;
gen ano_gini_ipea = ano*gini_ipea;
gen ano_pref_masc = ano*pref_masc;
gen ano_pref_idade_tse = ano*pref_idade_tse;
gen ano_pref_escola = ano*pref_escola;
gen ano_p_cad_pref = ano*p_cad_pref;
gen ano_vereador_eleit = ano *vereador_eleit;
gen ano_ENLP2000 = ano*ENLP2000;
gen ano_comarca = ano*comarca;

reg dconvenios tr_ano2004 tr_ano2003 tr_ano2002 first ano2002-ano2004 $prefchar2 $munichar2  p_cad_pref vereador_eleit ENLP2000 comarca, robust cluster(cod_ibge6);
 test tr_ano2003= tr_ano2002;
 test tr_ano2004= tr_ano2003;
 test tr_ano2004= tr_ano2002;
areg dconvenios first tr_ano2002- tr_ano2004 ano2002-ano2004 ano_*, robust abs(cod_ibge6) cluster(cod_ibge6) ;
 test tr_ano2003= tr_ano2002;
 test tr_ano2004= tr_ano2003;
 test tr_ano2004= tr_ano2002;

reg lconvenios_pc tr_ano2004 tr_ano2003 tr_ano2002 first ano2002-ano2004  $prefchar2 $munichar2  p_cad_pref vereador_eleit ENLP2000 comarca, robust cluster(cod_ibge6);
 test tr_ano2003= tr_ano2002;
 test tr_ano2004= tr_ano2003;
 test tr_ano2004= tr_ano2002;

areg lconvenios_pc first tr_ano2002- tr_ano2004 ano2002-ano2004 ano_* , robust abs(cod_ibge6) cluster(cod_ibge6) ;
 test tr_ano2003= tr_ano2002;
 test tr_ano2004= tr_ano2003;
 test tr_ano2004= tr_ano2002;

reg msh_liberado   first tr_ano2002- tr_ano2004 ano2002-ano2004  $prefchar2 $munichar2  p_cad_pref vereador_eleit ENLP2000 comarca, robust cluster(cod_ibge6);
 test tr_ano2003= tr_ano2002;
 test tr_ano2004= tr_ano2003;
 test tr_ano2004= tr_ano2002;

areg msh_liberado  first tr_ano2002- tr_ano2004 ano2002-ano2004 ano_*, robust abs(cod_ibge6) cluster(cod_ibge6) ;
 test tr_ano2003= tr_ano2002;
 test tr_ano2004= tr_ano2003;
 test tr_ano2004= tr_ano2002;
log close;
exit;
