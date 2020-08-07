/* Executes a DO loop until the expression becomes true: */
/* DO UNTIL(expression); */
/* 	SAS statements */
/* END; */
/*  */
/* Executes a DO loop while the expression is true: */
/* DO WHILE(expression); */
/* 	SAS statements */
/* END; */
/* / */


/* DO UNTIL */
data invest;
	do until(Capital>=50000);
		capital+2000;
		capital + capital*.10;
		Year+1;
	end;
run;




/* DO WHILE */
data invest;
	do while(Capital>=50000);
		capital+2000;
		capital + capital*.10;
		Year+1;
	end;
run;



/* Do loops with conditional DO loops 1*/
data invest;
	do year = 1 to 10 until(Capital>=50000);
		capital+2000;
		capital + capital*.10;
	end;
	if year = 11 then year = 10;
run;


/* Do loops with conditional DO loops 2*/
data invest(drop=a);
	do a = 1 to 10 until(Capital>=50000);
		capital+4000;
		capital + capital*.10;
		year + 1;
	end;
	if year = 11 then year = 10;
run;