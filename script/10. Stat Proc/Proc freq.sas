/* using if then else statement */
proc import datafile="/folders/myfolders/SAS/Data/score_data_miss"
dbms = xlsx out=scoredata0 replace; 
run; 

data scoredata1;
set scoredata0;
	TotalScore = sum(score1, score2, score3);
	AverageScore = mean (score1, score2, score3);
run;

data scoredata_ifthenelse;
set scoredata1;
/* 		gender_num */
	if gender='m' then gender_num = 1;
	else if gender = 'f' then gender_num =0;
	else gender_num = .;
	
/* 		take */
	if score1 NE . and score2 NE .  and score3 ne . 
	then take = 'complete';
	else take = 'incomplete';
	
/* 		grade & pass */
	if AverageScore >= 90 then do;
		grade = 'A';
		pass = 'pass';
	end;
	else if AverageScore >= 80 then do;
		grade = 'B';
		pass = 'pass';
	end;
	else if AverageScore >= 70 then do;
		grade = 'C';
		pass = 'pass';
	end;
	else if AverageScore >= 60 then do;
		grade = 'D';
		pass = 'pass';
	end;
	else if 0 <= AverageScore < 60 then do;
		grade = 'F';
		pass = 'fail';
	end;
	else do;
	grade = ' ';
		pass = ' ';
	end;
run;

proc print data = scoredata_ifthenelse;
run;


/* Proc Freq */
proc freq data = scoredata_ifthenelse ;
tables gender gender*grade;
title 'frequency tables not including missing';
run;

proc freq data = scoredata_ifthenelse ;
tables gender gender*grade/missing;
title 'frequency tables including missing';
run;

proc freq data = scoredata_ifthenelse ;
tables gender gender*grade/missing nocol norow;
title 'frequency tables without row% and column %';
run;