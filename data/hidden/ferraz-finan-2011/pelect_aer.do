#delimit ;
clear;

******************************************************************;
* This file estiamtes the probability of gettign reelected for 
* municipalities that were not audited prior to the elections. 
******************************************************************;
set more off;
set mem 100m;
set matsize 500;
capture log close;
log using pelectdata_aer.log, replace;



use pelectdata_aer, replace;

logit reeleito00_04  cd_age cd_educ2000 cd_sexo2000 $party  $munichar2 uf_d* if treat2~=1 , robust;
predict pelect, p;
gen elected1 = pelect>=.5;
keep elected1 cod_ibge6;
sort cod_ibge6;
save pscoredata_aer, replace;


