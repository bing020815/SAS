/* Output Delivery System (ODS) Instruction */
/*  */
/* 1. EPUB Output: for e-book readers */
/* 2. Excel Output */
/* 3. HTML Output */
/* 4. PDF Output */
/* 5. RTF Output : for MS word*/
/* 6. PowerPoint Output */


proc import datafile="/folders/myfolders/SAS/Data/score_data_miss999"
dbms=xlsx out= scoredata0 replace;
run;

ods pdf file = "/folders/myfolders/scoredata0.pdf";
ods rtf file = "/folders/myfolders/scoredata0.rtf";
ods powerpoint file = "/folders/myfolders/scoredata0.ppt";
proc print data=scoredata0;
id name;
run;

ods pdf close;
ods rtf close;
ods powerpoint close;
/* ods _ALL_close; */