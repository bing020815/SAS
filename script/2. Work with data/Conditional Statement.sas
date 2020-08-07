/* Conditional processing using IF Then statement */
proc import datafile='/folders/myfolders/SAS/Data/score_data'  
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0;
/* using SAS functions */
TotalScore = sum(score1, score2, score3);
AverageScore = mean(score1, score2, score3);
run;

data scoredata_IfThenElse;
set scoredata1;
/* using if...then...else statement */
/* 	gender_num */
if gender = 'm' then gender_num=1;
/* not equal: 'NE', '-=', '^=' */
else if gender = 'f' then gender_num = 0;
else gender_num = .;


/* 	take */
if score1 NE . & score2 ~= . & score3 ^= . then take = 'complete';
else take = 'incomplete';


/* 	grade & pass */
if AverageScore >= 90 then DO;
	grade = "A";
	pass = 'pass';
	END;
else if averageScore >= 80 then do;
	grade = 'B';
	pass = 'pass';
	END;
else if averageScore >=70 then do;
	grade = "C";
	pass = 'pass';
	END;
else if averageScore >= 60 then do;
	grade = 'D';
	pass = 'pass';
	END;
else if 0 <= averageScore < 60 then do;
	grade = 'F';
	pass = 'fail';
	END;
else do;
	grade = ' ';
	pass = ' ';
	END;
run;

proc print data=scoredata_IfThenElse;
run;