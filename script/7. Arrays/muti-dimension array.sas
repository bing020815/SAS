/* Two dimensional array */
proc import datafile="/folders/myfolders/SAS/Data/monthly"
dbms=xlsx out=monthly replace;

data quarters(drop=i j);
set monthly;
	array m{4,3} month1-month12;

/* month1 month2 month3 */
/* month4 month5 month6 */
/* month7 month8 month9 */
/* month10 month11 month12 */

	array qtr{4};
	DO i =1 to 4;
		qtr{i}=0;
		do j=1 to 3;
			qtr{i} + m{i,j};
		end;
	end;
run;

proc print data=quarters(keep = year qtr1 - qtr4);
run;