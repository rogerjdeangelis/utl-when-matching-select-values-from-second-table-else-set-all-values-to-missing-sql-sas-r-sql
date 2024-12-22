%let pgm=utl-when-matching-select-values-from-second-table-else-set-all-values-to-missing-sql-sas-r-sql;

When matching select values from second table else set all values to missing sql sas r sql

github
https://tinyurl.com/2hszx6wc
https://github.com/rogerjdeangelis/utl-when-matching-select-values-from-second-table-else-set-all-values-to-missing-sql-sas-r-sql

stackoverflow SAS
https://tinyurl.com/4ru9t45t
https://stackoverflow.com/questions/79297713/replace-values-in-a-dataset-with-values-in-another-dataset-but-only-when-a-varia

SOAPBOX ON

 You can use sas 'proc sql' coding in R and python to prepare
 data for the many state of the art packages in r and python.

SOAPBOX OFF

Note this is  trival with a datastep if the inputs are sorted;

/*---- since have does not have variable1 and variable2 they    ----*/
/*---- will be set to missing else variable1 and variable2      ----*/
/*---- will contain values form the second table                ----*/

data want;
   merge have(drop=variable1 variable2) have1;
   by id admission discharge index;
run;quit;


/**************************************************************************************************************************/
/*                                             |                              |                                           */
/*                   INPUT                     |      PROCESS                 |                   OUTPUT                  */
/*                   =====                     |      =======                 |                   ======                  */
/*                                             |                              |                                           */
/*   SD1.MASTER                                | SAS SOLUTION                 |   ID    ADMIT       DSG     IDX VAR1 VAR2 */
/*                                             | =============                |                                           */
/*    ID    ADMIT        DSG     IDX VAR1 VAR2 |                              |  0001 2015-01-13 2015-01-20  1    6    8  */
/*                                             | select                       |  0001 2015-02-21 2015-12-31  2    .    .  */
/*   0001 2015-02-21  2015-12-31  2    .    2  |     l.id                     |  0001 2015-02-21 2015-12-31  3    .    .  */
/*   0001 2015-01-13  2015-01-20  1    2    4  |    ,l.admit                  |  0001 2019-01-01 2019-12-31  1    .    .  */
/*   0001 2015-02-21  2015-12-31  3    3    .  |    ,l.dsg                    |  0002 2015-01-01 2015-12-31  5    .    .  */
/*   0001 2019-01-01  2019-12-31  1    6    9  |    ,l.idx                    |  0002 2019-01-01 2019-10-31  1    4    2  */
/*   0002 2019-01-01  2019-10-31  1    .    2  |    ,r.var1                   |  0002 2019-01-01 2019-10-31  7    .    .  */
/*   0002 2015-01-01  2015-12-31  5    2    .  |    ,r.var2                   |                                           */
/*   0002 2019-01-01  2019-10-31  7    .    2  | from                         |                                           */
/*                                             |    sd1.master as l           |                                           */
/*                                             |  left                        |                                           */
/*                                             |    join sd1.transaction as r |                                           */
/*   SD1.TRANSACTION                           |  on                          |                                           */
/*                                             |         l.id     =  r.id     |                                           */
/*    ID    ADMIT        DSG     IDX VAR1 VAR2 |     and l.admit  =  r.admit  |                                           */
/*                                             |     and l.dsg    =  r.dsg    |                                           */
/*   0002 2019-01-01  2019-10-31  1    4    2  |     and l.idx    =  r.idx    |                                           */
/*   0001 2015-01-13  2015-01-20  1    6    8  |                              |                                           */
/*                                             |                              |                                           */
/*                                             | SAME CODE IN R AND PYTHON    |                                           */
/*                                             | =========================    |                                           */
/*                                             |                              |                                           */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.master;
  input ID$ admit $11. dsg $11.
        idx var1 var2;
cards4;
0001 2015-02-21 2015-12-31 2 .  2
0001 2015-01-13 2015-01-20 1 2  4
0001 2015-02-21 2015-12-31 3 3  .
0001 2019-01-01 2019-12-31 1 6  9
0002 2019-01-01 2019-10-31 1 .  2
0002 2015-01-01 2015-12-31 5 2  .
0002 2019-01-01 2019-10-31 7 .  2
;;;;
run;quit;

data sd1.transaction;
  input ID$ admit $11. dsg $11.
        idx var1 var2;
cards4;
0002 2019-01-01 2019-10-31 1  4  2
0001 2015-01-13 2015-01-20 1  6  8
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                              |                                                                         */
/*  SD1.MASTER                                  |  SD1.TRANSACTION                                                        */
/*                                              |                                                                         */
/*   ID    ADMIT        DSG     IDX VAR1 VAR2   |   ID    ADMIT        DSG     IDX VAR1 VAR2                              */
/*                                              |                                                                         */
/*  0001 2015-02-21  2015-12-31  2    .    2    |  0002 2019-01-01  2019-10-31  1    4    2                               */
/*  0001 2015-01-13  2015-01-20  1    2    4    |  0001 2015-01-13  2015-01-20  1    6    8                               */
/*  0001 2015-02-21  2015-12-31  3    3    .    |                                                                         */
/*  0001 2019-01-01  2019-12-31  1    6    9    |                                                                         */
/*  0002 2019-01-01  2019-10-31  1    .    2    |                                                                         */
/*  0002 2015-01-01  2015-12-31  5    2    .    |                                                                         */
/*  0002 2019-01-01  2019-10-31  7    .    2    |                                                                         */
/*                                              |                                                                         */
/***************************************************************************************************************************/

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

proc sql;
  create
    table want as
  select
      l.id
     ,l.admit
     ,l.dsg
     ,l.idx
     ,r.var1 /*--- only use right values ssing ---*/
     ,r.var2
  from
     sd1.master as l left join sd1.transaction as r
  on
         l.id     =  r.id
     and l.admit  =  r.admit
     and l.dsg    =  r.dsg
     and l.idx    =  r.idx
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*   ID       ADMIT          DSG        IDX    VAR1    VAR2                                                               */
/*                                                                                                                        */
/*  0001    2015-01-13    2015-01-20     1       6       8                                                                */
/*  0001    2015-02-21    2015-12-31     2       .       .                                                                */
/*  0001    2015-02-21    2015-12-31     3       .       .                                                                */
/*  0001    2019-01-01    2019-12-31     1       .       .                                                                */
/*  0002    2015-01-01    2015-12-31     5       .       .                                                                */
/*  0002    2019-01-01    2019-10-31     1       4       2                                                                */
/*  0002    2019-01-01    2019-10-31     7       .       .                                                                */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/


%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
master     <-read_sas("d:/sd1/master.sas7bdat")
trans<-read_sas("d:/sd1/transaction.sas7bdat")
print(master)
print(trans)
want<-sqldf('
  select
    l.id
   ,l.admit
   ,l.dsg
   ,l.idx
   ,r.var1
   ,r.var2
  from
     master as l left join trans as r
  on
         l.id     =  r.id
     and l.admit  =  r.admit
     and l.dsg    =  r.dsg
     and l.idx    =  r.idx
  order
     by  l.id
        ,l.admit
        ,l.dsg
        ,l.idx
 ')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                             |                                                          */
/* R                                                           | SAS                                                      */
/*                                                             |                                                          */
/*      ID      ADMIT        DSG   IDX VAR1 VAR2    ROWNAMES   |  ID       ADMIT          DSG        IDX    VAR1    VAR2  */
/*                                                             |                                                          */
/*  1 1 0001 2015-01-13 2015-01-20   1    6    8        1      | 0001    2015-01-13    2015-01-20     1       6       8   */
/*  2 2 0001 2015-02-21 2015-12-31   2   NA   NA        2      | 0001    2015-02-21    2015-12-31     2       .       .   */
/*  3 3 0001 2015-02-21 2015-12-31   3   NA   NA        3      | 0001    2015-02-21    2015-12-31     3       .       .   */
/*  4 4 0001 2019-01-01 2019-12-31   1   NA   NA        4      | 0001    2019-01-01    2019-12-31     1       .       .   */
/*  5 5 0002 2015-01-01 2015-12-31   5   NA   NA        5      | 0002    2015-01-01    2015-12-31     5       .       .   */
/*  6 6 0002 2019-01-01 2019-10-31   1    4    2        6      | 0002    2019-01-01    2019-10-31     1       4       2   */
/*  7 7 0002 2019-01-01 2019-10-31   7   NA   NA        7      | 0002    2019-01-01    2019-10-31     7       .       .   */
/*                                                             |                                                          */
/**************************************************************************************************************************/

/*___                _   _                             _
|___ \   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  __) | | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 / __/  | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|_____| | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/


proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
master,meta = ps.read_sas7bdat('d:/sd1/master.sas7bdat');
trans,meta = ps.read_sas7bdat('d:/sd1/transaction.sas7bdat');
want=pdsql('''
  select
    l.id
   ,l.admit
   ,l.dsg
   ,l.idx
   ,r.var1
   ,r.var2
  from
     master as l left join trans as r
  on
         l.id     =  r.id
     and l.admit  =  r.admit
     and l.dsg    =  r.dsg
     and l.idx    =  r.idx
  order
     by  l.id
        ,l.admit
        ,l.dsg
        ,l.idx
   ''');
print(want);
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                           |                                                            */
/* PYTHON                                              SAS   |                                                            */
/*                                                           |                                                            */
/*       ID       ADMIT         DSG  IDX  VAR1  VAR2    ID   |    ADMIT          DSG        IDX    VAR1    VAR2           */
/*                                                           |                                                            */
/*  0  0001  2015-01-13  2015-01-20  1.0   6.0   8.0   0001  |  2015-01-13    2015-01-20     1       6       8            */
/*  1  0001  2015-02-21  2015-12-31  2.0   NaN   NaN   0001  |  2015-02-21    2015-12-31     2       .       .            */
/*  2  0001  2015-02-21  2015-12-31  3.0   NaN   NaN   0001  |  2015-02-21    2015-12-31     3       .       .            */
/*  3  0001  2019-01-01  2019-12-31  1.0   NaN   NaN   0001  |  2019-01-01    2019-12-31     1       .       .            */
/*  4  0002  2015-01-01  2015-12-31  5.0   NaN   NaN   0002  |  2015-01-01    2015-12-31     5       .       .            */
/*  5  0002  2019-01-01  2019-10-31  1.0   4.0   2.0   0002  |  2019-01-01    2019-10-31     1       4       2            */
/*  6  0002  2019-01-01  2019-10-31  7.0   NaN   NaN   0002  |  2019-01-01    2019-10-31     7       .       .            */
/*                                                           |                                                            */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

