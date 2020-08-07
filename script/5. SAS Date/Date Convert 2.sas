/* MDY(month, day, year) */
/* create  data scoredata0 */
proc import datafile='/folders/myfolders/SAS/Data/SAS date'
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0;
Bdate = mdy(month, day, year);
fix_date1 = mdy(8, 31, 1950);
fix_date2 = mdy(8, 31, 2050);
fix_date3 = mdy(8, 31, 50);
run;

/* YEARCUTOFF: provide the prfix first two digits */

proc print data= scoredata1;
format Bdate MMDDYY10. fix_date1 date9. fix_date2 date9. fix_date3 date9.;
run;


/*  */
/* WEEKDAY(date) */
/* 1:Sunday */
/* 2:Monday */
/* 3:Tuesday */
/* 4:Wednesday */
/* 5:Thursday */
/* 6:Friday */
/* 7:Saturday */

/* create  data scoredata0 */
proc import datafile='/folders/myfolders/SAS/Data/SAS date'
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0;
/* show the SAS date values for start_date */
sdate = start_date;
run;

data scoredata2;
set scoredata1;

s_year1 = year(start_date);
s_qtr = qtr(start_date);
s_month = month(start_date);
s_day = day(start_date);
s_weekday = WEEKDAY(start_date);
run;

data scoredata3;
set scoredata2;
/* indicating a data error : Sunday or Saturday*/
if s_weekday in (1,7); 
run;


/* INTCK('interval', from, to) */
/* create  data scoredata0 */
proc import datafile='/folders/myfolders/SAS/Data/SAS date'
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0;
today_date1 = today();
today_date2 = date();
Years=intck('year', start_date, today());
Months=intck('month', start_date, today());
run;

proc print data = scoredata1;
format today_date1 today_date2 date9.; 
run;




/* DATAIF(start_date, end_date, basis) YRDIF(start_date, end_date, basis) */
/* create  data scoredata0 */
proc import datafile='/folders/myfolders/SAS/Data/SAS date'
dbms=xlsx out=scoredata0 replace;
run;
data scoredata1;
set scoredata0;
year_diff1 = YRDIF(start_date, today(), '30/360');
year_diff2 = YRDIF(start_date, '14jun2020'd, 'ACT/ACT');
year_diff3 = YRDIF(start_date, today(), 'ACT/360');
year_diff4 = YRDIF(start_date, '14jun2020'd, 'ACT/365');

day_diff1 = datDIF(start_date, today(),'30/360');
day_diff2 = datDIF(start_date, '14jun2020'd, 'ACT/ACT');
run;
proc print data=scoredata1;
run;