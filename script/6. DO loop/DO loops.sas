/* DO index-variable=start TO stop BY increment; */
/* 	SAS statements */
/* END; */
/*  */


/* program without DO loops */
data earnings1;
	Interest = 0.0375;
	Total = 100;
	
	Year + 1;
	Total + Interest*Total;
	
	Year + 1; 
	Total + Interest*Total;
	
	Year + 1;
	Total + Interest*Total;
	
	format Total dollar10.2;
run;
title 'Listing of earning without DO loops';

proc print data=earnings1;
run;



/* program with DO loops */
data earnings2;
Interest = .0375;
Total=100;
DO Year = 1 TO 3;
	Total + Interest*Total;
/* 	print the iteration */
	output;
end;
format Total dollar10.2;
run;

title 'Listing of earning with DO loops';
proc print data=earnings2;
run;
/* because 4 is the stop value of do loop, it show 4 instead of 3. */


/* Drop counter variable */
data earnings3 (drop = counter);
Interest = .0375;
Total = 100;
DO counter = 1 to 3;
	Total + Interest*Total;
	Year + 1;
END;
format Total Dollar10.2;
run;

title "Listing of earnings with Do Loops with dropping index";
proc print data=earnings3;
run;



/* Program with DO loops_output */
data earnings4 (drop = counter);
Interest = .0375;
Total = 100;
DO counter = 1 to 3;
	Total + Interest*Total;
	Year + 1;
	output;
END;
format Total Dollar10.2;
run;

title "Listing of earnings with Do Loops with dropping index";
proc print data=earnings4;
run;