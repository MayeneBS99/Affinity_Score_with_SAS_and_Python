/* SCORING PROJECT — LFY_valca spend feature + PROC MEANS / UNIVARIATE      */
/* Adapted from notebooks/scoring_project_file.sas. LFY_valca sums the four   */
/* yearly spend columns (valca_s2..s5); Previous_buyer / SMALL_ / AVERAGE_ /  */
/* BIG_buyer derive the spend tiers. PROC MEANS and PROC UNIVARIATE then      */
/* profile LFY_valca. Runs against a 30-row inline sample of the real spend   */
/* columns; the author's derivation logic is unchanged.                       */

DATA SCORING_DATA;
  INPUT agereel civilite $ celibat_1 celib_F_1
        AGENCE_2 AGENCE_3 AGENCE_4 AGENCE_5
        celib_F_2 celib_F_3 celib_F_4 celib_F_5
        hotel_2 hotel_3 hotel_4 hotel_5
        valca_s2 valca_s3 valca_s4 valca_s5;
DATALINES;
31 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
50 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2004 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2004 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
82 Mo 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2004 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
70 Ma 1 0 0 0 0 0 0 0 0 0 0 0 0 0 706.65 0 0 0
68 Ma 0 0 1 0 0 0 0 0 0 0 0 0 0 0 511.60582265 0 0 0
57 Ma 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
2004 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
46 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
70 Ma 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
28 Ma 0 0 1 0 0 0 0 0 0 0 1 0 0 0 2142.28 0 0 0
69 Ma 0 0 1 0 0 0 0 0 0 0 0 0 0 0 638.05 0 0 0
55 Ma 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
71 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
76 Ma 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
32 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2004 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
44 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
82 Mo 0 0 0 0 0 0 1 0 0 0 0 0 0 0 520.00944987 0 0 0
2004 Ma 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
48 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
54 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2717.05 0 0 0
49 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
55 Ma 1 0 0 0 0 0 0 0 0 0 0 0 0 0 400.05 0 0 0
64 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
50 Ma 1 0 0 0 0 0 0 0 0 0 0 0 0 0 444.15 0 0 0
80 Ma 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2004 Ma 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1443.75 0 0 0
;
RUN;

data SCORING_DATA4;
set SCORING_DATA;
LFY_valca = valca_s2 + valca_s3 + valca_s4 + valca_s5;
run;

proc means data=SCORING_DATA4;
var LFY_valca;
run;

PROC UNIVARIATE DATA = SCORING_DATA4;
VAR LFY_valca; RUN;

data SCORING_DATA4;
set SCORING_DATA4;
If LFY_valca > 0 then Previous_buyer = 1; ELSE Previous_buyer = 0; RUN;

DATA SCORING_DATA_final;
SET SCORING_DATA4;
If LFY_valca <= 600 then SMALL_buyer = 1; ELSE SMALL_buyer = 0;
If LFY_valca > 600 and LFY_valca <= 1500 then AVERAGE_buyer = 1; ELSE AVERAGE_buyer = 0;
If LFY_valca > 1500 then BIG_buyer = 1; ELSE BIG_buyer = 0;
run;

PROC FREQ DATA = SCORING_DATA_final;
TABLES Previous_buyer SMALL_buyer AVERAGE_buyer BIG_buyer;
RUN;
