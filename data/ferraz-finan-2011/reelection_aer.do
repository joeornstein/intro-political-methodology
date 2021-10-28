#delimit ;
clear;
*****************************************************;
*  This file creates all the tables in the paper
*  with the exception of Table 9 which is created
*  in convenios_aer.do. This file also creates 
*  Figure 2. See the README file for definitions of
*  of the variables. 
*****************************************************;
set more off;
set mem 500m;
set matsize 500;
capture log close;
log using reelection_aer.log, replace;

use corruptiondata_aer.dta, replace;

global prefchar2 "pref_masc pref_idade_tse pref_escola party_d1  party_d3- party_d18";
global munichar2 "lpop purb p_secundario mun_novo lpib02 gini_ipea";

**************;
*TABLE 1;
**************;
sum dcorrupt_desvio dcorrupt_licitacao dcorrupt_superfat dcorrupt if esample2==1;
sum ncorrupt_desvio corrupt_desvio shcorrupt_desvio pcorrupt_desvio if dcorrupt_desvio==1&esample2==1;
sum ncorrupt_licitacao corrupt_licitacao shcorrupt_licitacao pcorrupt_licitacao if dcorrupt_licitacao==1&esample2==1;
sum ncorrupt_superfat corrupt_superfat shcorrupt_superfat pcorrupt_superfat if dcorrupt_superfat==1&esample2==1;
sum ncorrupt valor_corrupt ncorrupt_os pcorrupt if dcorrupt==1&esample2==1;
sum pmismanagement if esample2==1&dmismanagement>0;
sum dmismanagement if esample2==1;

**************;
*TABLE 2;
**************;
local varlist "ncorrupt_desvio shcorrupt_desvio pcorrupt_desvio ncorrupt_licitacao shcorrupt_licitacao pcorrupt_licitacao ncorrupt_superfat shcorrupt_superfat pcorrupt_superfat ncorrupt ncorrupt_os pcorrupt";

foreach x of local varlist {;
  reg `x' first reeleito  if esample2==1, noc; 
  reg `x' reeleito  if esample2==1; 
};

**************;
*TABLE 3;
**************;
tabstat pref_masc pref_escola pref_idade_tse  pop purb p_secundario mun_novo pib_capita_02 gini_ipea rec_transf op_01_04 p_cad_pref vereador_eleit ENLP2000 winmargin comarca media2  tot_os totrecursos if esample2==1, statistics( mean sd ) by(reeleito) nototal noseparator columns(variables);

local varlist "pref_masc pref_masc pref_idade_tse pref_escola pop purb p_secundario mun_novo pib_capita_02 gini_ipea rec_transf p_cad_pref vereador_eleit ENLP2000 winmargin comarca media2 op_01_04 tot_os totrecursos";
foreach x of local varlist {;
    reg `x' first if esample2==1, robust ;
};

**************;
*TABLE 4;
**************;
reg pcorrupt first  if esample2==1, robust;
reg pcorrupt first $prefchar2  if esample2==1, robust;
reg pcorrupt first $prefchar2 $munichar2 lrec_trans   if esample2==1, robust;
reg pcorrupt first $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca  if esample2==1, robust;
reg pcorrupt first $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust;
areg pcorrupt first $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);
match pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca lrec_fisc  sorteio*  uf_d*  if esample2==1, bias(bias) m(6) rob(3);
tobit pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca lrec_fisc sorteio*  uf_d*  if esample2==1, ll(0);
*mfx;


**************;
*TABLE 5;
**************;
reg ncorrupt first  if esample2==1, robust;
areg ncorrupt first lrec_fisc $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca  sorteio*  if esample2==1, robust abs(uf);
match ncorrupt first lrec_fisc $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*   uf_d*  if esample2==1, bias(bias) m(3) rob(3);
nbreg ncorrupt first lrec_fisc $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio2-sorteio10   uf_d*  if esample2==1, robust;
 *mfx;

reg ncorrupt_os first   if esample2==1, robust;
areg ncorrupt_os first lrec_fisc $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*   if esample2==1, robust abs(uf);
match ncorrupt_os first lrec_fisc fiscalizacoes $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  uf_d*  if esample2==1, bias(bias) m(3) rob(3);
tobit ncorrupt_os first lrec_fisc $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*   uf_d* if esample2==1, ll(0);
 *mfx;



**************;
*TABLE 6;
**************;
gen wm = winmargin2000 if reeleito==1;
 replace wm =  winmargin2000_inclost if incumbent==1;
gen running = wm;
 replace running = -wm if incumbent==1;
gen running2 = running^2;
gen running3 = running^3;
gen running4 = running^4;

gen spline1 = first*running;
gen spline2 = first*running2;
gen spline3 = first*running3;
gen spline4 = first*running4;

areg pcorrupt first $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1&running~=., robust abs(uf);
areg pcorrupt first running $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1, robust abs(uf);
areg pcorrupt first running running2 $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1, robust abs(uf);
areg pcorrupt first running running2 running3 $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1, robust abs(uf);
areg pcorrupt first running spline1 $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1, robust abs(uf);
areg pcorrupt first running spline1 running2 spline2 $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1, robust abs(uf);
areg pcorrupt first running spline1 running2 running3 spline2 spline3 $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca   sorteio*  if esample2==1, robust abs(uf);

**************;
*TABLE 7;
**************;
gen first_experienced=reeleito==0 & exp_prefeito==1;
gen experience1=first_experienced==1 | reeleito==1;
gen experience2=reeleito==1 | reeleito_2004==1;
gen experience3=reeleito==1 | elected1==1;
egen nexp = rowtotal(exp_prefeito vereador9600);
replace nexp = nexp*4; 
gen nexp2 = nexp^2;

areg pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1 & experience2==1, robust abs(uf);

areg pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1 & experience3==1 , robust abs(uf);

areg pcorrupt first exp_prefeito $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);

areg pcorrupt first nexp nexp2 $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);

areg pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1 & experience1==1, robust abs(uf);

areg pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1 & (first==0|(first==1&(exp_prefeito==1|vereador96==1))), robust abs(uf);


****************;
**  TABLE 8 ***;
****************;
areg pmismanagement first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);

areg pmismanagement first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1&experience2==1, robust abs(uf);

areg pmismanagement first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1&experience1==1, robust abs(uf);

areg pcorrupt first $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1&pmismanagement~=., robust abs(uf);



**************;
*TABLE 10;
**************;
gen h_ENEP2000 = 1/ENEP2000;
gen first_comarca  = comarca*first;
gen first_p_cad_pref  = p_cad_pref*first;
gen first_media2  = media2*first;
gen first_h_ENEP2000  = h_ENEP2000*first;

areg pcorrupt first first_comarca $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio* if esample2==1, robust abs(uf);
 test first first_comarca;

areg pcorrupt first first_media2 media2 $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio* if esample2==1, robust abs(uf);
 test first first_media2;

areg pcorrupt first first_p_cad_pref $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio* if esample2==1, robust abs(uf);
 test first first_p_cad_pref;

areg pcorrupt first first_h_ENEP2000 h_ENEP2000 $prefchar2 $munichar2 lrec_trans p_cad_pref vereador_eleit comarca sorteio* if esample2==1, robust abs(uf);
 test first first_h_ENEP2000;



****************;
**TABLE 11 ***;
****************;
gen sorteio_electyear= nsorteio>5 & nsorteio<10;
gen first_sorteio_electyear=first*sorteio_electyear;
areg pcorrupt first first_sorteio_electyear $prefchar2 $munichar2 lrec_trans lfunc_ativ  p_cad_pref vereador_eleit ENLP2000 comarca sorteio* if esample2==1, robust abs(uf); 

gen first_PT=first*party_d15;
areg pcorrupt first first_PT $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);

*manipualtion same party governor;  
 gen first_samepartygov98=first*samepartygov98; 
areg pcorrupt first first_samepartygov98 samepartygov98 $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);

*manipulation of fiscalizacoes or recursos fiscalizados;
gen lrecursos_fisc = log(valor_fiscalizado);
areg lrecursos_fisc first  $prefchar2 $munichar2 lrec_trans  p_cad_pref vereador_eleit ENLP2000 comarca lfunc_ativ sorteio* if esample2==1, robust abs(uf); 


areg lrecursos_fisc first first_sorteio_electyear sorteio_electyear $prefchar2 $munichar2 lrec_trans lfunc_ativ  p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);
                                          
areg lrecursos_fisc first first_PT $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);

areg lrecursos_fisc  first first_samepartygov98 samepartygov98 $prefchar2 $munichar2 lrec_trans lfunc_ativ p_cad_pref vereador_eleit ENLP2000 comarca sorteio*  if esample2==1, robust abs(uf);


************;
* Figure 2
************;
reg pcorrupt first running running2 running3  if esample2==1, robust;
predict fit;
predict stderror, stdp;

gen fit1 =fit if running < 0;
gen fit2 =fit if running >0;
gen stderror1 = stderror if running < 0;
gen stderror2 = stderror if running >0;

gen int1U = fit1 + 1.65*stderror1;
gen int1L = fit1 - 1.65*stderror1;
gen int2U = fit2 + 1.65*stderror2;
gen int2L = fit2 - 1.65*stderror2;

gen bin30 = int(running*30)/30;
sort bin30;
egen meanY30 = mean(pcorrupt) if esample2==1, by(bin30);


replace bin = . if bin<-.65;
replace bin = . if bin>.65;

replace meanY30 = . if meanY30>.15;
replace  int1U = . if  int1U>.15;
replace  int2U = . if  int2U>.15;

twoway (scatter meanY30 bin , msymbol(oh) sort xline(0, lpattern(solid) lwidth(thin) lcolor(gs5))) (line fit1 bin , sort legend(off) lstyle(p1solid p2solid) lpattern(solid)  lcolor(black)  ) (line int1U  bin , sort legend(off)  lpattern(dash) lwidth(thin) lcolor(blue)  ) (line int1L bin , sort legend(off) lpattern(dash) lwidth(thin) lcolor(blue)  )  (line fit2 bin , sort legend(off) lstyle(p1solid p2solid) lpattern(solid)  lcolor(black)) (line int2U  bin , sort legend(off)  lpattern(dash) lwidth(thin) lcolor(blue) ) (line int2L bin , sort legend(off)  lpattern(dash) lwidth(thin) lcolor(blue) ), xtitle(Margin of victory) saving(rdd_graph, replace) ytitle(Corruption )  ylabel(0(.05).15);

log close;
exit;




