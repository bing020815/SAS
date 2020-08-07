/* Instruction: */
/* 1. using SELECT to create a new table 'allScore1' with variables stuid, */
/* math from table 'allScore0' */
/* 2. using SELECT to create a new table 'Score_data1' with variables stuid, */
/* score2 from table 'Score_data0' */
/* 3. join two tables 'Score_data1' and 'allScore1' on stuid=stu_id using JOIN */
/* 	a. inner join */
/* 	b. left join */
/* 	c. full outer join */


/* allscore */
proc import datafile="/folders/myfolders/SAS/Data/allscore"
dbms = xlsx out=allscore0 replace;
run;
proc sql ;
	create table allscore1 as 
	select stuid, math
	from allscore0;
quit ;
proc print data=allscore1;
	title 'allscore1';
run;

/* score_data */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms = xlsx out=score_data0 replace;
run;  
proc sql ;
	create table Score_data1 as 
	select stu_id, score2
	from Score_data0;
quit ;
proc print data=Score_data1;
	title 'Score_data1';
run;

/* JOIN */
title "inner join";
proc sql ;
	select *
	from allscore1 as a inner join Score_data1 as s
	on a.stuid = s.stu_id;
quit ;

title "left join: from allscore1";
proc sql ;
	select *
	from allscore1 as a left join Score_data1 as s
	on a.stuid = s.stu_id;
quit ;

title "full join";
proc sql ;
	select *
	from allscore1 as a full join Score_data1 as s
	on a.stuid = s.stu_id;
quit ;