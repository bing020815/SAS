/* Assign SAS built-in formats */
proc import datafile= "/folders/myfolders/SAS/Data/score_data_miss"
dbms=xlsx out=scoredata0 replace ;
run;

data scoredata1; 
set scoredata0; 
	TotalScore = sum(score1, score2, score3);
	AverageScore = mean(score1, score2, score3);
run; 

data scoredata2;
set scoredata1;
/* Assign permanent formate, including period sign and decimals */
format AverageScore 5.2 ;
run;

proc print data=scoredata2;
title "Permanent format for Averagescore";
run;

proc print data = scoredata1 ;
format AverageScore 4.1 ;
title "Temporary format for Averagescore";
run; 

/* @@ use defined format@@ */
proc format;
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

proc print data=scoredata1;
	format gender $genderf. averagescore asgroup.;
	title "Results Printed with User-Defined Formats";
run;

proc print data=scoredata1;
	title "Results Printed without User-Defined Formats";
run;