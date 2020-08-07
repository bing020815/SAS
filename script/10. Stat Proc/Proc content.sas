/* Proc Contents */
/* to View the contents of SAS Library */


libname score "/folders/myfolders";


/* nods option is to suppress the descriptor portions in the report */
proc contents data = score._ALL_ nods;
run;
proc contents data = score._ALL_;
run;


proc contents data=score.score_data;
run;