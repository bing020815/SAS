/* 1. extract the year of patients adminitered to hospital */
/* 2. calculate the number of days that patients stayed in hospital in two ways */
/* 3. creating a var containing today's date as analysis date  */

proc import datafile="/folders/myfolders/SAS/Data/patient_HD"
dbms=xlsx out=patient0 replace;
run;

data patient1;
set patient0;
s_year = year(start_date);
s_month = month(start_date);
days_in_hospital1 = intck('day', start_date, end_date);
days_in_hospital2 = datDIF(start_date, end_date, 'ACT/ACT');

analysis_date=today();
run;

proc print data=patient1;
format analysis_date MMDDYY10. ;
run;
