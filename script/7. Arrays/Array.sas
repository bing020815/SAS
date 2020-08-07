/* ARRAY: create new vars */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss999"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1(drop=i);
set scoredata0;
	ARRAY score_var(3) score1 score2 score3;
	DO i=1 to 3;
		IF score_var(i) = 999 then score_var(i) =. ;
	END;
ave_score = mean(score1, score2, score3);
run;

data scoredata2(drop=i);
set scoredata1;
/* existing vars */
	ARRAY score(3) score1 score2 score3;
/* 	new vars */
	ARRAY score_diff(3);
	DO i=1 to 3;
		score_diff{i} = score{i} - ave_score;
	END;
run;
proc print data=scoredata2;
run;