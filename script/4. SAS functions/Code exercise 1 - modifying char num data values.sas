/* 1. create new vars DOB_year, DOB_month, DOB_day by extracting year and date  */
/* from var DOB using SCAN; extracting month from var DOB using SUBSTR */

/* 2. creating new vars DOB_new1, DOB_new2 by concatenating vars DOB_year,  */
/* DOB_month, DOB_day using TRIM and CATX; the new values will be in  */
/* the form of 2007, 9, 23 */

/* 3. Using TRANWRD to replace 'missing' with '' in var raw_score  */

/* 4. using index function to search for 2007 in the values of DOB, then to create */
/* a subset data CD2 */

proc import datafile="/folders/myfolders/SAS/Data/chara_data2"
dbms=xlsx out=dataset0 replace;
run;

data dataset1;
set dataset0;
DOB_year = scan(DOB, 3, '/');
DOB_month = substr(DOB, 1, 1); 
DOB_day = scan(DOB, 2, '/');
length DOB_new1 $11;
DOB_new1 = trim(DOB_year) || ', ' || trim(DOB_month) || ', ' || trim(DOB_day);
length DOB_new2 $11;
DOB_new2 = CATX(', ', DOB_year, DOB_month, DOB_day);
score_update = TRANWRD(raw_score, 'missing', '');
run;

data CD2;
set dataset1;
temp = index(DOB, '2007');
if temp > 0;
drop temp;
run;

proc print data=CD2; 
run;

