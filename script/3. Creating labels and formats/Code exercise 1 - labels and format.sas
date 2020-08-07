/* Instruction: */
/* 1. import sale.xlsx and create SAS data set 'sale0' */
/* 2. create data 'sale1' with data step program: */
/* 	a. assign labels to: */
/* 		emid = employee id */
/* 		sale_m1 = sale in Jan */
/* 		sale_m2 = sale in Feb */
/* 		sale_m3 = sale in Mar */
/* 	b. calculate average sale of three months' sales and assign format */
/* 	to average sale with $, commas and two decimal places assign format */
/* 	to sale_m1, sale_m2, sale_m3 */
/* 3. print data 'sale1' with labels and formats */

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

proc print data = sale1 label; 
run;

