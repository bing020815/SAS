/* ARRAY: assign initial values and creating temporary array element */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss999"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1 (drop=i);
set scoredata0;
	ARRAY score_var(3) score1 score2 score3;
	DO i = 1 to 3;
		IF score_var{i} = 999 then score_var{i} =.;
	end;
ave_score = mean(score1, score2, score3);
run;

proc means data=scoredata1;
var score1 score2 score3;
run;

data scoredata2 (drop=i);
set scoredata1;
	array score(3) score1 score2 score3;
	array average(3) (79.5 81.9 80.8);
/* 	assign inital values to average1-3 */
	array score_diff(3);
	do i = 1 to 3 ;
		score_diff{i} = score{i} - average(i);
	end;
run;

proc print data=scoredata2;
run;


/* Temp array varaiable */
data scoredata3(drop=i);
set scoredata1;
	array score(3) score1 score2 score3;
	array average(3) _temporary_(79.5 81.9 80.8);
/* 	assign inital values to average1-3 */
/* the temporary array will not be stored into the dataset */
	array score_diff(3);
	do i = 1 to 3 ;
		score_diff{i} = score{i} - average(i);
	end;
run;
proc print data=scoredata3;
run;