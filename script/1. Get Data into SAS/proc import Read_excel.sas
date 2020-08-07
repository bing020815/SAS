/* Proc Import excel file */

/* No optional statements */
proc import datafile="/folders/myfolders/SAS/Data/excel_data" 
/* decide file extension and output name*/
DBMS= xlsx out = excel_data1 replace;
run;


/* Optional statements */
proc import datafile="/folders/myfolders/SAS/Data/excel_data" 
/* decide file extension and output name*/
DBMS= xlsx out = excel_data2 replace;
/* not getting the variable names */
/* By default, the import proc will take variable names from the 1st row */
getnames= no;
run;


/* Sheet = "sheet-name"; */
proc import datafile="/folders/myfolders/SAS/Data/excel_data" 
/* decide file extension and output name*/
DBMS= xlsx out = excel_data3 replace;
/* bringing in the 1st sheet by default if not specify: */
sheet= 'name_class';
run;


/* range = 'sheet-name$UL:LR;' */
proc import datafile="/folders/myfolders/SAS/Data/excel_data" 
/* decide file extension and output name*/
DBMS= xlsx out = excel_data4 replace;
range='name_class$A1:B6';
run;



/* @@Use 'import' procedure to import csv@@ */
/* proc import datafile="C:\temp\test.csv" */
/*         out=shoes */
/*         dbms=csv */
/*         replace; */
/*      */
/*  */
/*      getnames=no; */
/* run; */
/*  */
/* proc print data=work.shoes; */
/* run; */

/* @@ Use 'dlm' option for text data @@ */
/* proc import datafile="C:\temp\test.txt" */
/*    out=test */
/*    dbms=dlm */
/*    replace; */
/*    dlm=','; */
/* run; */


/* Optional statements: read from second row and skip variable names */
proc import datafile="/folders/myfolders/SAS/Data/excel_data" 
/* decide file extension and output name*/
DBMS= xlsx out = excel_data5 replace;
/* not getting the variable names */
/* By default, the import proc will take variable names from the 1st row */
getnames= no;
DATAROW=2;
run;
