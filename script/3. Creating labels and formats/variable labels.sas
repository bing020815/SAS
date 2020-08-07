/* Create label */
proc import datafile= '/folders/myfolders/SAS/Data/score_data_miss'
dbms=xlsx out= scoredata0 replace;
run;

/* label in data step */
data scoredata1;
set scoredata0;
	label 
		  score1 = 'Math Score'
		  score2 = 'Science Score'
		  score3 = 'English Score';
run;

proc print data=scoredata1 label;
/* use the label option in proc print statement to display labels */
run;


/* label in Proc step */
proc print data=scoredata1 label;
label name = 'Student Name';
/* The label statement applies only to the proc step in which it appears */
run;

proc means data= scoredata1;
var score1;
run;