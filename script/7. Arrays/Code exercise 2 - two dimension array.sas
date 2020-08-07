/* Instruction: */
/* 1. using two dimensional array to calculate total sale for each state(CA, TX) */
/* of each year */
/* 2. Print the output with dollar format */

proc import datafile="/folders/myfolders/SAS/Data/sale_state"
dbms=xlsx out=saledata0 replace;
run;

data saledata1(drop= i j);
set saledata0;
ARRAY m{2,3} saleCA1 -- saleTX3;
ARRAY state{2} CA TX;
DO i = 1 to 2;
	do j=1 to 3;
	state{i} + m{i,j};
	end;
end;
run;

proc print data=saledata1;
format saleCA1 -- TX dollar10.2;
title "before: state{i}=0 reset";
run;
	
data saledata2(drop= i j);
set saledata0;
ARRAY m{2,3} saleCA1 -- saleTX3;
ARRAY state{2} CA TX;
DO i = 1 to 2;
	state{i}=0;
	do j=1 to 3;
	state{i} + m{i,j};
	end;
end;
run;

proc print data=saledata2;
title "after: state{i}=0 reset";
format saleCA1 -- TX dollar10.2;
run;