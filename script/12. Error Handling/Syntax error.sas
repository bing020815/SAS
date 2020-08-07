proc import datafile="/folders/myfolders/SAS/Data/score_data"
dbms=xlsx out= scoredata0 replace;
run;

/* using PUTLOG */
Data scoredata1;
set scoredata0;
	AverageScore = mean(score1, score2, score3);
	if averagescore < 60;
PUTLOG 'WARNING: Score below the minimum:' name= score1= score2= score3= AverageScore= 5.2;
run;


/* ERROR sttatement */
DATA scoredata1_e;
	set scoredata0;
	AverageScore = mean(score1 + score2 + score3);
	
	ERROR '???' name= score1= score2= score3= AverageScore= 5.2;
/* 	display obs with averagescore<60 with _error_=1 and _N_ */
	if averagescore < 60;
run;