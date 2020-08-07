/* ODS Excel dom */
/* Customizing excel output: */
/* Create multiple excel sheets according to by group variable's values */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss"
dbms = xlsx out=scoredata0 replace;
run;

proc sort data = scoredata0 out = scoredata1;
by gender;
run;
/*  */
/* The 'sheet_interval' option specifies that a new wheet is created after  */
/* each by group. 'embedded_titles' option specifies that the title of worksheet */
/* 'embed_titles_once' option specifies that the title is embedded once. 
at the top of each sheet*/

/* The 'ODS NOPROCTITLE' statement suppresses the writing of the procedure title */
/* that the produces the results */

ods excel file="/folders/myfolders/multi_table.xlsx"
	options(sheet_interval='bygroup'
			sheet_label='Gender'
			embedded_titles="yes"
			embed_titles_once="yes");
title 'summary of scores by gender';
ods noproctitle;
proc means data = scoredata1 MAXDEC=1 n mean max max;
	by gender;
	var score1 score2 score3;
	where gender ne ' ';
run;
ods excel close;