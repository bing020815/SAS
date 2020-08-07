/* Instruction: */
/* 1. Create data set 'scoredata0' from importing the excel data 'score_data_miss777' */
/* 2. In data step, */
/* 	a. create a new data set 'scoredata1' from scoredata0 using set statement */
/*  */
/* 	b. create 3 new score variables NS1, NS2 and NS3 by converting 777 in variable */
/* 	Score1, core2, Score3  to missing (periods) using if...then...else statement */
/* 	and array */
/*  */
/* 	c. calculate average of scores using 3 new score variable NS1, NS2 and NS3 */
/* 	and SAS dunction MEAN */
/* 3. print data 'scoredata1' using Proc Pirnt */

proc import datafile="/folders/myfolders/SAS/Data/score_data_miss777" 
dbms= xlsx out=scoredata0 replace;
/* range="$A1:E12" */
run;

proc print data=scoredata0;
run;

data scoredata1;
set scoredata0;
	array sc {*} Score1-Score3;
	array new {3} NS1 NS2 NS3;
	Do i = 1 to dim(sc);
		if sc{i} = 777 then new{i}=.;
		else if sc{i} NE 777 then new{i} = sc{i};
	drop i;
	END;
averagescore = mean(NS1, NS2, NS3);
run;

proc print data=scoredata1;
run;

 