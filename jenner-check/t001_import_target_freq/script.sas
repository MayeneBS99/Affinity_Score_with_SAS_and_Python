/* SCORING PROJECT — target variable + TARGET distribution                 */
/* Adapted from notebooks/scoring_project_file.sas: the PROC IMPORT of      */
/* ficetude_voyage_seg3.txt is replaced by an inline DATA step carrying a    */
/* 30-row sample of the real survey columns, so the target rule and the     */
/* formatted TARGET frequency run self-contained. Logic is unchanged.       */

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

/* 1-) Target variable implementation */
DATA SCORING_DATA2;
SET SCORING_DATA;
IF (celibat_1 = 1 ) or (celib_F_1 = 1) THEN TARGET = 1;
ELSE TARGET = 0;
RUN;

/* Graphic on Target variable — binary format */
PROC FORMAT;
    * Cree le format binaire;
    VALUE target_cat
        0 = 'Non'
        1 = 'Oui';
RUN;

PROC freq DATA = SCORING_DATA2;
    TABLES target;
    FORMAT target target_cat.;
RUN;
