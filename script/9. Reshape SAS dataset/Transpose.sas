/* One to many using Proc Transpose */
/*  */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms = xlsx out=oneper replace ;
run;

proc sort data=oneper ;
by stu_id;
run;

/* PROC TRANSPOSE takes an input data set and outputs a dataset where the */
/* original rows become columns and the original columns become rows. */
proc transpose data= oneper out= manyper;
	by stu_id;
/* 	it perform the operation for each value of grouping var stu_id,  */
/* 	the values of the grouping var in BY statement are not transposed */
	var score1-score3;
/* 	values of score1-3 will be transposed */
proc print data = manyper;
title "Test transpose";
run;

/* this is almost what you want. All that is needed is to  */
/* rename the variable COL1 to all_score, */
/* rename the _NAME_, and eliminate _LABEL_ variables, */
/* and remove the observations with missing score values */

proc transpose data = oneper
			   out = manyper_final (rename= (col1=all_score _name_=score_type)
			   						drop = _label_
			   						where = (all_score ne .));
	by stu_id;
	var score1-score3;
run;

proc print data = oneper;
title "one obs per student";
run;

proc print data = manyper_final;
title "multiple obs per student";
run;



/* Include Gender, Name variable */
proc sort data=oneper ;
by stu_id name gender;
run;
proc transpose data = oneper
			   out = manyper_final_ex (rename= (col1=all_score _name_=score_type)
			   						drop = _label_
			   						where = (all_score ne .));
	by stu_id name gender;
	var score1-score3;
run;
proc print data = manyper_final_ex;
title "multiple obs per student_extra vars";
run;


/* Many to one using Proc Transpose */
/*  */

libname stuscore "/folders/myfolders";

proc sort data=stuscore.manyper out=manyper;
	by stu_id name;
run;

proc transpose data= manyper out= oneper0 ;
	by stu_id name; /*grouping variables*/
	id stime ; /*new variable names based on id variable*/
	var all_score; /*var to be transposed*/
proc print data = oneper0;
title "Test transpose";
run;

proc transpose data = manyper prefix= score
			   out = oneper1 (drop=_NAME_);
	by stu_id name ;
	id stime; 
/* 	id statement names the variable whose formatted values will become the new */
/* 	variable names */
	variable all_score;
proc print data = oneper1;
title "final transpose for  one obs per student";
run;
