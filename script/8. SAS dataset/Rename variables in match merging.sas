proc import 
datafile="/folders/myfolders/SAS/Data/score_data_id_partial_score4_genderNA"
dbms=xlsx out= scoredata_p_na replace ;
run; 

proc import datafile="/folders/myfolders/SAS/Data/score_data_id"
dbms=xlsx out= scoredata replace ;
run;

/* match and asending */
proc sort data = scoredata_p_na ;
by stu_id;
run;
proc sort data = scoredata ;
by stu_id;
run;
data MMA; 
merge scoredata scoredata_p_na ;
by stu_id;
run;

proc print data = MMA;
title "match merging ascending_gender missing";
run; 
proc print data=scoredata_p_na;
title "partial score data_gender missing";
run;
proc print data=scoredata;
title "score data";
run; 

/* rename */
data MMA;
merge scoredata scoredata_p_na (rename=(gender = gender_na));
by stu_id;
run;
proc print data = MMA;
title "match merging ascending_rename";
run; 
proc print data=scoredata_p_na;
title "partial score data_gender missing";
run;
proc print data=scoredata;
title "score data";
run; 