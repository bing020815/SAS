/* Instruction: */
/* 1. read data using formatted input */
/* 2. display sdate edate with format date9 */
/* 3. create a permanent data set */

libname mydata "/folders/myfolders";

data mydata.patient_data;
infile "/folders/myfolders/SAS/Data/Patient_HD_age.txt";
input
@1 Pid  1.
@2 Sdate mmddyy10.
@12 Edate mmddyy10.
@22 age 2.;
/* this show the date data in raw format (internal value) */
/* you can also include format the data format in here: */
format Sdate Edate date9.;
run;