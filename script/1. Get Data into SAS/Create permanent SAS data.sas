/* Use 'libname _libname_ "_folder_path_" '  to create custom libaray */
/* /create a permanent SAS dataset/ */
libname score "/folders/myfolders";


data score.stu_math;
input 
stu_name $ /* '$' signifies the character datatype*/
math_score /* it signifies the numeric datatype*/;
/* Using 'datalines'/'cards' with 'input' statement to specify it is adding records */
datalines;
Speedy 90
Tim 91
Sharon 100
Mike 60
/* ; must be placed at a new line  */
;
run;

proc print data=stu_math;
run;

/* /create a temparary SAS dataset/ */
data stu_math_temp;
input 
stu_name $ /* '$' signifies the character datatype*/
math_score /* it signifies the numeric datatype*/;
/* Using 'datalines'/'cards' with 'input' statement to specify it is adding records */
datalines;
Speedy 90
Tim 91
Sharon 100
Mike 60
/* ; must be placed at a new line  */
;
run;

proc print data=stu_math;
run;

/*  */
/* When you end this session and want to access the table in the created lib,  */
/* you need to reassign the created lib with 'libname' statement */
