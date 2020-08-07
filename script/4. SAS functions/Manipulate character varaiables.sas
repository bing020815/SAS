/* Manipulate character varaiables */
/* Functions: */
/* 1. SCAN: as 'split' in python */
/* 2. SUBSTR */
/* 3. TRIM */
/* 4. CATX */
/* 5. INDEX */
/* 6. FIND */
/* 7. UPPERCASE */
/* 8. LOWCASE */
/* 9. PROPCASE */
/* 10. TRANWRD */


/* SCAN(variable, position, delimeters) */
/* create data scoredata0*/
proc import datafile="/folders/myfolders/SAS/Data/chara_data"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0;
last_name = scan(full_name, 1, ',: ');
/* three delimiters, ',', ':' and ' '  */
run;

proc print data=scoredata1;
run;


/* SUBSTR(arugment, position, n) */
proc import datafile = "folders/myfolders/SAS/Data/chara_data1"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0 ;
/* extract */
Exchange = substr(phone, 1 , 3);
run;

data scoredata2;
set scoredata1 ;
/* replace: */
if exchange = '000' then substr(phone, 1, 3) = '408'; 
run;

proc print data=scoredata1 ;
run;



/* TRIM(argument) and CATX(seperator, string-1 <,...string-n>) */
/* create data scoredata0*/
proc import datafile="/folders/myfolders/SAS/Data/chara_data"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1;
set scoredata0 ;
last_name = scan(full_name, 1, ',: ');
first_name = scan(full_name, 2, ',: ');
run;

data scoredata2;
set scoredata1 ;
student_name1 = trim(last_name) || ', ' || trim(first_name);
/* the catx function enables you to concatenate char strings */
/* , removing leading and trailing blanks, and insert seperators */
length student_name2 $25;
student_name2 = catx(', ', last_name, first_name);
drop last_name first_name;
run;
 
proc print data = scoredata2;
run;


/* INDEX(source, excerpt) */
/* create data scoredata0*/
proc import datafile="/folders/myfolders/SAS/Data/chara_data1"
dbms=xlsx out=scoredata0 replace;
run;
/* the INDEX is case sensitive function  */
data scoredata1 ; 
set scoredata0 ;

index_num = index(phone, '408');
run;

data scoredata2 ; 
set scoredata1 ;
numeric_phone = input(phone, 10.);
if index_num = 1; 
/* if index(phone, '408') = 1; */
run;

proc print data= scoredata2; 
title "students with phone area code 408";
run;




/* LOWCASE(argument), UPPERCASE(argument), PROPCASE(argument, ''delimiters') */
/* create data scoredata0*/
proc import datafile="/folders/myfolders/SAS/Data/chara_data1"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1 ; 
set scoredata0; 
full_name_LC = lowcase(full_name);
full_name_UC = upcase(full_name);
full_name_PC1 = propcase(full_name_LC, ' ,:');
run;




/* TRANWRD(source, target, replacement) */
/* create data scoredata0*/
proc import datafile="/folders/myfolders/SAS/Data/chara_data1"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1 ;
set scoredata0 ;
length phone_update $10;
phone_update = TRANWRD(phone, '000', '408');
run; 




/* INT(argument) ROUND(argument,round-off-unit) */
/* create data scoredata0*/
proc import datafile="/folders/myfolders/SAS/Data/score_data"
dbms=xlsx out=scoredata0 replace;
run;

data scoredata1 ;
set scoredata0 ; 
average_score = mean(score1, score2, score3);
run;

data scoredata2 ;
set scoredata1 ;
average_int = INT(average_score);
average_round1 = round(average_score, .1);
average_round2 = round(average_score, .01);
run;

proc print DATA=scoredata2 ;
run;