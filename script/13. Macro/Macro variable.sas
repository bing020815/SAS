/* MACRO */
/* A. macro variables */
%let state = Texas;
title "data for &state"

/* B. macros */
%macro print;
/* 	proc print data= score_data; */
	title 'input data';
	run;
%mend print;


/*/ Replacing text strings using Macro Variables /*/

/* Macro variable is an efficient way of replacing text strings in SAS code. */
/* The simplest way to define a macro variable is to use the %Let statement to  */
/* assign the macro variable a name, and a value */

proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms=xlsx out=score_data replace;
run;

%let score = score1 score2 score3;

proc means data= score_data mean MAXDEC=1;
var &score;
title "mean for &score";
run;


/*/ Generating SAS Code Using Marcos /*/

/* A string inside a macro is called constant text or model text becuase it is  */
/* the model, or pattern, for the text that becomes part of SAS program */

%macro data_info;
	score_data
%mend data_info;

title "score means from %data_info";
/* resolve as */
title "score means from data_info";

proc print data= %data_info;
title "score means from %data_info";
run;

/* Note: Macro only works within double quotation marks */



/*/ Create macro that contains entire sections of a SAS program */
%macro print;
	proc print data= score_data;
	title 'input data';
	run;
%mend print;

%print;

/*/ Passing information into a Macro using parameters /*/
%macro score_mean(score_var=);
	proc means data= score_data mean MAXDEC=1;
		var &score_var;
	run;
%mend score_mean;

/* invoke the macro by providing the values for parameters: */
%score_mean(score_var=score1);
%score_mean(score_var=score1 score2 score3);


