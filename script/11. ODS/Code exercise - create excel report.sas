/* Instruction: */
/* 1. create excel report using ods */
/* 2. each excel sheet is created for each state */
/* 3. report sale average/mean for 3 sale variables sale 1-3 */

proc import datafile="/folders/myfolders/SAS/Data/sale_by_state"
dbms=xlsx out= saledata0 replace;
run;

data saledata1;
set saledata0;
average_sale = mean(sale1, sale2, sale3);
format average_sale 7.2;
run; 

proc sort data=saledata1;
by state;
run;

ods excel file="/folders/myfolders/ods_exercise.xlsx"
	options(sheet_interval='bygroup'
			sheet_label='State'
			embedded_titles="yes"
			embed_titles_once="yes");
title 'summary of sales by state';
ods noproctitle;
proc means data = saledata1 MAXDEC=2 n mean max min;
	by state;
	var sale1 sale2 sale3;
	where state ne ' ';
run;
ods excel close;
