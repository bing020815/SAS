/* Sample Q22 */
data sasuser.one; 
x=1;
y=27;
   output one;
run;
/* The OUTPUT statement is told to use Work.One,  */
/* but it is not a data set that is speci ed on the DATA statement.  */
/* This generates a syntax error and stops the execution of the DATA step.  */
/* At compile time, a data set Sasuser. */
/* One with 2 variables and 0 observations would be created,  */
/* but only if it did not already exist.  */
/* A pre-existing Sasuser.One would not be affected by this DATA step. */


/* Sample Q26 */
Data CLASS;
Input Name $ Gender $ Age;
Datalines;
  Anna        F         23
  Ben         M         25
  Bob         M         21
  Brian       M         27
  Edward      M         26
  Emma        F         32
  Joe         M         34
  Sam         F         32
  Tom         M         24
;
Run;
data WORK.MALES WORK.FEMALES(drop=age);
   set WORK.CLASS;
   drop gender; /* the position of the drop does not effect the result */
   if Gender="M" then output WORK.MALES;
   else if Gender="F" then output WORK.FEMALES;
run;

/* Q93 */
Data sales_d;
Input SalesID $ SalesJan FebSales MarchAmt;
Datalines;
W6790 50 400 350
W7693 25 100 125
W1387 23 300 250
;
Run;
data qtr1;
set sales_d;
array month{3} SalesJan FebSales MarchAmt;
if salesid ='W1387' then salesjan =.;
Qtr_1 = month{1} + month{2} +month{3}; *does not work on missing values;
Qtr = sum(of month{*});
run;

/* Q94 */
data output;
set sashelp.class;
	BMI=(weight*703)/Height**2;
	if bmi ge 20; /* use IF when a new var is declared*/
	run;

/* Q88 */
data loop;
x=0;
do index =1 to 5 by 2; /* index: 1 3 5 7 */
	x=index; 			/*.   x: 1 3 5 */
end;
run;

/* Q87 */
data test1;
input name $ age;
datalines;
John +35.  /* either '+' or '-' works */
run;

/* Q78 */
proc means data = sashelp.air;
var air;
run;
	/* Default stats: N mean std min max */


/* Q9 */
data course; 
input exam; 
datalines; 
50.1
; run;
proc format;
value 
score 1 - 50 = 'Fail'
	  51 - 100 = 'Pass'; 
	  run;
proc report data =course nowd; 
column exam;
define exam / display format=score.; 
run;


/* Q11 */
proc format; 
value agegrp
low-12 ='Pre-Teen'
13-high = 'Teen'; 
run;
proc means data=SASHELP.CLASS min max mean maxdec=1; 
var Height;
class Sex Age;
format Age agegrp.;
run;
	/* Default stats: N mean std min max */
	

/* Q10 */
data work.retail;
cost = "$20,000";
discount = 0.1*cost;
run;
/* charactor contains $ or , cannot be automatically converted to numeric */
	
	
/* Q4 */
data work.date;
x =mdy('01', '01', '1960');
day = day(x);
month = month(x);
year = year(x);
weekday = weekday(x);
format x Date9.;
run;