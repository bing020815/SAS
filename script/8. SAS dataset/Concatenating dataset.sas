/* Concatenating:*/
/*  */
/* DATA output-SAS-data-set; */
/* 	SET SAS-data-set-1 SAS data-set-2; */
/* run; */
/*  */
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
/* A concatenating B: */
/* @ # $ */
/* 1 a */
/* 2 b */
/* 3 c */
/* 1.  c */
/* 2.  d */
/* 4   e */

proc import datafile="/folders/myfolders/SAS/Data/score_data_id_partial"
dbms=xlsx out=scoredata_p replace;
run;

proc import datafile='/folders/myfolders/SAS/Data/score_data_id'
dbms=xlsx out = scoredata replace;
run;

data CONCAT;
set scoredata_p scoredata;
run;

proc print data=CONCAT;
title "concatenating";
run;

proc print data=scoredata_p;
title "partial score data";
run;

proc print data=scoredata;
title "score data";
run;
