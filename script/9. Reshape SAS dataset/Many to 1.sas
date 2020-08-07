libname stuscore "/folders/myfolders";

proc sort data=stuscore.manyper out=manyper;
	by stu_id stime;
run;

data stuscore.oneper;
	set manyper;
	by stu_id stime;
/*  When you use the BY statement in the DATA step,  */
/*  the DATA step creates two temporary indicator variables for each variable  */
/*  in the BY statement. The names of these variables are FIRST.variable and  */
/*  LAST.variable, where variable is the name of a variable in the BY statement. */
	array score{3};
		retain score1-score3;
	if first.stu_id then 
		call missing(of score1-score3);
	score{stime} = all_score;
	if last.stu_id then output;
	keep name stu_id score1-score3;
run;

proc print data=stuscore.manyper;
title "multiple records per student";
run;

proc print data=stuscore.oneper;
title "one record per student";
run;