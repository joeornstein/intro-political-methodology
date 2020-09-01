#Load the data
load("data/anes_pilot_2019.RData")
#Summarize the data
#number of observations
nrow(data)
#3165

#number of variables
ncol(data)
#900

#names of variables
names(data)
#"version"                      "caseid"                       "weight"                       "weight_spss"                  "form"                        
#"follow"                       "reg1a"                        "reg1b"                        "liveurban"                    "youthurban"                  
#"placeid1a"                    "placeid1a_t"                  "placeid1b"                    "placeidimport"                "turnout16a"                  
#"turnout16a1"                  "turnout16b"                   "turnout16c"                   "vote16"                       "turnout18a"                  
#"turnout18a1"                  "particip_1"                   "particip_2"                   "particip_3"                   "particip_4"                  
#"particip_5"                   "particip_6"                   "particip_7"                   "particip_8"                   "particip_9"                  
#"fttrump"                      "ftobama"                      "ftbiden"                      "ftwarren"                     "ftsanders"                   
#"ftbuttigieg"                  "ftharris"                     "ftblack"                      "ftwhite"                      "fthisp"                      
#"ftasian"                      "ftmuslim"                     "ftillegal"                    "ftimmig1"                     "ftimmig2"                    
#"ftjournal"                    "ftnato"                       "ftun"                         "ftice"                        "ftnra"                       
#"ftchina"                      "ftnkorea"                     "ftmexico"                     "ftsaudi"                      "ftukraine"                   
#"ftiran"                       "ftbritain"                    "ftgermany"                    "ftjapan"                      "ftisrael"                    
#"ftfrance"                     "ftcanada"                     "ftturkey"                     "ftrussia"                     "ftpales"                     
#"vote20dem"                    "vote20cand"                   "vote20cand2"                  "electable"                    "vote20jb"                    
#"vote20ew"                     "vote20bs"                     "cvote2020"                    "tsplit1"                      "contact1a"                   
#"contact1b"                    "contact2a"                    "contact2b"                    "contact3"                     "contact4m_1"                 
#"contact4m_2"                  "contact4m_3"                  "apppres5"                     "frnpres5"                     "immpres5"                    
#"econpres5"                    "apppres7"                     "frnpres7"                     "immpres7"                     "econpres7"                   
#"mip"                          "econnow"                      "finworry"                     "confecon"                     "improve1"                    
#"national1"                    "national2"                    "conspire1"                    "conspire2"                    "conspire3"                   
#"taxecon"                      "billtax"                      "trade1"                       "trade2"                       "trade3"                      
#"trade4"                       "richpoor2"                    "guarinc"                      "lcself"                       "lcd"                         
#"lcr"                          "pop1"                         "pop2"                         "pop3"                         "corrupt"                     
#"immignum"                     "refugees"                     "dreamstr"                     "dreamer"                      "dreamstr1"                   
#"dreamstr2"                    "wall5"                        "wall7"                        "pathway"                      "preturn"                     
#"popen"                        "release1"                     "release2"                     "famsep"                       "tchina"                      
#"trussia"                      "tiran"                        "tmexico"                      "tjapan"                       "hlthcare1"                   
#"hlthcare2"                    "abortion1"                    "abortion2"                    "freecol"                      "loans"                       
#"diversity5"                   "diversity7"                   "language"                     "buyback"                      "gw1"                         
#"gw2"                          "knowopioid1"                  "knowopioid2"                  "opioiddo"                     "sentence"                    
#"prek"                         "demo4"                        "experts"                      "science"                      "exphelp"                     
#"elite1"                       "elite2"                       "elite3"                       "elite4"                       "ukraine1"                    
#"ukraine2"                     "excessive"                    "rural1alt1"                   "rural1alt2"                   "rural2alt1"                  
#"rural2alt2"                   "rural3alt1"                   "rural3alt2"                   "rural4alt1"                   "rural4alt2"                  
#"conf_unemp"                   "unemp"                        "conf_interfere"               "interfere"                    "conf_autism"                 
#"autism1"                      "autism2"                      "conf_gmo"                     "gmo1"                         "gmo2"                        
#"conf_warm"                    "warm"                         "conf_illegal"                 "illegal"                      "impeach1"                    
#"impeach2"                     "pk_cjus"                      "pk_cjus_correct"              "pk_germ"                      "pk_germ_correct"             
#"pk_sen"                       "pk_spend"                     "pk_geer"                      "cheat"                        "pid7x"                       
#"pid1d"                        "pid2d"                        "pid1r"                        "pid2r"                        "pidstr"                      
#"pidlean"                      "ngun"                         "shooting"                     "dem_activduty"                "milyears"                    
#"milyr1"                       "milyr2"                       "milyr3"                       "milyr4"                       "milyr5"                      
#"milyr6"                       "combat"                       "harass1a"                     "harass1b"                     "rr1"                         
#"rr2"                          "rr3"                          "rr4"                          "health1a"                     "health1b"                    
#"hospital"                     "feet"                         "inches"                       "nweight"                      "bmi"                         
#"disable1"                     "disable2"                     "disable3"                     "disable4"                     "disable5"                    
#"disable6"                     "smoker1"                      "smoker2"                      "exercise"                     "relig1a"                     
#"relig1a_txt"                  "relig2a"                      "att1"                         "att2"                         "att3"                        
#"relig1b"                      "relig1b_t"                    "relig2b"                      "relig3b"                      "relig3b_t"                   
#"attother"                     "exptravel_ever"               "exphomesch"                   "expfarm"                      "expffood"                    
#"expconvert"                   "expholiday"                   "explie"                       "expshark"                     "expdivorce"                  
#"exparrest"                    "expoverdose"                  "expdefault"                   "exppubasst"                   "exphybrid"                   
#"expmistake"                   "explightning"                 "exptravel_year"               "expindian"                    "exphunt"                     
#"expflag"                      "exppublib"                    "explottery"                   "expshoponline"                "exppubtrans"                 
#"expfight"                     "expavoid"                     "expknowimmig"                 "expknowtrans"                 "expbuyusa"                   
#"expretire"                    "expcolldebt"                  "expknowpris"                  "socmed_1"                     "socmed_2"                    
#"socmed_3"                     "socmed_4"                     "socmed_5"                     "socmed_6"                     "socmed_7"                    
#"socmed_8"                     "socmed_9"                     "socmed_t"                     "facebook1"                    "facebook2"                   
#"facebook3"                    "twitter1"                     "twitter2"                     "twitter3"                     "instagram1"                  
#"instagram2"                   "instagram3"                   "reddit1"                      "reddit2"                      "reddit3"                     
#"youtube1"                     "youtube2"                     "youtube3"                     "snapchat1"                    "snapchat2"                   
#"snapchat3"                    "tiktok1"                      "tiktok2"                      "tiktok3"                      "raceid"                      
#"racework"                     "whitejob"                     "race_sub1"                    "race_sub2"                    "voterid1"                    
#"voterid2"                     "serious"                      "photo1"                       "photo2"                       "photo3"                      
#"photo4"                       "reinterview"                  "birthyr"                      "gender"                       "educ"                        
#"marstat"                      "child18"                      "race"                         "employ"                       "employ_t"                    
#"faminc_new"                   "votereg"                      "ideo5"                        "pid7"                         "newsint"                     
#"presvote16post"               "presvote16post_t"             "pew_bornagain"                "pew_religimp"                 "pew_churatd"                 
#"pew_prayer"                   "religpew"                     "religpew_t"                   "religpew_protestant"          "religpew_protestant_t"       
#"inputstate"                   "zipCode"                      "FIPCounty"                    "region"                       "EnrollmentDate"              
#"CompletedSurveys"             "qualityControl_overall_scale" "tsmart_P2012"                 "tsmart_G2012"                 "tsmart_P2016"                
#"tsmart_G2016"                 "tsmart_P2018"                 "tsmart_G2018"                 "abortion1_skp"                "abortion2_skp"               
#"apppres5_skp"                 "apppres7_skp"                 "att1_skp"                     "att2_skp"                     "att3_skp"                    
#"attother_skp"                 "autism1_skp"                  "autism2_skp"                  "billtax_skp"                  "buyback_skp"                 
#"cexp1_grid_skp"               "cexp2_grid_skp"               "cheat_skp"                    "combat_skp"                   "confecon_skp"                
#"conspire1_skp"                "conspire2_skp"                "conspire3_skp"                "contact1a_skp"                "contact1b_skp"               
#"contact2a_skp"                "contact2b_skp"                "contact3_skp"                 "corrupt_skp"                  "cvote2020_skp"               
#"dem_activduty_skp"            "demo4_skp"                    "disable_grid_skp"             "diversity5_skp"               "diversity7_skp"              
#"dreamer_skp"                  "econnow_skp"                  "econpres5_skp"                "econpres7_skp"                "electable_skp"               
#"elite1_skp"                   "elite2_skp"                   "elite3_skp"                   "elite4_skp"                   "excessive_skp"               
#"exercise_skp"                 "exp1_grid_skp"                "exp2_grid_skp"                "experts_skp"                  "exphelp_skp"                 
#"facebook1_skp"                "facebook2_skp"                "facebook3_skp"                "finworry_skp"                 "follow_skp"                  
#"freecol_skp"                  "frnpres5_skp"                 "frnpres7_skp"                 "ftasian_skp"                  "ftbiden_skp"                 
#"ftblack_skp"                  "ftbritain_skp"                "ftbuttigieg_skp"              "ftcanada_skp"                 "ftchina_skp"                 
#"ftfrance_skp"                 "ftgermany_skp"                "ftharris_skp"                 "fthisp_skp"                   "ftice_skp"                   
#"ftillegal_skp"                "ftimmig1_skp"                 "ftimmig2_skp"                 "ftiran_skp"                   "ftisrael_skp"                
#"ftjapan_skp"                  "ftjournal_skp"                "ftmexico_skp"                 "ftmuslim_skp"                 "ftnato_skp"                  
#"ftnkorea_skp"                 "ftnra_skp"                    "ftobama_skp"                  "ftpales_skp"                  "ftrussia_skp"                
#"ftsanders_skp"                "ftsaudi_skp"                  "fttrump_skp"                  "ftturkey_skp"                 "ftukraine_skp"               
#"ftun_skp"                     "ftwarren_skp"                 "ftwhite_skp"                  "gmo1_skp"                     "gmo2_skp"                    
#"guarinc_skp"                  "gw_grid_skp"                  "harass1a_skp"                 "harass1b_skp"                 "health1a_skp"                
#"health1b_skp"                 "hlthcare1_skp"                "hlthcare2_skp"                "hospital_skp"                 "illegal_skp"                 
#"immignum_skp"                 "immpres5_skp"                 "immpres7_skp"                 "impeach1_skp"                 "impeach2_skp"                
#"improve1_skp"                 "instagram1_skp"               "instagram2_skp"               "instagram3_skp"               "interfere_skp"               
#"knowopioid1_skp"              "knowopioid2_skp"              "language_skp"                 "lc_grid_skp"                  "liveurban_skp"               
#"loans_skp"                    "milyears_skp"                 "milyr_skp"                    "mip_skp"                      "national1_skp"               
#"national2_skp"                "ngun_skp"                     "opioiddo_skp"                 "particip_skp"                 "path_grid_skp"               
#"pid1d_skp"                    "pid1r_skp"                    "pidlean_skp"                  "pidstr_skp"                   "pk_cjus_skp"                 
#"pk_geer_skp"                  "pk_germ_skp"                  "pk_sen_skp"                   "pk_spend_skp"                 "placeid1a_skp"               
#"placeid1b_skp"                "placeidimport_skp"            "pop_grid_skp"                 "prek_skp"                     "raceid_skp"                  
#"racework_skp"                 "reddit1_skp"                  "reddit2_skp"                  "reddit3_skp"                  "refugees_skp"                
#"reg1a_skp"                    "reg1b_skp"                    "reinterivew_skp"              "relig1a_skp"                  "relig1b_skp"                 
#"relig2a_skp"                  "relig2b_skp"                  "relig3b_skp"                  "rexp1_grid_skp"               "rexp2_grid_skp"              
#"richpoor2_skp"                "rr_grid_skp"                  "rural1alt1_skp"               "rural1alt2_skp"               "rural2alt1_skp"              
#"rural2alt2_skp"               "rural3alt1_skp"               "rural4alt1_skp"               "rural4alt2_skp"               "science_skp"                 
#"sentence_skp"                 "serious_skp"                  "shooting_skp"                 "smoker1_skp"                  "smoker2_skp"                 
#"snapchat1_skp"                "snapchat2_skp"                "snapchat3_skp"                "socmed_skp"                   "tall_skp"                    
#"taxecon_skp"                  "threat_grid_skp"              "tiktok1_skp"                  "tiktok2_skp"                  "tiktok3_skp"                 
#"trade1_skp"                   "trade2_skp"                   "trade3_skp"                   "trade4_skp"                   "tsplit1_skp"                 
#"turnout16a_skp"               "turnout16b_skp"               "turnout16c_skp"               "turnout18a_skp"               "twitter1_skp"                
#"twitter2_skp"                 "twitter3_skp"                 "ukraine1_skp"                 "ukraine2_skp"                 "unemp_skp"                   
#"vote16_skp"                   "vote20bs_skp"                 "vote20cand2_skp"              "vote20cand_skp"               "vote20dem_skp"               
#"vote20ew_skp"                 "vote20jb_skp"                 "voterid1_skp"                 "voterid2_skp"                 "wall7_skp"                   
#"wall5_skp"                    "warm_skp"                     "nweight_skp"                  "whitejob_skp"                 "youthurban_skp"              
#"youtube1_skp"                 "youtube2_skp"                 "youtube3_skp"                 "rural3alt2_skp"               "follow_page_timing"          
#"reg1a_page_timing"            "reg1b_page_timing"            "liveurban_page_timing"        "youthurban_page_timing"       "placeid1a_page_timing"       
#"placeid1b_page_timing"        "placeidimport_page_timing"    "turnout16a_page_timing"       "turnout16b_page_timing"       "turnout16c_page_timing"      
#"vote16_page_timing"           "turnout18a_page_timing"       "particip_page_timing"         "fttrump_page_timing"          "ftobama_page_timing"         
#"ftbiden_page_timing"          "ftwarren_page_timing"         "ftsanders_page_timing"        "ftbuttigieg_page_timing"      "ftharris_page_timing"        
#"ftblack_page_timing"          "ftwhite_page_timing"          "fthisp_page_timing"           "ftasian_page_timing"          "ftmuslim_page_timing"        
#"ftillegal_page_timing"        "ftimmig1_page_timing"         "ftimmig2_page_timing"         "ftjournal_page_timing"        "ftnato_page_timing"          
#"ftun_page_timing"             "ftice_page_timing"            "ftnra_page_timing"            "ftchina_page_timing"          "ftnkorea_page_timing"        
#"ftmexico_page_timing"         "ftsaudi_page_timing"          "ftukraine_page_timing"        "ftiran_page_timing"           "ftbritain_page_timing"       
#"ftgermany_page_timing"        "ftjapan_page_timing"          "ftisrael_page_timing"         "ftfrance_page_timing"         "ftcanada_page_timing"        
#"ftturkey_page_timing"         "ftrussia_page_timing"         "ftpales_page_timing"          "vote20dem_page_timing"        "vote20cand_page_timing"      
#"vote20cand2_page_timing"      "electable_page_timing"        "vote20jb_page_timing"         "vote20ew_page_timing"         "vote20bs_page_timing"        
#"cvote2020_page_timing"        "tsplit1_page_timing"          "contact1a_page_timing"        "contact1b_page_timing"        "contact2a_page_timing"       
#"contact2b_page_timing"        "contact3_page_timing"         "apppres5_page_timing"         "frnpres5_page_timing"         "immpres5_page_timing"        
#"econpres5_page_timing"        "apppres7_page_timing"         "frnpres7_page_timing"         "immpres7_page_timing"         "econpres7_page_timing"       
#"mip_page_timing"              "econnow_page_timing"          "finworry_page_timing"         "confecon_page_timing"         "improve1_page_timing"        
#"national1_page_timing"        "national2_page_timing"        "conspire1_page_timing"        "conspire2_page_timing"        "conspire3_page_timing"       
#"taxecon_page_timing"          "billtax_page_timing"          "trade1_page_timing"           "trade2_page_timing"           "trade3_page_timing"          
#"trade4_page_timing"           "richpoor2_page_timing"        "guarinc_page_timing"          "lc_grid_page_timing"          "pop_grid_page_timing"        
#"corrupt_page_timing"          "immignum_page_timing"         "refugees_page_timing"         "dreamer_page_timing"          "wall_page_timing"            
#"wall7_page_timing"            "path_grid_page_timing"        "threat_grid_page_timing"      "hlthcare1_page_timing"        "hlthcare2_page_timing"       
#"abortion1_page_timing"        "abortion2_page_timing"        "freecol_page_timing"          "loans_page_timing"            "diversity5_page_timing"      
#"diversity7_page_timing"       "language_page_timing"         "buyback_page_timing"          "gw_grid_page_timing"          "knowopioid1_page_timing"     
#"knowopioid2_page_timing"      "opioiddo_page_timing"         "sentence_page_timing"         "prek_page_timing"             "demo4_page_timing"           
#"experts_page_timing"          "science_page_timing"          "exphelp_page_timing"          "elite1_page_timing"           "elite2_page_timing"          
#"elite3_page_timing"           "elite4_page_timing"           "ukraine1_page_timing"         "ukraine2_page_timing"         "excessive_page_timing"       
#"rural1alt1_page_timing"       "rural1alt2_page_timing"       "rural2alt1_page_timing"       "rural2alt2_page_timing"       "rural3alt1_page_timing"      
#"rural3alt2_page_timing"       "rural4alt1_page_timing"       "rural4alt2_page_timing"       "unemp_page_timing"            "interfere_page_timing"       
#"autism1_page_timing"          "autism2_page_timing"          "gmo1_page_timing"             "gmo2_page_timing"             "warm_page_timing"            
#"illegal_page_timing"          "impeach1_page_timing"         "impeach2_page_timing"         "pk2_intro_page_timing"        "pk_cjus_page_timing"         
#"pk_germ_page_timing"          "pk_sen_page_timing"           "pk_spend_page_timing"         "pk_geer_page_timing"          "cheat_page_timing"           
#"pid1d_page_timing"            "pid1r_page_timing"            "pidstr_page_timing"           "pidlean_page_timing"          "ngun_page_timing"            
#"shooting_page_timing"         "dem_activduty_page_timing"    "milyears_page_timing"         "milyr_page_timing"            "combat_page_timing"          
#"harass1a_page_timing"         "harass1b_page_timing"         "rr_grid_page_timing"          "health1a_page_timing"         "health1b_page_timing"        
#"hospital_page_timing"         "tall_page_timing"             "nweight_page_timing"          "disable_grid_page_timing"     "smoker1_page_timing"         
#"smoker2_page_timing"          "exercise_page_timing"         "relig1a_page_timing"          "relig2a_page_timing"          "att1_page_timing"            
#"att2_page_timing"             "att3_page_timing"             "relig1b_page_timing"          "relig2b_page_timing"          "relig3b_page_timing"         
#"attother_page_timing"         "exp1_grid_page_timing"        "exp2_grid_page_timing"        "rexp1_grid_page_timing"       "rexp2_grid_page_timing"      
#"cexp1_grid_page_timing"       "cexp2_grid_page_timing"       "socmed_page_timing"           "facebook1_page_timing"        "facebook2_page_timing"       
#"facebook3_page_timing"        "twitter1_page_timing"         "twitter2_page_timing"         "twitter3_page_timing"         "instagram1_page_timing"      
#"instagram2_page_timing"       "instagram3_page_timing"       "reddit1_page_timing"          "reddit2_page_timing"          "reddit3_page_timing"         
#"youtube1_page_timing"         "youtube2_page_timing"         "youtube3_page_timing"         "snapchat1_page_timing"        "snapchat2_page_timing"       
#"snapchat3_page_timing"        "tiktok1_page_timing"          "tiktok2_page_timing"          "tiktok3_page_timing"          "raceid_page_timing"          
#"racework_page_timing"         "whitejob_page_timing"         "voterid1_page_timing"         "voterid2_page_timing"         "serious_page_timing"         
#"photo1_page_timing"           "photo2_page_timing"           "photo3_page_timing"           "photo4_page_timing"           "reinterview_page_timing"     
#"ord_fttrump"                  "ord_ftobama"                  "ord_ftbiden"                  "ord_ftwarren"                 "ord_ftsanders"               
#"ord_ftbuttigieg"              "ord_ftharris"                 "ord_ftblack"                  "ord_ftwhite"                  "ord_fthisp"                  
#"ord_ftasian"                  "ord_ftmuslim"                 "ord_ftillegal"                "ord_ftimmig1"                 "ord_ftimmig2"                
#"ord_ftjournal"                "ord_ftnato"                   "ord_ftun"                     "ord_ftice"                    "ord_ftnra"                   
#"ord_ftchina"                  "ord_ftnkorea"                 "ord_ftmexico"                 "ord_ftsaudi"                  "ord_ftukraine"               
#"ord_ftiran"                   "ord_ftbritain"                "ord_ftgermany"                "ord_ftjapan"                  "ord_ftisrael"                
#"ord_ftfrance"                 "ord_ftcanada"                 "ord_ftturkey"                 "ord_ftrussia"                 "ord_ftpales"                 
#"ord_electable_1"              "ord_electable_2"              "ord_conspire1"                "ord_conspire2"                "ord_conspire3"               
#"ord_lcself"                   "ord_lcd"                      "ord_lcr"                      "ord_pathway"                  "ord_preturn"                 
#"ord_popen"                    "ord_release1"                 "ord_release2"                 "ord_famsep"                   "ord_tchina"                  
#"ord_trussia"                  "ord_tiran"                    "ord_tmexico"                  "ord_tjapan"                   "ord_gw1"                     
#"ord_gw2"                      "ord_elite1"                   "ord_elite2"                   "ord_elite3"                   "ord_elite4"                  
#"ord_disable1"                 "ord_disable2"                 "ord_disable3"                 "ord_disable4"                 "ord_disable5"                
#"ord_disable6"                 "ord_exptravel_ever"           "ord_exphomesch"               "ord_expfarm"                  "ord_expffood"                
#"ord_expconvert"               "ord_expholiday"               "ord_explie"                   "ord_expshark"                 "ord_expdivorce"              
#"ord_exparrest"                "ord_expoverdose"              "ord_expdefault"               "ord_exppubasst"               "ord_exphybrid"               
#"ord_expmistake"               "ord_explightning"             "ord_exptravel_year"           "ord_expindian"                "ord_exphunt"                 
#"ord_expflag"                  "ord_exppublib"                "ord_explottery"               "ord_expshoponline"            "ord_exppubtrans"             
#"ord_expfight"                 "ord_expavoid"                 "ord_expknowimmig"             "ord_expknowtrans"             "ord_expbuyusa"               
#"ord_expretire"                "ord_expcolldebt"              "ord_expknowpris"              "ord_lc_reverse"               "ord_att2_reverse"            
#"starttime"                    "endtime"                      "duration"                     "pop_density_public"           "flag_state"                  

#Clean up the data

#create new variable called age, and set it equal to the current year - birth year
age<-2020-data$birthyr

#median of ages
median(age)
#56

#create a histogram of age
hist(age)

#create a table of "vote16"
table(data$vote16)
#603

#represent missing value with NA
data$vote16[data$vote16 == -1] <- NA

#create a table of "vote16"
table(data$vote16)

#Explore the data

#create a table of liveurban
table(data$liveurban)
#respondents most likely to live in a suburb (1117)

#create a two-way table with liveurban and vote20jb
table(data$liveurban, data$vote20jb)
#rural respondents most likely to vote for Donald Trump,
#urban respondents probably not vote

#summarize youthurban, placeid1b, cvote2020.
table(data$youthurban)
#648 respondents grew up in a rural area, 728 in a small town, 900 in a suburb, and 889 in a city.

#summarize placeid1b.
table(data$placeid1b)
#represent missing value with NA
data$placeid1b[data$placeid1b == -1] <- NA
#create table of placeid1b.
table(data$placeid1b)
#355 respondents feel belong to cities, 481 to suburbs, 360 to small towns, and 383 to countryside(rural areas).

#summarize cvote2020.
table(data$cvote2020)
#1357 respondents most likely to vote for the U.S. House of Representatives for Democrat, 1233 will vote for Republican, 108 will vote for other, 184 will not vote, and 283 said don't know.  