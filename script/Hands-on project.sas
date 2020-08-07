/*
A. import excel data file into SAS

B. Data management:
	1. Check Data using proc Means and proc Freq
	
	Create a new data set WL1 using a data step program including the following:
	2. clean data: change value '9999' to missing using Array statement
	3. create weight difference variables
	wd1  = weight0 - weight1;
	wd2  = weight0 - weight2;
	wd12 = weight1 - weight2;
	
	4. using proc Means and Proc Freq, check weight difference variables
	(only pick w2 and walk_steps for this project)
	
	Create a new data set WL1 using a data step program including the following:
	5. create groups for walk_steps: create new var ws_group
	the new group var should have 3 categories:
		a. less than 5000 
		b. 5000-10000
		c. greater than 10000
	6. create groups for wd2: create new var wd2_group
	the new group var should have 3 categories:
		a. not losing weight
		b. losing <= 5 lbs
		c. losing >= 5 lbs
C. create permanent dataset from data set WL2: projected.weight_loss
D. create cross-tab using Proc Freq for walk steps' grop (walk_steps_G) and 
	weight loss groups (loss_weight_G)
*/

/* A. import excel data file into SAS*/
proc import datafile="/folders/myfolders/SAS/Data/Weight_loss"
dbms=xlsx out=wl0 replace;
run;

/* B. Data management*/
/* check data for continuous numeric variables: use means or univariate */
proc means data=wl0 maxdec=2;
var weight0 -- walk_steps;
title "from wl0";
run;
/* check data for categorical variables: use freq */
proc freq data=wl0;
table gender;
title "from wl0";
run;

/* data cleaning for 9999*/
data wl1(drop=i);
set wl0;
	array v{3} weight0--weight2;
	DO i=1 to 3;
		if v{i}=9999 then v{i}=.;
	end;
	wd1  = weight0 - weight1;
	wd2  = weight0 - weight2;
	wd12 = weight1 - weight2;
run;

/* using proc Means and Proc Freq, on w2 and walk_steps for this project) */
proc means data=wl1 maxdec=2;
var wd2 walk_steps;
title "from wl1";
run;
/* check data for categorical variables: use freq */
proc freq data=wl1;
table wd2 walk_steps;
title "from wl1";
run;

/* create groups for walk_steps and wd2 */
data wl2;
set wl1;
length walk_steps_G loss_weight_G $20;
	if walk_steps < 5000 then walk_steps_G = 'less than 5000';
	else if  5000 <= walk_steps < 10000 then walk_steps_G = '5000-10000';
	else walk_steps_G = '> 10000';
	
	if wd2 ne . and wd2 <= 0 then loss_weight_G = 'not losing weight';
	else if 0 < wd <= 5 then loss_weight_G = 'losing <= 5 lbs';
	else if wd2 > 5 then loss_weight_G = 'losing > 5 lbs';
	else loss_weight_G = 'missing';
run;
	
/* C. create permanent dataset */
libname projected "/folders/myfolders";
data projected.weight_loss;
set wl2;
run;