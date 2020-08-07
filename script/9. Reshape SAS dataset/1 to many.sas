proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms= xlsx out=oneper replace;
run;

libname stuscore "/folders/myfolders";

data stuscore.manyper;
set oneper;
	array score{3} score1 score2 score3;
	do stime = 1 to 3;
		all_score = score{stime};
/* when stime=1, all_score = score1; stime=2, all_score=score2 */
		if all_score ne . then output; 
	end;
	keep name stu_id all_score stime;
run;

proc print data = oneper;
title "one obs per student";
run;

proc print data = stuscore.manyper;
title "several obs per student";
run;