/* Inner Jins using INNER JOIN keywords */

/* It is equivalent to a merge in a DATA step where only the obs from both */
/* datasets are kept. In here, there is no need to sort the data sets first when */
/* we use proc SQL */

/* stu_id=5 is not included */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id_no_gender_1l"
dbms = xlsx out=score_data_ng replace;
run;

/* stu_id=11 is not included */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id_gender_only_1l"
dbms = xlsx out=score_data_g replace;
run;  

/* Using INNER JOIN */
proc sql;
	create table inner_sql as
	select g.stu_id, 
		   ng.score1,
		   ng.score2,
		   ng.score3,
		   g.gender,
		   g.name
	from score_data_g as g inner join score_data_ng as ng
	on g.stu_id = ng.stu_id;
quit; 
proc print data=inner_sql;
	title 'score_data_g inner join score_data_ng';
run;

/* Using WHERE clause as the inner join*/
proc sql;
	create table inner_sql_where as
	select g.stu_id, 
		   ng.score1,
		   ng.score2,
		   ng.score3,
		   g.gender,
		   g.name
	from score_data_g as g, score_data_ng as ng
	where g.stu_id = ng.stu_id;
quit; 
proc print data=inner_sql_where;
	title 'score_data_g inner join score_data_ng (where clause)';
run;

proc print data=score_data_g;
	title 'score_data_g: stu_id=11 is not included';
run;

proc print data=score_data_ng;
	title 'score_data_ng: stu_id=5 is not included';
run;


/* Merge in a Data step */
proc sort data = score_data_g ;
by stu_id;
run;

proc sort data = score_data_ng ;
by stu_id;
run;

data MMA;
merge score_data_g (in=A) score_data_ng (in=B);
by stu_id;
if A=1 and B=1;
run;

proc print data=mma;
	var stu_id score1 score2 score3 gender name;
	title 'a merge in a data step';
run;
proc print data=inner_sql;
	title 'Performing an inner join using Proc SQL';
run;