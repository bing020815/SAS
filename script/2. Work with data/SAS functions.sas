
proc import datafile='/folders/myfolders/SAS/Data/score_data'  
dbms=xlsx out=scoredata0 replace;
run;

/* temp dataset */
data scoredata2; 
set scoredata0; 
/* The curreny dataset contains missing values */
/*  @ create a new variable */
	grade = 7;
	ScoreType = 'Math Scores';
/* this operation includes missing values and it will not compute for that row */
	TotalScore = score1 + score2 + score3; 
	AverageScore = TotalScore/3 ;
/* use SAS functions to use only non-missing values for the computation */
	TotalScore_func = sum(score1, score2, score3); 
	AverageScore_func = mean(score1, score2, score3);
	
	Gender_func = UPCASE(gender);
run;

proc print data=scoredata2;
run;