/* Stat Procedure: */
/* Proc print */

/* create simple report with proc print */
proc import datafile="/folders/myfolders/SAS/Data/score_data_id_class"
dbms = xlsx out=scoredata0 replace; 
run; 

proc print data = scoredata0;
run; 

/* labeling the observation column */
proc print data=scoredata0 obs="observation Number";
run;

/* Suppressing the observation column */
proc print data = scoredata0 noobs;
run;

/* the report emphasizes the student name */
proc print data = scoredata0;
ID name;
run; 


/* sort ID var */
proc sort data = scoredata0;
by name;
proc print data = scoredata0;
ID name;
run;


/* Report the selected variables in order with VAR statement */
/* if the var appearing in the ID statement is also included in the VAR statement,*/
/* the information is duplcated and two columns for the same variable appear */
proc print data=scoredata0 ;
var name stu_id gender class;
ID name;
title "selected variables in order";
run;

/* selecting observations with WHERE statement */
proc print data = scoredata0 ; 
var stu_id gender class;
ID name;
where gender = 'm' and class in ('a','c');
title "selected variables: where gender = 'm' and class in ('a','c')";
run;


/*  */
/* Creating enhanced report */
/*  */
/* using additional statements and options that enhance the reports */
proc import datafile="/folders/myfolders/SAS/Data/FunRun_data_id_class"
dbms = xlsx out=FR0 replace; 
run; 

/* Add the SUM statement to compute subtotals and totals for the num variables; */
/* specify formats for variables by adding the FORMAT statement */
proc print data = FR0 noobs;
var name stu_id gender class fund;
sum fund;
format fund dollar5.1;
run;

/* computing group subtotals */
proc sort data = fr0;
by class;
run;
proc print data = FR0 noobs;
var name stu_id gender class fund;
sum fund;
by class;
run;

/* labeling Subtotal and the Grand Total */
proc print data = FR0 noobs
	sumlabel='Total Fund Raised' grandtotal_label="Grand Total Fund Raised";
title 'Fund Raised by Class';
var name stu_id gender class fund;
sum fund;
by class;
run;

/* Identifying Group Subtotals */
proc print data = FR0 noobs
	sumlabel='Total Fund Raised' grandtotal_label="Grand Total Fund Raised";
title 'Fund Raised by Class with diff appearance';
var name stu_id gender class fund;
sum fund;
by class;
id class;
run;