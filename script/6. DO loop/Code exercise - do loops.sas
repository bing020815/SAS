/* 1. compute each year's salary you have  */
/* if you start with $60,000 at a 3% increase rate per year for 5 years */
/*  */
/* 2. Conditionally executing Do loops: */
/* how many years will take to get salary over $100,000 */


data salarydata(drop=i);
increase_rate = 0.03;
salary = 60000;
DO i = 1 to 5;
	salary + salary*increase_rate;
	year + 1;
	output;
end;
format salary dollar10.2;
run;
title "DO loops";
proc print data=salarydata;
run;


data salarydata;
increase_rate = 0.03;
salary = 60000;
DO until (salary>100000);
	salary + salary*increase_rate;
	year + 1;
	output;
end;
format salary dollar10.2;
run;
title "Conditional DO loops";
proc print data=salarydata;
run;