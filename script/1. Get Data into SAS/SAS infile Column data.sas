data sdata_column;
infile "/folders/myfolders/SAS/Data/DATA_column.txt";
input
@1 name  $ 5.
@6 gender $ 1.
@7 weight 3.
@10 DOB mmddyy10.;  
/* this show the date data in raw format (internal value) */
/* you can also include format the data format in here: */
/* format DOB mmddyy10.; */
run;

proc print data=sdata_column;
/* date data in raw format */
run;	

proc print data=sdata_column;
/* change raw date data into ISO readable format */
format DOB mmddyy10.;
run;

proc print data=sdata_column;
/* change raw date data into text readable format */
format DOB date9.;
run;