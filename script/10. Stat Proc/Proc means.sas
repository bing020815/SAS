/* Proc Means */
proc import datafile="/folders/myfolders/SAS/Data/score_data_miss"
dbms = xlsx out=scoredata0 replace; 
run; 

data scoredata1;
set scoredata0;
	TotalScore = sum(score1, score2, score3);
	AverageScore = mean (score1, score2, score3);
run;

PROC MEANS data=scoredata1 Maxdec=1 n mean max min;
/* maxdec: maximum decimal */
	Var score1 score2 score3 averagescore;
	title "Summary of Scores";
run;

/* by statement */
Proc sort data = scoredata1 out=scoredata2; 
by gender;
run;
PROC MEANS data=scoredata2 Maxdec=1 n mean max min;
	By gender;
	Var score1 score2 score3 averagescore;
	title "Summary of Scores by Gender using by statement";
run;

/* Class statement */
PROC MEANS data=scoredata1 Maxdec=1 n mean max min;
/* maxdec: maximum decimal */
	class gender;
	Var score1 score2 score3 averagescore;
	title "Summary of Scores by gender using class statement";
run;
PROC MEANS data=scoredata1 Maxdec=1 missing n mean max min;
/* maxdec: maximum decimal */
	class gender;
	Var score1 score2 score3 averagescore;
	title "Summary of Scores by gender using class statement with missing";
run;