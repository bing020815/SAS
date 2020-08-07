/* Instruction: */
/* 1. using PUTLOG to detect the possible logic error of the data step program: */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss777"
dbms=xlsx out= sdm0 replace;
run;
Data sdm1;
	set sdm0;
	AverageScore = mean(score1, score2, score3);
	
	PUTLOG 'Score info:' name= score1= score2= score3= AverageScore= 5.2;
	if averagescore <60;
run;

data sdm2(drop=i);
	set sdm0;
	array score_var {3} score1-score3;
	do i = 1 to 3;
	if score_var{i} = 777 then score_var{i}=.;
	end;
	AverageScore = mean(score1, score2, score3);
	if averagescore <60;
	PUTLOG 'WARNING: Score below the minimum:' name= score1= score2= score3= AverageScore= 5.2;

run;

	