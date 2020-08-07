/* Instruction: */
/* 1. Create a temporary SAS data 'scoredata0' by importing an excel data file */
/* 'score_data.xlsx' into SAS */
/*  */
/* 2. Create a permanent SAS data set score.scoredata from 'scoredata0' */
/*  */
/* 3. Go to libraries folder in SAS studio, find the data sets in the WORK library */
/*  */
/* 4. Both data sets should have 11 observations and 5 variables */

libname score "/folders/myfolders";

proc import datafile='/folders/myfolders/SAS/Data/score_data'  
dbms=xlsx out=scoredata0 replace;
run;

proc print data=work.scoredata0;
run;

data score.score_data;
/* use set to point the temporary dataset */
set scoredata0;
run;

proc print data=score.score_data;
run;