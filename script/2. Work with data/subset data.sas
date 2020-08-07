proc import datafile='/folders/myfolders/SAS/Data/score_data_miss'  
dbms=xlsx out=scoredata0 replace;
run;

data scoredata_all;
set scoredata0;

/* take	 */
if score1 ~= . & score2 ~= . & score3 ~= . then take = 'complete';
else take = 'incomplete';
run;

proc print data=scoredata_all;
run;

/* subsetting if */
data scoredata_subset_if;
set scoredata_all;
if take = 'complete';
run;

proc print data=scoredata_subset_if;
run;

/* delete */
data scoredata_subset_delete;
set scoredata_all;
if take NE 'complete' then delete;
run;

proc print data=scoredata_subset_delete;
run;