%let path = /folders/myfolders/cert_p;

/* Q1 */
/* libname to import input01.xlsx in input folder  */
libname te xlsx "&path/input/input01.xlsx";
proc contents data=te._all_ varnum;
run;
proc means data=te.sheetC mean sum; /* default: n mean std min max */
var height;
run;
proc print data=te.'sheet BB'n (obs=2 firstobs=2);
run;

/* Q2 */
/* proc import to import input02.xlsx in input folder  */
libname results "&path/output";
proc import datafile = "&path/input/input02.xlsx" 
dbms = xlsx out = results.output02 replace;
getnames = yes;
run;
libname results "&path/output";
proc format library=results; /* Permanent format */
value $fmt
      'bryant' = 'kobebryant'
	  'james' = 'lebronjames';
run;
proc format library=results fmtlib; /* list of user-defined format */
run;
options fmtsearch= (results work library) ;
data results.output02_1 results.output02_2 results.output02_3;
set results.output02;
format name $fmt.;
if name = 'jordan' then output results.output02_1;
else if name = 'bryant' then output results.output02_2;
else if name = 'james' then output results.output02_3;
run;
proc print data = results.output02_1;
title "results.output02_1";
*format name $fmt.;
run;
proc print data = results.output02_2;
title "results.output02_2";
*format name $fmt.;
run;
proc print data = results.output02_3;
title "results.output02_3";
*format name $fmt.;
run;


/* Q3 */
libname cert "&path/input";
Data cert.input03;
Input name $ city $ 3-10 major $ 12-27 class $ test1 test2 test3 test4;
Datalines;
A Beijing  math             senior 5 4 3 4
B Beijing  math             senior 2 1 1 5
C Tianjin  history          senior 5 5 5 5
D Shanghai history and ball junior 4 4 4 4
E Hebei    ball and reading junior 1 1 2 3
F Beijing  run              junior 2 2 1 2
G Beijing  run and ball     senior 5 4 5 1
;
Run;

libname results "&path/output";
data results.output03_1 (drop = i test1-test4);
set cert.input03;
i = index(major,'and');
/* INDEX return the starting position of the search and case insensitive*/
/* FIND return the starting position of the search and case sensitive */
/* use modifier 'i' on third argument to make it case insensitive */
if i not eq 0 then 
	do;
		second_major = substr(major,i+4, length(major));
		major = substr(major,1,i-2);
	end;
else second_major = 'none';
length grade $4;
testavg = mean(of test1-test4);
if testavg >= 3.5 then grade = 'good';
else if testavg < 3.5 then grade = 'bad';
run;
proc freq data = results.output03_1 nlevels;
tables major second_major;
run;
data results.output03_2;
set results.output03_1;
where class = 'senior' and city in ('Beijing','Tianjin'); 
if second_major='none' and grade = 'good';
run;
proc print data = results.output03_2;
run;


/* Q4 */
libname cert "&path/input";
Data cert.input04;
Input word $;
Datalines;
she
it
He
And
WHO
;
Run;

libname results "&path/output";
data results.output04 (drop = n rename=(word=WO));
set cert.input04;
n = length(word);
if n = 2 then Word = upcase(word);
run;
proc print data = results.output04;
run;


/* Q5 */
proc contents data = sashelp.class ;
run;


/* Q6 */
libname cert "&path/input";
Data cert.input06;
Input department $ income dollar6.;
Datalines;
Hr $1000
Eng $500
Hr $10000
Hr $7500
Eng $200
Clean $20
Eng $3000
Clean $10
;
Run;
libname results "&path/output";
proc sort data = cert.input06 out = results.output06_1;
by department descending income;
run;
data results.output06_2;
set results.output06_1;
by department descending income;
if first.department; /* must have BY in data step */
run;
proc print data = results.output06_2;
by department;
run;


/* Q7 */
/* Transpose */
/* ID: variables uses to form the names of variable in output data */
/* Var: variables to be transpos */
/* By:  variables uses to form BY groups */
Data cert.input07;
Input name $ Testdate Date9. Cholesterol Triglyc Uric;
Datalines;
May 01MAY2020 21 31 20
Rob 01MAY2020 18 23 20
Rick 01MAY2020 22 34 21
May 01JUN2020 24 19 21
Rob 01JUN2020 22 25 21
Rick 01JUN2020 26 32 21
May 01JUL2020 23 31 20
Rob 01JUL2020 19 22 20
Rick 01JUL2020 22 35 21
;
Run;
proc sort data=cert.input07;
by testdate;
run;
proc transpose data=cert.input07 out=results.output07; 
*var cholesterol triglyc uric;
id name;
by testdate;
run;
proc print data=results.output07; 
format testdate date9.;run;


/* Q8 */
libname exl xlsx "&path/input/input08.xlsx";
libname results "&path/output";
proc contents data=exl._all_;
run;
data results.output08;
set exl.state;
/* If n is greater than the number of words in expression, SCAN returns a blank */
province = scan(location,2,' ');
province = upcase(province);
if province not eq ' ' then 
	do;
		location = tranwrd(location, scan(location,2,' '), upcase(province));
	end;
run;
proc print data = results.output08;
run;

/* Q9 */
libname cert "&path/input";
Data cert.input09;
Input custID $;
Datalines;
ID1573
ID2369
ID5361
ID8902
;
Run;
libname results "&path/output";
data results.output09;
set cert.input09;
a = input(substr(custID,3,4),4.); *char (informat)-> num;
b = a * 1000;
substr(custID,3,4) = '9999';
run;
proc print data = results.output09;
run;

/* Q10 */
libname cert "&path/input";
Data cert.input10;
Input firstname $ lastname $;
Datalines;
Lazrry brown
Kobe Bryant
Zach oneal
Kevin Durant
Lebron jamesz
chrisZ pual
chris Zwebber
;
Run;

libname results "&path/output";
data results.output10(drop=firstname lastname n);
set cert.input10;
length fullname $15;
*fullname = trim(firstname)|| ', ' ||lastname;
fullname = catx(', ', firstname, lastname);
n = find(fullname, 'z', 'i'); /* case insensitive */
if n > 0 then 
	do;
		zflag=1;
		nozflag=0;
	end;
else 
	do;
		zflag=0;
		nozflag=1;
	end;
fullname = propcase(fullname);
run;
proc print data=results.output10;
SUM zflag nozflag;
run;

/* Q11 */
libname cert "&path/input";
Data cert.input11;
Input name $;
Datalines;
Amanda
Tao
Tao
Chen
Kobe
Chen
Amanda
Tao
Chen
Jordan
Tao
;
Run;

libname results "&path/output";
proc sort data=cert.input11;
by name;
run;
data results.output11;
set cert.input11;
by name;
if upcase(name) in ('AMANDA' 'TAO' 'CHEN') then 
	do;
		if first.name then count=0;
		count + 1;
	end;
else count = 0;
if last.name;
run;
proc print data = results.output11;
run;


/* Q12 */
libname cert "&path/input";
Data cert.input12;
Input department $ income dollar6.;
Datalines;
Hr $1000
Eng $500
Hr $10000
Hr $7500
Eng $200
Clean $20
Eng $3000
Clean $10
;
Run;

proc sort data = cert.input12 out = results.output12;
by department;
run;
proc print data =results.output12;
by department;
SUM income;
run;
/* data results.output12_1 (drop = income); */
/* set results.output12; */
/* by department; */
/* if first.department then total = 0; */
/* total + income; */
/* if last.department;  */
/* run; */


/* Q13-1 */
data results.output13;
rate = .05;
total = 50;
do year = 1 to 3;
	do month = 1 to 12;
		total + total*rate; 
	end;
	output;
	total + 50;
end;
run;
/* Q13-2 */
data results.output13_2;
rate = .05;
total = 100;
do year = 1 to 3;
	do month = 1 to 12;
		total + total*rate; 
	end;
	output;
	total + 50;
end;
run;

/* Q14-1 */
data results.output14_1;
rate = 0.6;
total = 50;
do until (total>10000);  /* check condition after iteration */
	total + total*rate;
	total + 50;
	year +1;
	output;
end;
run;
/* Q14-2 */
data results.output14_2;
rate = 0.6;
total = 100;
do until (total>10000); /* check condition after iteration */
	total + total*rate;
	year +1;
	output;
	total +50;
end;
run;

/* Q15 */
/* To do one-to-one merge, both dataset must be sorted */
/* inner join */

/* Q16 */
/* If … then …; */
/* If … then …; (replace previous if…then… statement) */
/* Else …; */

/* If … then …; */
/* Else if … then …; (not replace previous if…then… statement) */
/* Else …; */

/* Q17 */
/* To use BY statement, dataset must be in order or be sorted */
/* Proc print：id，by，var ; need to use label option*/
/* Proc means：id，by，class，var ; defual 5 stats: n mean std min max*/
/* Proc freq：tables ; two-way table:var1*var2 */

