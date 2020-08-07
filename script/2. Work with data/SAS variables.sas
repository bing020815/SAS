
proc import datafile='/folders/myfolders/SAS/Data/score_data'  
dbms=xlsx out=scoredata0 replace;
run;

/* temp dataset */
data scoredata1; 
set scoredata0; 
/* The curreny dataset contains missing values */
/*  @ create a new variable */
	grade = 7;
	ScoreType = 'Math Scores';
	TotalScore = score1 + score2 + score3; 
	AverageScore = TotalScore/3 ;
run;

proc print data=scoredata1;
run;


/* save the temp dataset with new variables as new temp dataset */
data scoredata2;
set scoredata1;
run;