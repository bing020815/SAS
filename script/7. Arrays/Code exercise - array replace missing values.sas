/* Instruction: */
/* using ARRAY to replace 'missing' with blanks in vars */
/* then convert the character vars to numeric vars */

proc import datafile="/folders/myfolders/SAS/Data/allscore_miss_text"
dbms=xlsx out=scoredata0 replace;
run;


data scoredata1;
set scoredata0;

ARRAY old_vars{4} read -- write;
ARRAY new_vars{4} readN mathN scienceN writeN;
DO i=1 to 4;
	if old_vars{i} = 'missing' then old_vars{i}=' ';
	new_vars{i} = input(old_vars{i},8.);
end;
run;
proc print data=scoredata1(keep = stuid gender readN mathN scienceN writeN);
title "convert to numerics values";
run;