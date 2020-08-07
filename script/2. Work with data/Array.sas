/* Array */
proc import datafile='/folders/myfolders/SAS/Data/score_data_miss999'  
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0;
	Array score_var {3} score1-score3;
	DO i = 1 to dim(score_var);
		if score_var{i} = 999 then score_var{i} = .;
	drop i;
	end;
	
	
run;

proc print data = scoredata1;
title "missing values are shown as periods";
run;

proc print data = scoredata0;
title "missing values are shown as 999";
run;