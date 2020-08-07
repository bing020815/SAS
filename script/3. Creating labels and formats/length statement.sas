/* LENGTH statement */

proc import datafile='/folders/myfolders/SAS/Data/score_data_miss'
dbms = xlsx out=scoredata0 replace ;
run ;

data scoredata1 ;
set scoredata0 ;
if gender = 'm' then gender_full = 'Male';
else if gender = 'f' then gender_full = 'Female' ;
else gender_full = 'missing'; 
run ; 

data scoredata2; 
set scoredata0 ; 
/* length statement must be placed before ay reference to the variable */
length gender_full $7;
if gender = 'm' then gender_full = 'Male' ; 
else if gender = 'f' then gender_full = 'Female' ;
else gender_full = 'missing' ;
run ; 

proc print data=scoredata1;
title "Trucated Variable values" ;
run ; 

proc print data = scoredata2 ;
title 'Complete Variable values' ; 
run; 