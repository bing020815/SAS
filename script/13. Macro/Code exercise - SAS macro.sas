/* Instruction: */
/* generate proc univariate outputs for all 4 score variables: */
/* 1. using macro variable replace score vars' names */
/* 2. using macro with parameter */

proc import datafile="/folders/myfolders/SAS/Data/allscore"
dbms=xlsx out=score_data replace;
run;


/* 1. */
%let score_var = read; /*read math science write*/

proc univariate data=score_data;
	var &score_var;
	title "Proc Univariate output for '&score_var'";
run;


/* 2. */
%macro mean_score(score_var=);
	proc univariate data=score_data;
	var &score_var;
	title "Proc Univariate output for '&score_var'";
	run;
%mend mean_score;

%mean_score(score_var=math);