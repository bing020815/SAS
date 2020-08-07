/* PUT and INPUT */
/* PUT(source, format): convert numeric data values to character data values */
/* INPUT(source, informat): convert character values to numeric values */
/* SAS format: controls the written appearance of data values */
/* SAS informat: reads data into SAS */

/* Convert Data */

/* create data scoredata0 */
proc import datafile="/folders/myfolders/SAS/Data/covert data"
dbms=xlsx out=scoredata0 replace ;
run;

/* character-to-numeric conversion */
data scoredata1;
set scoredata0;
score_ac = row_score * 1; 
/*automatically convert to numeric with numeric operation*/
score_num = input(raw_score, 7.1) /*input*/
run;

/* numeric-to-character conversion */
data scoredata2;
set scoredata0;
gender_ac = gender||'/'||gender_code; 
/* ||:concatenate */
/*when numeric is concatenated with string, it will be converted as char*/
gender_char = put(gender_code, 8.); /*put*/
run;