/* Outer Join: */
/* 1. left outer join */
/* 2. right outer join */
/* 3. full outer join */

/* stu_id=5 is not included */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id_no_gender_1l"
dbms = xlsx out=score_data_ng replace;
run;

/* stu_id=11 is not included */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id_gender_only_1l"
dbms = xlsx out=score_data_g replace;
run;  

ods pdf file = "/folders/myfolders/OuterJoin.pdf";

proc print data=score_data_g;
	title 'score_data_g: stu_id=11 is not included';
run;

proc print data=score_data_ng;
	title 'score_data_ng: stu_id=5 is not included';
run;


/* Left Outer Join */
title 'score_data_g left join score_data_ng';
proc sql ;
	select g.stu_id, 
		   ng.stu_id,
		   ng.score1,
		   ng.score2,
		   ng.score3,
		   g.gender,
		   g.name
	from score_data_g as g left join score_data_ng as ng
	on g.stu_id = ng.stu_id;
quit;

title 'score_data_g right join score_data_ng';
proc sql ;
	select g.stu_id, 
		   ng.stu_id,
		   ng.score1,
		   ng.score2,
		   ng.score3,
		   g.gender,
		   g.name
	from score_data_g as g right join score_data_ng as ng
	on g.stu_id = ng.stu_id;
quit;


/* Full Outer Join */
title 'score_data_g full join score_data_ng';
proc sql ;
	select *
	from score_data_g as g full join score_data_ng as ng
	on g.stu_id = ng.stu_id;
quit;
ods pdf close;