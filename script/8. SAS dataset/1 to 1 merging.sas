proc import datafile="/folders/myfolders/SAS/Data/score_data_id_partial"
dbms=xlsx out=scoredata_p replace;
run;

proc import datafile='/folders/myfolders/SAS/Data/score_data_id'
dbms=xlsx out = scoredata replace;
run;

data onetoone;
set scoredata_p;
set scoredata;
run;

proc print data = onetoone;
title "one to one merge";
run;

proc print data = scoredata_p;
title "partial score data";
run;

proc print data = scoredata;
title "score data";
run;