/* Instruction: */
/*merge class information to student-level data by variable class */
/*only the observations with class-level information will be kept in the merge data */

proc import 
datafile="/folders/myfolders/SAS/Data/score_data_id_class"
dbms=xlsx out= scoredata replace ;
run; 

proc import datafile="/folders/myfolders/SAS/Data/class_info"
dbms=xlsx out= classinfo replace ;
run;

proc sort data = scoredata;
by class;
run;

proc sort data = classinfo; 
by class;
run;

data MMA;
merge scoredata (in=A) classinfo(in=B);
by class;
if A=1 and B=1;
run;

proc print data=MMA;
run;