/* READ CSV: */

data sdata_csv;
infile "/folders/myfolders/SAS/Data/DATA_commas.csv" dsd;
/* 'dsd': Specifies that when data values are enclosed in quotation marks, 
delimiters within the value are treated as character data */
input
name  $ 
gender $
age
weight 
; 
run;

proc print data=sdata_csv;
run;



/* READ OTHER DELIMETERS: */
data sdata_colon;
infile "/folders/myfolders/SAS/Data/other_del_data.txt" dlm=':';

/* alternative code: */
/* infile "/folders/myfolders/SAS/Data/other_del_data.txt" delimiter=':'; */
/* infile "/folders/myfolders/SAS/Data/other_del_data.txt" dsd dlm=':'; */

input
name  $ 
gender $
age
weight 
; 
run;
proc print data=sdata_colon;
run;
