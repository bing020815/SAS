/* PROC SQL */
/* proc sql; */
/* 	create table scoredata0 as  */
/* 	select stu_id, gender, name  */
/* 	from score_data  */
/* 	where gender in ('m'); */
/* quit; */
/*  */
/* Optional clauses: */
/* order by clause */
/* group by clause */
/* having clasue */


proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms = xlsx out=score_data replace;
run;

proc sql;
	create table scoredata0 as 
	select stu_id, gender, name 
	from score_data 
	where gender in ('m');
quit;

proc print data=scoredata0;
title "proc sql result:";
run;


proc sql;
	title "proc sql without 'create table' statement:";
	select stu_id, gender, name
	from score_data
	where gender in ('m');
quit;

proc sql;
	title "proc sql without 'create table' statement:";
	select *
	from score_data
	where gender in ('m');
quit;


