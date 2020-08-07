/* Describing data using Proc Univariate */
/*  */
/* combines many of the features found in FREQ, MEANS, SUMMARY, TABULATE  */
/* into a single PROC step */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss"
dbms = xlsx out=scoredata0 replace; 
run; 

data scoredata1;
set scoredata0;
	TotalScore = sum(score1, score2, score3);
	AverageScore = mean (score1, score2, score3);
run;

proc univariate data=scoredata1;
	var averagescore;
	title 'summary of average scores';
run;


/* The BY statement */
proc sort data = scoredata1 out= scoredata2;
by gender;
run;
proc univariate data=scoredata2;
	var averagescore;
	by gender;
	title 'summary of average scores by gender';
run;

/* The Class statement */
proc univariate data=scoredata1;
	var averagescore;
	class gender;
	title 'summary of average scores class gender';
run;
