libname myfmts "/folders/myfolders";

proc format library = myfmts;
	value $genderf 'm' = 'Male'
				   'f' = 'female'
				   other = 'Missing';
	value asgroup  0 -<60 = 'F'
				   60-<70 = 'D'
				   70-<80 = 'C'
				   80-<90 = 'B'
				   90-High = 'A'
				   other = 'Missing';
run;

title "Format Definitions in the MYFMTS Library";
proc format library=myfmts fmtlib;
/* fmtlib: */
/* Prints information about all the informats and formats in the catalog that  */
/* is specified in the LIBRARY= option */
run;

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1 ;
set scoredata0 ;
	TotalScore = sum(score1, score2, score3);
	AverageScore = mean(score1, score2, score3);
run;

/* reference user-defined formats stored in the Myfmts library	 */
libname myfmts "/folders/myfolders";
options fmtsearch= (myfmts work library) ;

proc print data = scoredata1 ;
	format gender $genderf. AverageScore asgroup.;
run; 