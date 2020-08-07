/* APPEND procedure: */
/* PROC APPEND BASE=SAS-data-set */
/* 	DATA = SAS-data-set; */
/* RUN; */
/*  */
/* BASE: names the dataset to which observations are added */
/* DATA: the dataset containing observations are added to the base dataset */

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
/* A appends B: */
/* @ # */
/* 1 a */
/* 2 b */
/* 3 c */
/* 1.c */
/* 2 d */
/* 4 e */

proc import datafile="/folders/myfolders/SAS/Data/score_data_id_partial"
dbms=xlsx out=scoredata_p replace;
run;

proc import datafile='/folders/myfolders/SAS/Data/score_data_id'
dbms=xlsx out = scoredata replace;
run;

proc append BASE=scoredata_p
data=scoredata FORCE;
/* because score3 is not in the base dataset */
run;

proc print data = scoredata_p;
title "append";
run;