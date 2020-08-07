/* Proc export */
/* Export data to create comma-dekimited and excel data files. */
/*  */
/* Procedure features: */
/* The EXPORT procedure statement argument arguments: */
/* DATA= */
/* DBMS= */
/* OUTFILE= */
/* REPLACE */
/*  */
/* Example: exporting a subset of observations to a CSV file */
/* the WHERE option requests a subset of the observations */
/* the OUTFILE option specifies the output file */
/* the DBMS option specifies that the output file is a CSV file, */
/* the REPLACE option overwrites the target CSV, if it exists. */

libname score "/folders/myfolders";

proc export data=score.score_data (where=(gender='f'))
	outfile = '/folders/myfolders/Femalelist.csv'
	dbms=csv replace;
run;


/* change the DBMS=dlm */
proc export data=score.score_data
	outfile = '/folders/myfolders/sd'
	dbms=dlm replace;
	delimiter=' ';
run;

/* example of exporting to a excel file */
proc export data=score.score_data
	outfile = '/folders/myfolders/sd_excel'
	dbms=xlsx replace;
run;
