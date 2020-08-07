/* Instruction: */
/* 0. change value 9999 to missing (periods) */
/* 1. transform data from one record per PID (patient ID) to multiple record */
/* per PIF using proc Transpose [manyper] */
/* 2. values of 3 weight vars (weight0 weight1 weight2) will be transposed */
/* 3. all vars in the input data will be included in the transposed data */

proc import datafile="/folders/myfolders/SAS/Data/Weight_loss"
dbms= xlsx out= weightdata0 replace;
run;

data weightdata1(drop=i);
set weightdata0;
ARRAY weight_var{3} weight0-weight2;
DO i=1 to 3;
	if weight_var{i}=9999 then weight_var{i}=.;
end;
run;

proc sort data = weightdata1;
	by pid gender walk_steps;
run;

proc transpose data=weightdata1 
			out = manper_weight(rename=(col1=all_weight _name_=weight_type )
								drop = _label_
								where = (all_weight ne .));
	by pid gender walk_steps;
	var weight0-weight2;
proc print data = manper_weight;
title "Transpose: Manyper";
run;