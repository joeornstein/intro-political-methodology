/*
The included Stata syntax files and data
produce the results for the paper
Hill, Seth J., Daniel J. Hopkins, and Gregory A. Huber. "Demographic Change, Threat, and Presidential Voting: Evidence from U.S. Electoral Precincts, 2012 to 2016."

Execute this do file in the statistical programs
Stata after setting the working directory, then
execute the R syntax files.
*/

/*******************
File descriptions
00_RunAnalysisAndREADME.do -- this file
01_AnalyzePooledPrecinctLevelFiles.do -- executes main precinct analysis
02_AnalyzeCountyLevelFiles.do -- executes county-level analysis
03_PlotImmigResults.R -- plots results with output from previous files
04_AnalyzeGeographicScope.do -- executes analysis for geographic scope
05_Descriptive Statistics.R -- create table of descriptive statistics
99_saveresults.do -- auxillary file
CountyData.dta -- data file of county observations
CountyHispanicChanges.dta -- data file of county Hispanic population changes
GeographicScopeData.dta -- data file with precinct data at different levels of aggregation
PrecinctData.dta -- data file of precinct observations
Figures/ -- folder for storing figure output
Tables/ -- folder for storing tabular output
*******************/

capture ssc install outreg2
capture mkdir Figures
capture mkdir Tables

do 01_AnalyzePooledPrecinctLevelFiles.do
do 02_AnalyzeCountyLevelFiles.do
do 04_AnalyzeGeographicScope.do

