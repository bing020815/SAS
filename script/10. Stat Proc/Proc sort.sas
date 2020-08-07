/* Stat Procedure: */
/* Proc Sort */
/* proc sort DATA = input-data OUT= out-data; */
/* 	by variable list; */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss"
dbms = xlsx out=scoredata0 replace; 
run; 

data scoredata1; 
set scoredata0 ;
	TotalScore = sum (score1, score2, score3);
	AverageScore = mean (score1, score2, score3);
/* 	if AverageScore; */
run;

proc sort data = scoredata1 out=scoredata2 ;
by Gender descending averagescore; 
run;

proc print data = scoredata2 ; 
run; 

/* OPTION: NODUPKEY DUPOUT= */
proc sort data = scoredata1 out = scoredata3 
	NODUPKEY dupout= extraobs;
	by gender; 
run; 

proc print data = scoredata3;
title "sort by gender with NODUPKEY option";
run;
proc print data = extraobs;
title "sorted by gender with DUPOUT = extraobs";
run;