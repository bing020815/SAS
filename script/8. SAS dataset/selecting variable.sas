proc import 
datafile="/folders/myfolders/SAS/Data/score_data_id_partial_score4"
dbms=xlsx out= scoredata_p replace ;
run; 

proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms=xlsx out= scoredata replace ;
run;

proc sort data = scoredata_p;
by stu_id;
run;

proc sort data = scoredata; 
by stu_id;
run;

data MMA (drop=stu_id);
merge scoredata_p(in=A) scoredata (in=B drop = score3);
by stu_id;
if A = 1 and B = 1;
run;

proc print data = MMA;
title "selecting matching observations";
run; 
proc print data=scoredata_p;
title "partial score data";
run;
proc print data=scoredata;
title "score data";
run; 