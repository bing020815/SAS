/* Interleaving: append data in sequentially*/
/*  */
/* DATA output-SAS-data-set; */
/* 	SET SAS-data-set-1 SAS data-set-2; */
/* 	BY variables */
/* run; */
/*  */
/* A: */
/* @ # */
/* 1 a */
/* 2 b */
/* 3 c */
/*  */
/* B: */
/* @ # */
/* 1 c */
/* 2 d */
/* 4 e */
/*  */
/* A interleaving B by @: */
/* @ # */
/* 1 a */
/* 1 c */
/* 2 b */
/* 2 d */
/* 3 c */
/* 4 e */

proc import datafile="/folders/myfolders/SAS/Data/score_data_id_partial"
dbms=xlsx out=scoredata_p replace;
run;

proc import datafile='/folders/myfolders/SAS/Data/score_data_id'
dbms=xlsx out = scoredata replace;
run;

proc sort data = scoredata_p;
by stu_id;
run;

proc sort data = scoredata;
by stu_id;
run;

data interleave;
set scoredata_p scoredata;
by stu_id;
run;

proc print data=interleave;
title 'interleaving';
run;

proc print data=scoredata_p;
title "partial score data";
run;

proc print data=scoredata;
title "score data";
run;
