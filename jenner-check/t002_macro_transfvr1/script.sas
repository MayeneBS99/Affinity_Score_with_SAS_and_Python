/* SCORING PROJECT — %transfvr1 year-grouping feature engineering          */
/* Adapted from notebooks/scoring_project_file.sas. The %transfvr1 macro     */
/* collapses four yearly indicator columns (years -2..-5) into a single      */
/* LFY_ ("Last Four Years") flag. Here it runs against a 30-row inline        */
/* sample of the real AGENCE / celib_F / hotel columns; the macro body is     */
/* the author's, unchanged.                                                   */

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

/* Feature Engineering macro (author's, unchanged) */
%macro transfvr1(var2,var3, var4, var5) ;
if (&var2 = 1) or (&var3=1) or (&var4=1) or (&var5 = 1) then LFY_&var2 = 1;
else if (&var2 = 0) and (&var3=0) and (&var4=0) and (&var5 = 0) then LFY_&var2 = 0;
%mend transfvr1;

DATA SCORING_DATA2;
SET SCORING_DATA;
%transfvr1(AGENCE_2, AGENCE_3, AGENCE_4, AGENCE_5);
%transfvr1(celib_F_2, celib_F_3, celib_F_4, celib_F_5);
%transfvr1(hotel_2, hotel_3, hotel_4, hotel_5);
RUN;

PROC FREQ DATA = SCORING_DATA2;
  TABLES LFY_AGENCE_2 LFY_celib_F_2 LFY_hotel_2;
RUN;
