# Subset World Values Survey for problem set

load('data/WVS_Cross-National_Wave_7_R_v1_4.RData')


# Keep a sample
wvs <- `WVS_Cross-National_Wave_7_R_v1_4`[,1:348]

# Save sample
save(wvs, file = 'data/World_Values_Survey_Wave_7_Sample.RData')