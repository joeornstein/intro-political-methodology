#
# PlotImmigResults.R
#
# Make descriptive statistics table for Hill Hopkins Huber demographics paper.
#


rm(list=ls())
if (.Platform$OS == "windows") {
  # Set working directory in location of script.
  .doit <- function() { # only works with R.exe; trap errors if using Rscript.exe
  f_f <- lapply(sys.frames(),function(x) x$ofile);f_f <- Filter(Negate(is.null),f_f) ; PTH <- dirname(f_f[[length(f_f)]]); setwd(PTH) ; rm(PTH,f_f)
  }
  try(.doit(),silent=T)
}

library(xtable)
library(haven)


dta <- read_dta("PrecinctData.dta")

colnames(dta) <- gsub("_", ".", colnames(dta))


### make table of census descriptive stats ----
cn <- colnames(dta)[grep("l[01][016]", colnames(dta))]

rmat <- matrix(NA, length(cn), 7)
rownames(rmat) <- cn
colnames(rmat) <- c("FL", "GA", "MI", "NV", "OH", "PA", "WA")
for(i in 1:length(cn)) {
  rmat[i, 1] <- mean(dta[dta$st == "FL", cn[i]][[1]], na.rm = T)
  rmat[i, 2] <- mean(dta[dta$st == "GA", cn[i]][[1]], na.rm = T)
  rmat[i, 3] <- mean(dta[dta$st == "MI", cn[i]][[1]], na.rm = T)
  rmat[i, 4] <- mean(dta[dta$st == "NV", cn[i]][[1]], na.rm = T)
  rmat[i, 5] <- mean(dta[dta$st == "OH", cn[i]][[1]], na.rm = T)
  rmat[i, 6] <- mean(dta[dta$st == "PA", cn[i]][[1]], na.rm = T)
  rmat[i, 7] <- mean(dta[dta$st == "WA", cn[i]][[1]], na.rm = T)
}


rownames(rmat) <- c("Has BA or More `16", "Non-white, Non-Hisp. `16", 
                    "Hispanic `11", "Non-Cit. For. Born. `11", 
                    "Pct. Under Poverty Line `11", "Unemployed `11", 
                    "Pct. Empl. in Manufacturing `11", "Avg. Rent (1000s) `11", 
                    "Med. Grs. Rent / Hsh. Inc. `11", "Pct. Homes > $150 `11", 
                    "Pop. Density `11", "Non-Hisp. Black `11", 
                    "Has BA or More `11", "Non-white, Non-Hisp. `11", 
                    "Hispanic `00", "Non-Cit. For. Born `00", 
                    "Pct. Under Poverty Line `00", "Unemployed `00",
                    "Pct. Empl. in Manufacturing `00", "Pop. Density `00", 
                    "Non-Hisp. Black `00", "Has BA or More `00")
rmat <- rmat[c(22, 13, 1, 14, 2, 21, 12, 15, 3, 16, 4, 17, 5, 18, 6, 19, 7, 20, 11, 8, 9, 10),]

sink("Tables/DescriptiveStatisticsMeansByState.tex")
print(xtable(rmat))
sink()

sink("Tables/DescriptiveStatisticsMeansByState.txt")
print(round(rmat, 2))
sink()

