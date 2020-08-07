/* Ｍatch merging*/

/* DATA output-SAS-data-set; */
/* 	MERGE SAS-data-set-1 SAS data-set-2; */
/* 	BY <DESCENDING> variable(s) */
/* run; */

/* A: */
/* @ # */
/* 1 a */
/* 2 b */
/* 3 c */
/*  */
/* B: */
/* @ $ */
/* 1 c */
/* 2 d */
/* 4 e */
/*  */
/* A match-merging B by @: */
/* @ # $ */
/* 1 a c */
/* 2 b d */
/* 3 c   */
/* 4   e */


proc import datafile="/folders/myfolders/SAS/Data/score_data_id_partial_score4"
dbms=xlsx out=scoredata_p replace;
run;

proc import datafile='/folders/myfolders/SAS/Data/score_data_id'
dbms=xlsx out = scoredata replace;
run;

/* ascending */
/* Note: each input dataset in the merge statement must be sorted */
/* <DESCENDING> option in merge statement cannot be used with index dataset */
proc sort data = scoredata_p;
by stu_id;
run;
proc sort data = scoredata;
by stu_id;
run;

data MMA;
merge scoredata_p scoredata ;
by stu_id;
run;

proc print data = MMA;
title "match merging ascending";
run;
proc print data=scoredata_p;
title "partial score data";
run;
proc print data=scoredata;
title "score data";
run;

/* descending */
/* Note: each input dataset in the merge statement must be sorted */
/* <DESCENDING> option in merge statement cannot be used with index dataset */
proc sort data = scoredata_p;
by descending stu_id;
run;
proc sort data = scoredata;
by descending stu_id;
run;

data MMA;
merge scoredata_p scoredata ;
by descending stu_id;
run;

proc print data = MMA;
title "match merging descending";
run;
proc print data=scoredata_p;
title "partial score data";
run;
proc print data=scoredata;
title "score data";
run;