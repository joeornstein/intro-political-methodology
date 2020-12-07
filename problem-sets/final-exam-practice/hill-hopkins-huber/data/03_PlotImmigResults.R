#
# PlotImmigResults.R
#
# Make plots for Hill Hopkins Huber demographics paper.
#

rm(list=ls())
if (.Platform$OS == "windows") {
  # Set working directory in location of script.
  .doit <- function() { # only works with R.exe; trap errors if using Rscript.exe
  f_f <- lapply(sys.frames(),function(x) x$ofile);f_f <- Filter(Negate(is.null),f_f) ; PTH <- dirname(f_f[[length(f_f)]]); setwd(PTH) ; rm(PTH,f_f)
  }
  try(.doit(),silent=T)
}
if (!"bit64" %in% installed.packages()[, 1]) {
  install.packages("bit64")
}
library(bit64)
if (!"data.table" %in% installed.packages()[, 1]) {
  install.packages("data.table")
}
library(data.table)
options(stringsAsFactors=F)
library(RColorBrewer)
palette(brewer.pal(n=9,name="Set1")[c(1:5,7:9)]) # reset default colors
options(digits=4)

#
# Simple scatter plots of change in GOP share on change
# in Hispanic population, variously measured.
#

# Outsheeted from AnalyzePooledPrecintLevelFiles.do
DT = fread("Figure01DataForR.csv")
.myPlot <- function(x,y,n.points=2e03,ylim=c(-.4,.4),...) {
  # Plot n.points sample of points.
  samp = sample(seq_len(length(x)),size=n.points)
  # Make the scatter as we like it.
  plot(x=x[samp],y=y[samp],type='n',axes=F,ylim=ylim,...)
  grid();axis(2,las=2);axis(1)
  points(x=x[samp],y=y[samp],col=rgb(0,0,0,alpha=.2),pch=19)
  # Smoother on interior 90% of data.
  #int.90 = x <= quantile(x,.95) & x >= quantile(x,.05)
  #lines(loess.smooth(y=y[int.90],x=x[int.90],span=.2),lwd=3,col=3,...)
  # Truncate top 5%.
  #int.90 = x <= quantile(x,.95) & x >= quantile(x,.05)
  lines(loess.smooth(y=y,x=x,span=.2),lwd=3,col=3)
}

int.90 <- function(x) {
  # Return boolean for data in the interior 90% of data.
  x <= quantile(x,.95,na.rm=T) & x >= quantile(x,.05,na.rm=T)
}

fname = "Figure01-BaseScatters"
pdf(sprintf("Figures/%s.pdf",fname),width=9,height=6)
par.old <- par(mar=c(4.1,4.1,1.1,1.1),cex.lab=1.3)
  # interior 90% of data, no log scale
  # On d1611.
  DT[int.90(d1611_hispanic),.myPlot(x=d1611_hispanic,y=gop_propvote_change,ylab="Change in GOP share, 2012 to 2016",xlab="Change in population share Hispanic, 2011 to 2016")]
  # On d1600.
  DT[int.90(d1600_hispanic),.myPlot(x=d1600_hispanic,y=gop_propvote_change,ylab="Change in GOP share, 2012 to 2016",xlab="Change in population share Hispanic, 2000 to 2016")]
  # interion 90% of data
  # On dprop1611.
  DT[int.90(dprop1611_hispanic_notopcode),.myPlot(x=dprop1611_hispanic_notopcode,y=gop_propvote_change,ylab="Change in GOP share, 2012 to 2016",xlab="Proportional change in population Hispanic, 2011 to 2016")]
  # On dprop1600.
  DT[int.90(dprop1600_hispanic_notopcode),.myPlot(x=dprop1600_hispanic_notopcode,y=gop_propvote_change,ylab="Change in GOP share, 2012 to 2016",xlab="Proportional change in population Hispanic, 2000 to 2016")]
dev.off()


#
# Coefplot of effect of changing Hispanic population
# on change in Republican vote share, 2012 to 2016.
#

# Coefficients from AnalyzePooledPrecintLevelFiles.do
coefs = fread("Tables/Table01_WeightedFullSample_summaryresultstograph.csv")
.makeCoefVars <- function(coefs,proportional.x10=TRUE) {
  # Make variables needed for .coefPlot.
  # Arguments.
  #  coefs -- data.table of coefficients
  #  proportional.x10 -- multiple proportional coefs by 10 for scale
  
  # Calculate ends of CIs.
  coefs[,lb := m_beta - 1.96*m_se]
  coefs[,ub := m_beta + 1.96*m_se]
  # Sort on order of coefficients.
  setkey(coefs,m_beta)
  # Drop changes 2000 to 2011.
  coefs = coefs[regexpr("2011 - 2000",m_iv) == -1,]
  # Identify changes 2011 to 2016 vs 2000 to 2016.
  coefs[,from.2000 := regexpr("2000",m_iv) != -1]
  # Identify proportion vs levels.
  coefs[,proportional := regexpr("^Prop",m_iv) != -1]
  # Create pchs.
  pchs = unique(coefs[,c("from.2000","proportional")])
  pchs[,pch := c(12,8,15,19)]
  coefs = merge(coefs,pchs,by=c("from.2000","proportional"))
  # Create numeric version of m_modeltitle.
  coefs[,m_modeltitle_num := as.numeric(as.factor(m_modeltitle))]
  if (proportional.x10) {
    # Multiply proportional coefs by 10.
    coefs[proportional==T,m_beta := m_beta*10]
    coefs[proportional==T,m_se := m_se*10]
    coefs[proportional==T,lb := lb*10]
    coefs[proportional==T,ub := ub*10]
  }
  # Note whether or not coefs have been multiplied by 10.
  coefs[,proportional.x10 := proportional.x10]
  # Sort on model order.
  setkey(coefs,m_modeltitle_num,proportional,from.2000)
  return(coefs)
}
coefs = .makeCoefVars(coefs)

.coefPlot <- function(coefs,fname=NULL,xlab="Relationship between increasing Hispanic population and GOP vote share") {
  # Make a coefficient plot and write out model names.
  # Arguments.
  #  coefs -- data.table of coefficient estimates.
  #  fname -- file name for saving figure and notes text; when NULL, plots to screen
  #  xlab -- xlab for figure
  
  if (!is.null(fname)) { pdf(sprintf("Figures/%s.pdf",fname),width=10,height=6) }
  par.old <- par(mar=c(3.1,3.1,1.1,1.1),cex.lab=1.2)#
  coefs[,plot(x=range(c(ub,lb,0.005)),y=c(1,.N),type='n',ann=F,axes=F)]
  grid(lwd=2);axis(1)
  abline(v=0,lty=2,lwd=2,col='gray')
  title(xlab=xlab, ylab="Model version",line=2)
  axis(2,las=2,labels=coefs[,m_modeltitle_num],at=coefs[,seq_len(.N)])
  # CI.
  coefs[,segments(x0=lb,x1=ub,y0=seq_len(.N))]
  # Point estimate.
  coefs[,points(x=m_beta,y=seq_len(.N),pch=pch,cex=1.5)]
  # Legend for point types.
  pchs = unique(coefs[,c("from.2000","proportional","proportional.x10","pch")])  
  pchs[,legend := sprintf("%s, %s to 2016",ifelse(proportional,ifelse(proportional.x10,"Proportional change/10","Proportional change"),"Change in levels"),ifelse(from.2000,"2000","2011"))]
  pchs[,legend('topleft',legend=legend,pch=pch,bg='white',pt.cex=1.5)]
  par(par.old)
  if (!is.null(fname)) { dev.off() }

  if (!is.null(fname)) { 
    # Write out to text a note mapping model code to 
    # model name.
    mods = unique(coefs[,c("m_modeltitle_num","m_modeltitle")][order(m_modeltitle_num)])
    mods[,txt := sprintf("(%s) %s",m_modeltitle_num,m_modeltitle)]
    mods[,txt := gsub("Republican","GOP",txt)]
    mods[,txt := gsub("Other Changes","Demographics",txt)]
    # Write out note.
    write(paste(mods[,txt],collapse="; "),file=sprintf("Figures/%s-Notes.txt",fname))
  }
}

# Make plot.
.coefPlot(coefs,fname="Figure02-CoefficientVariation")


#
# Coefplot of effect of changing Non-citizen Foreign-born population
# on change in Republican vote share, 2012 to 2016.
#

# Coefficients from AnalyzePooledPrecintLevelFiles.do
coefs = fread("Tables/AppendixTable07_ForeignBorn_summaryresultstograph.csv")
coefs = .makeCoefVars(coefs)
# Make plot.
.coefPlot(coefs,fname="FigureA01-CoefficientVariationNCFB",xlab="Relationship between increasing Non-citizen Foreign-born population and GOP vote share")
