/* Instruction: */
/* 1. re-run the codes in coding exercise 1 */
/* 2. create format 'salegroup; for averagesale with following categories: */
/* 	and store the format in library myfmts: */
/* 	 */
/* 	low-<700 = 'need improvement' */
/* 	700-900 = 'good' */
/* 	900-high = 'top sale' */
/* 3. in proc print: reference/use the format 'salegroup' store in the myfmts library */
/* as if in a new SAS session, meaning need to include libname statement */


proc import datafile= "/folders/myfolders/SAS/Data/sale"
dbms = xlsx out = sale0 replace ;
run ; 

data sale1;
set sale0 ;
label 
	sale_m1 = "sale in Jan"
	sale_m2 = "sale in Feb"
	sale_m3 = "sale in Mar"
	emid = 'employee id';

averagesales = mean(sale_m1, sale_m2, sale_m3);
format averagesales sale_m1-sale_m3 dollar10.2;
run;


/* create library */
libname myfmts "/folders/myfolders";
/* create user-define format and store in myfmts library*/
proc format library = myfmts ;
	value salegroup
	low-<700 = 'need improvement'
	700-900 = 'good'
	900-high = 'top sale';
run; 

/* reference user-defined formats stored in the Myfmts library	 */
libname myfmts "/folders/myfolders";
options fmtsearch= (myfmts work library) ;

proc print data = sale1 ;
	format averagesales salegroup.;
	title "Applied Permanent format";
run; 

proc print data = sale1 ;
	title "Not applied Permanent format";
run; 
