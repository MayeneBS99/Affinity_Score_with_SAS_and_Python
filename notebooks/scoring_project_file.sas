/* SCORING PROJECT */

LIBNAME SCORING '/home/u62726202/scoring_project/';

PROC IMPORT DATAFILE = '/home/u62726202/scoring_project/ficetude_voyage_seg3.txt'
                     OUT = SCORING.DATA
                     DBMS = DLM
                     REPLACE;
            GETNAMES = YES;
            DELIMITER = ';';
RUN;

PROC CONTENTS DATA = SCORING.DATA ; RUN;


/*-------------------------------  FEATURE ENGINEERING ---------------------------*/

/* 1-) Target variable implementation */
DATA SCORING.DATA2 ;
SET SCORING.DATA; 
IF (celibat_1 = 1 ) or (celib_F_1 = 1) THEN TARGET = 1;
ELSE TARGET = 0;

/* 2- Dropping other variables in  n-1 year */
DROP AGENCE_1 COURRIER_1 ETE_1 HIVER_1 CURES_1 FAMILLE_1 GROUPE_1 HAUTGAMME_1 
LASTTRAVEL_1 PLAGE_1 SENIOR_1 TRAVEL_BABY_1 FAMILY_1 grou_adul_1 grou_enf_1 hotel_1 
parc_lois_1 sej_CAM_1 sej_CAP_1 senior_HG_1 sport_1 thalasso_1 theme_1 trekking2_1 
TREKKING_1 ENF_0_2ANS_1 ENF_11_12ANS_1 ENF_13_14ANS_1 ENF_14_16ANS_1 ENF_3_4ANS_1 
ENF_5_6ANS_1 ENF_7_8ANS_1 ENF_9_10ANS_1 ENFANT_1 HA_1 NBACT_HA_S1 NBACT_HA_S0 grou_enf_0 therme_1
segment_s1 celibat_1 celib_F_1 INTERNET_1; 
RUN;


/* 3-  Feature Engineering */

%macro transfvr1(var2,var3, var4, var5) ; 
if (&var2 = 1) or (&var3=1) or (&var4=1) or (&var5 = 1) then LFY_&var2 = 1; 
else if (&var2 = 0) and (&var3=0) and (&var4=0) and (&var5 = 0) then LFY_&var2 = 0; 
%mend transfvr1;  


DATA SCORING.DATA2 ; 
SET SCORING.DATA2; 
%transfvr1(AGENCE_2, AGENCE_3, AGENCE_4,AGENCE_5); 
%transfvr1(COURRIER_2, COURRIER_3, COURRIER_4,COURRIER_5); 
%transfvr1(CURES_2, CURES_3, CURES_4,CURES_5); 
%transfvr1(ENFANT_2, ENFANT_3, ENFANT_4,ENFANT_5); 
%transfvr1(ENF_0_2ANS_2, ENF_0_2ANS_3, ENF_0_2ANS_4,ENF_0_2ANS_5); 
%transfvr1(ENF_11_12ANS_2, ENF_11_12ANS_3, ENF_11_12ANS_4,ENF_11_12ANS_5); 
%transfvr1(ENF_13_14ANS_2, ENF_13_14ANS_3, ENF_13_14ANS_4,ENF_13_14ANS_5); 
%transfvr1(ENF_14_16ANS_2, ENF_14_16ANS_3, ENF_14_16ANS_4,ENF_14_16ANS_5); 
%transfvr1(ENF_3_4ANS_2, ENF_3_4ANS_3, ENF_3_4ANS_4,ENF_11_12ANS_5); 
%transfvr1(ENF_5_6ANS_2, ENF_5_6ANS_3, ENF_5_6ANS_4,ENF_5_6ANS_5); 
%transfvr1(ENF_7_8ANS_2, ENF_7_8ANS_3, ENF_7_8ANS_4,ENF_7_8ANS_5); 
%transfvr1(ENF_9_10ANS_2, ENF_9_10ANS_3, ENF_9_10ANS_4,ENF_9_10ANS_5); 
%transfvr1(trekking2_2, trekking2_3, trekking2_4,trekking2_5); 
%transfvr1(therme_2, therme_3, therme_4,therme_5); 
%transfvr1(thalasso_2, thalasso_3, thalasso_4,thalasso_5); 
%transfvr1(sport_2, sport_3, sport_4,sport_5); 
%transfvr1(senior_HG_2, senior_HG_3, senior_HG_4,senior_HG_5); 
%transfvr1(sej_CAP_2, ssej_CAP_3, sej_CAP_4,sej_CAP_5); 
%transfvr1(sej_CAM_2, sej_CAM_3, sej_CAM_4,sej_CAM_5); 
%transfvr1(parc_lois_2, parc_lois_3, parc_lois_4,parc_lois_5); 
%transfvr1(grou_enf_2, grou_enf_3, grou_enf_4,grou_enf_5); 
%transfvr1(grou_adul_2, grou_adul_3, grou_adul_4,grou_adul_5); 
%transfvr1(FAMILY_2, FAMILY_3, FAMILY_4,FAMILY_5); 
%transfvr1(FAMILLE_2, FAMILLE_3, FAMILLE_4,FAMILLE_5); 
%transfvr1(GROUPE_2, GROUPE_3, GROUPE_4,GROUPE_5); 
%transfvr1(HAUTGAMME_2, HAUTGAMME_3, HAUTGAMME_4,HAUTGAMME_5); 
%transfvr1(ETE_2, ETE_3, ETE_4,ETE_5); 
%transfvr1(HA_2, HA_3, HA_4,HA_5); 
%transfvr1(HIVER_2, HIVER_3, HIVER_4,HIVER_5); 
%transfvr1(INTERNET_2, INTERNET_3, INTERNET_4,INTERNET_5); 
%transfvr1(LASTTRAVEL_2, LASTTRAVEL_3, LASTTRAVEL_4,LASTTRAVEL_5); 
%transfvr1(PLAGE_2, PLAGE_3, PLAGE_4,PLAGE_5); 
%transfvr1(SENIOR_2, SENIOR_3, SENIOR_4,SENIOR_5); 
%transfvr1(TRAVEL_BABY_2, TRAVEL_BABY_3, TRAVEL_BABY_4,TRAVEL_BABY_5); 
%transfvr1(trekking_2, trekking_3, trekking_4,trekking_5); 
%transfvr1(celib_f_2, celib_f_3, celib_f_4,celib_f_5); 
%transfvr1(celibat_2, celibat_3, celibat_4,celibat_5); 
%transfvr1(TRAVEL_BABY_2, TRAVEL_BABY_3, TRAVEL_BABY_4,TRAVEL_BABY_5); 
%transfvr1(hotel_2, hotel_3, hotel_4,hotel_5);


%macro transfvr2(var2,var3, var4, var5) ; 
if (&var2 = 1) or (&var3=1) or (&var4=1) or (&var5 = 1) then MT5Y_&var2  = 1; 
else if (&var2 = 0) and (&var3=0) and (&var4=0) and (&var5 = 0) then MT5Y_&var2  = 0; 
%mend transfvr2; 

DATA SCORING.DATA3 ; 
SET SCORING.DATA2; 
%transfvr2(AGENCE_6, AGENCE_7, AGENCE_8,AGENCE_9); 
%transfvr2(COURRIER_6, COURRIER_7, COURRIER_8,COURRIER_9); 
%transfvr2(CURES_6, CURES_7, CURES_8,CURES_9); 
%transfvr2(ENFANT_6, ENFANT_7, ENFANT_8,ENFANT_9); 
%transfvr2(ENF_0_2ANS_6, ENF_0_2ANS_7, ENF_0_2ANS_8,ENF_0_2ANS_9); 
%transfvr2(ENF_11_12ANS_6, ENF_11_12ANS_7, ENF_11_12ANS_8,ENF_11_12ANS_9); 
%transfvr2(ENF_13_14ANS_6, ENF_13_14ANS_7, ENF_13_14ANS_8,ENF_13_14ANS_9); 
%transfvr2(ENF_14_16ANS_6, ENF_14_16ANS_7, ENF_14_16ANS_8,ENF_14_16ANS_9); 
%transfvr2(ENF_3_4ANS_6, ENF_3_4ANS_7, ENF_3_4ANS_8,ENF_11_12ANS_9); 
%transfvr2(ENF_5_6ANS_6, ENF_5_6ANS_7, ENF_5_6ANS_8,ENF_5_6ANS_9); 
%transfvr2(ENF_7_8ANS_6, ENF_7_8ANS_7, ENF_7_8ANS_8,ENF_7_8ANS_9); 
%transfvr2(ENF_9_10ANS_6, ENF_9_10ANS_7, ENF_9_10ANS_8,ENF_9_10ANS_9); 
%transfvr2(trekking2_6, trekking2_7, trekking2_8,trekking2_9); 
%transfvr2(therme_6, therme_7, therme_8,therme_9); 
%transfvr2(thalasso_6, thalasso_7, thalasso_8,thalasso_9); 
%transfvr2(sport_6, sport_7, sport_8,sport_9); 
%transfvr2(senior_HG_6, senior_HG_7, senior_HG_8,senior_HG_9); 
%transfvr2(sej_CAP_6, sej_CAP_7, sej_CAP_8,sej_CAP_9); 
%transfvr2(sej_CAM_6, sej_CAM_7, sej_CAM_8,sej_CAM_9); 
%transfvr2(parc_lois_6, parc_lois_7, parc_lois_8,parc_lois_9); 
%transfvr2(grou_enf_6, grou_enf_7, grou_enf_8,grou_enf_9); 
%transfvr2(grou_adul_6, grou_adul_7, grou_adul_8,grou_adul_9); 
%transfvr2(FAMILY_6, FAMILY_7, FAMILY_8,FAMILY_9); 
%transfvr2(FAMILLE_6, FAMILLE_7, FAMILLE_8,FAMILLE_9); 
%transfvr2(GROUPE_6, GROUPE_7, GROUPE_8,GROUPE_9); 
%transfvr2(HAUTGAMME_6, HAUTGAMME_7, HAUTGAMME_8,HAUTGAMME_9); 
%transfvr2(ETE_6, ETE_7, ETE_8,ETE_9); 
%transfvr2(HIVER_6, HIVER_7, HIVER_8,HIVER_9); 
%transfvr2(INTERNET_6, INTERNET_7, INTERNET_8,INTERNET_9); 
%transfvr2(LASTTRAVEL_6, LASTTRAVEL_7, LASTTRAVEL_8,LASTTRAVEL_9); 
%transfvr2(PLAGE_6, PLAGE_7, PLAGE_8,PLAGE_9); 
%transfvr2(SENIOR_6, SENIOR_7, SENIOR_8,SENIOR_9); 
%transfvr2(TRAVEL_BABY_6, TRAVEL_BABY_7, TRAVEL_BABY_8,TRAVEL_BABY_9); 
%transfvr2(trekking_6, trekking_7, trekking_8,trekking_9); 
%transfvr2(celib_f_6, celib_f_7, celib_f_8,celib_f_9); 
%transfvr2(celibat_6, celibat_7, celibat_8,celibat_9); 
%transfvr2(TRAVEL_BABY_6, TRAVEL_BABY_7, TRAVEL_BABY_8,TRAVEL_BABY_9); 
%transfvr2(hotel_6, hotel_7, hotel_8,hotel_9);
Run;

/***** Deleting multiple variables *******/ 
DATA SCORING.DATA3; 
set SCORING.DATA3; 
DROP AGENCE_2 AGENCE_3 AGENCE_4 AGENCE_5 
COURRIER_2 COURRIER_3 COURRIER_4 COURRIER_5 
CURES_2 CURES_3 CURES_4 CURES_5 
ENFANT_2 ENFANT_3 ENFANT_4 ENFANT_5 ENF_0_2ANS_2 ENF_0_2ANS_3  
ENF_0_2ANS_4 ENF_0_2ANS_5 ENF_11_12ANS_2 ENF_11_12ANS_3 
ENF_11_12ANS_4 ENF_11_12ANS_5 ENF_13_14ANS_2 ENF_13_14ANS_3  
ENF_13_14ANS_4 ENF_13_14ANS_5 ENF_14_16ANS_2 ENF_14_16ANS_3 ENF_14_16ANS_4  
ENF_14_16ANS_5 
ENF_3_4ANS_2 ENF_3_4ANS_3 ENF_3_4ANS_4 ENF_3_4ANS_5 
ENF_5_6ANS_2 ENF_5_6ANS_3 ENF_5_6ANS_4 ENF_5_6ANS_5 
ENF_7_8ANS_2 ENF_7_8ANS_3 ENF_7_8ANS_4 ENF_7_8ANS_5 
ENF_9_10ANS_2 ENF_9_10ANS_3 ENF_9_10ANS_4 ENF_9_10ANS_5 
trekking2_2 trekking2_3 trekking2_4 trekking2_5 
therme_2 therme_3 therme_4 therme_5 
thalasso_2 thalasso_3 thalasso_4 thalasso_5 
sport_2 sport_3 sport_4 sport_5 
senior_HG_2 senior_HG_3 senior_HG_4 senior_HG_5 
sej_CAP_2 sej_CAP_3 sej_CAP_4 sej_CAP_5 
sej_CAM_2 sej_CAM_3 sej_CAM_4 sej_CAM_5 
parc_lois_2 parc_lois_3 parc_lois_4 parc_lois_5 
grou_enf_2 grou_enf_3 grou_enf_4 grou_enf_5 
grou_adul_2 grou_adul_3 grou_adul_4 grou_adul_5 
FAMILY_2 FAMILY_3 FAMILY_4 FAMILY_5 
FAMILLE_2 FAMILLE_3 FAMILLE_4 FAMILLE_5 
GROUPE_2 GROUPE_3 GROUPE_4 GROUPE_5 
HAUTGAMME_2 HAUTGAMME_3 HAUTGAMME_4 HAUTGAMME_5 
ETE_2 ETE_3 ETE_4 ETE_5 HA_2 HA_3 HA_4 HA_5 
HIVER_2 HIVER_3 HIVER_4 HIVER_5 
INTERNET_2 INTERNET_3 INTERNET_4 INTERNET_5 
LASTTRAVEL_2 LASTTRAVEL_3 LASTTRAVEL_4 LASTTRAVEL_5 
NBACT_HA_2 NBACT_HA_3 NBACT_HA_4 NBACT_HA_5 
PLAGE_2 PLAGE_3 PLAGE_4 PLAGE_5 
SENIOR_2 SENIOR_3 SENIOR_4 SENIOR_5 
TRAVEL_BABY_2 TRAVEL_BABY_3 TRAVEL_BABY_4 TRAVEL_BABY_5 
trekking_2 trekking_3 trekking_4 trekking_5 
celib_f_2 celib_f_3 celib_f_4 celib_f_5 
celibat_2 celibat_3  celibat_4 celibat_5 
TRAVEL_BABY_2 TRAVEL_BABY_3 TRAVEL_BABY_4 TRAVEL_BABY_5 
hotel_2 hotel_3 hotel_4 hotel_5 
AGENCE_6 AGENCE_7 AGENCE_8 AGENCE_9 
COURRIER_6 COURRIER_7 COURRIER_8 COURRIER_9 
CURES_6 CURES_7 CURES_8 CURES_9 
ENFANT_6 ENFANT_7 ENFANT_8 ENFANT_9 
ENF_0_2ANS_6 ENF_0_2ANS_7 ENF_0_2ANS_8 ENF_0_2ANS_9 
ENF_11_12ANS_6 ENF_11_12ANS_7 ENF_11_12ANS_8 ENF_11_12ANS_9 
ENF_13_14ANS_6 ENF_13_14ANS_7 ENF_13_14ANS_8 ENF_13_14ANS_9 
ENF_14_16ANS_6 ENF_14_16ANS_7 ENF_14_16ANS_8 ENF_14_16ANS_9 
ENF_3_4ANS_6 ENF_3_4ANS_7 ENF_3_4ANS_8 ENF_3_4ANS_9 
ENF_5_6ANS_6 ENF_5_6ANS_7 ENF_5_6ANS_8 ENF_5_6ANS_9 
ENF_7_8ANS_6 ENF_7_8ANS_7 ENF_7_8ANS_8 ENF_7_8ANS_9 
ENF_9_10ANS_6 ENF_9_10ANS_7 ENF_9_10ANS_8 ENF_9_10ANS_9 
trekking2_6 trekking2_7 trekking2_8 trekking2_9 
therme_6 therme_7 therme_8 therme_9 
thalasso_6 thalasso_7 thalasso_8 thalasso_9 
sport_6 sport_7 sport_8 sport_9 
senior_HG_6 senior_HG_7 senior_HG_8 senior_HG_9 
sej_CAP_6 sej_CAP_7 sej_CAP_8 sej_CAP_9 
sej_CAM_6 sej_CAM_7 sej_CAM_8 sej_CAM_9 
parc_lois_6 parc_lois_7 parc_lois_8 parc_lois_9 
grou_enf_6 grou_enf_7 grou_enf_8 grou_enf_9 
grou_adul_6 grou_adul_7 grou_adul_8 grou_adul_9 
FAMILY_6 FAMILY_7 FAMILY_8 FAMILY_9 
FAMILLE_6 FAMILLE_7 FAMILLE_8 FAMILLE_9 
GROUPE_6 GROUPE_7 GROUPE_8 GROUPE_9 
HAUTGAMME_6 HAUTGAMME_7 HAUTGAMME_8 HAUTGAMME_9 
ETE_6 ETE_7 ETE_8 ETE_9 
HA_6 HA_7 HA_8 HA_9 
HIVER_6 HIVER_7 HIVER_8 HIVER_9 
INTERNET_6 INTERNET_7 INTERNET_8 INTERNET_9 
LASTTRAVEL_6 LASTTRAVEL_7 LASTTRAVEL_8 LASTTRAVEL_9 
NBACT_HA_6 NBACT_HA_7 NBACT_HA_8 NBACT_HA_9 
PLAGE_6 PLAGE_7 PLAGE_8 PLAGE_9 
SENIOR_6 SENIOR_7 SENIOR_8 SENIOR_9 
TRAVEL_BABY_6 TRAVEL_BABY_7 TRAVEL_BABY_8 TRAVEL_BABY_9 
trekking_6 trekking_7 trekking_8 trekking_9 
celib_f_6 celib_f_7 celib_f_8 celib_f_9 
celibat_6 celibat_7 celibat_8 celibat_9 
TRAVEL_BABY_6 TRAVEL_BABY_7 TRAVEL_BABY_8 TRAVEL_BABY_9 
hotel_6 hotel_7 hotel_8 hotel_9
grou_enfant_2 grou_enfant_3 grou_enfant_4 grou_enfant_5
grou_enfant_6 grou_enfant_7 grou_enfant_8 grou_enfant_9
NBACT_HA_S2 NBACT_HA_S3 NBACT_HA_S4 NBACT_HA_S5; 
RUN;

PROC CONTENTS DATA= SCORING.DATA3; RUN; 

/********* Transformation de la variable agereel *********/ 
data SCORING.DATA4; 
set SCORING.DATA3; 

If agereel <= 25 then AGE_inferior25 = 1; ELSE AGE_inferior25 = 0; 
If agereel >= 26 and agereel <= 35 then AGE_26_35 = 1; ELSE AGE_26_35 = 0; 
If agereel >= 36 and agereel <= 49 then AGE_36_49 = 1; ELSE AGE_36_49 = 0; 
If agereel >= 50 and agereel <= 64 then AGE_50_64 = 1; ELSE AGE_50_64 = 0; 
If agereel >= 65 and agereel <= 120 then AGE_plus65 = 1; ELSE AGE_plus65 = 0; 

if civilite = "Mo" then civilite = 0;  
else if civilite = "Ma" then civilite = 1; 

LFY_valca = valca_s2 + valca_s3 + valca_s4 + valca_s5; 

Drop agereel tranche_urbaine valca_s1 valca_s2 valca_s3 valca_s4 valca_s5 ; 
run; 


proc means data=SCORING.DATA4; 
var LFY_valca; 
ods output Summary=proc_means; 
run;

PROC UNIVARIATE DATA = SCORING.DATA4;
VAR LFY_valca; RUN;


data SCORING.DATA4; 
set SCORING.DATA4; 
If LFY_valca > 0 then Previous_buyer = 1; ELSE Previous_buyer = 0; RUN;

PROC UNIVARIATE DATA=SCORING.DATA4;
    WHERE Previous_buyer  = 1; /* N'inclut que les observations où la dépense est > 0 */
    VAR LFY_valca;
    OUTPUT OUT=Quantiles_NonNuls PCTLPRE=P PCTLPTS=20 40 60 80;  /*Calcule les 5 quantiles */
RUN;

/* We divided this variable in 3 categories according to percentiles */
DATA SCORING.DATA_final;
SET SCORING.DATA4;

If LFY_valca <= 600 then SMALL_buyer = 1; ELSE SMALL_buyer = 0; 
If LFY_valca > 600 and LFY_valca <= 1500 then AVERAGE_buyer = 1; ELSE AVERAGE_buyer = 0; 
If LFY_valca > 1500 then BIG_buyer = 1; ELSE BIG_buyer = 0; 

Drop valca_s2 valca_s3 valca_s4 valca_s5 LFY_valca region Type_Habitat num_cli fin ssej_CAP_3;  
run;


/* 4- Missing values */

PROC FREQ DATA = scoring.data_final;
TABLES _CHARACTER_ / MISSING ;
RUN;

PROC MEANS DATA = scoring.data_final;
VAR _NUMERIC_;
RUN;

/*Deleting variables with lower information inside the dataset */
DATA SCORING.DATA_final ;
set SCORING.DATA_final;

DROP LFY_sej_CAP_2 LFY_GROUPE_2; RUN;





/*-------------------------------  STATISTIC ANALYSIS ---------------------------*/


/**** Chi-2 Test**/

%MACRO frq_chisq(var); 
*ods trace on; 
ods output ChiSq=sample_resultats; 
PROC FREQ DATA=SCORING.DATA_final; 
TABLES TARGET* &var/ CHISQ noprint; RUN; 

data val_chisq; 
set sample_resultats; 
if _n_=1; keep table prob;run;
 
data vcramer; 
set sample_resultats; 
if _n_=6; keep table value;run;
 
data sample_resultats; 
merge val_chisq vcramer;run; 
proc append base = chisq_quali 
data=sample_resultats force; run; 
%mend frq_chisq; 

%frq_chisq(AGE_26_35)
%frq_chisq(AGE_36_49)
%frq_chisq(AGE_50_64)
%frq_chisq(AGE_inferior25)
%frq_chisq(AGE_plus65)
%frq_chisq(AVERAGE_buyer)
%frq_chisq(BIG_buyer)
%frq_chisq(SMALL_buyer)
%frq_chisq(Previous_buyer)
%frq_chisq(civilite); 
%frq_chisq(LFY_AGENCE_2); 
%frq_chisq(LFY_COURRIER_2); 
%frq_chisq(LFY_CURES_2); 
%frq_chisq(LFY_ENFANT_2); 
%frq_chisq(LFY_ENF_0_2ANS_2); 
%frq_chisq(LFY_ENF_11_12ANS_2); 
%frq_chisq(LFY_ENF_13_14ANS_2); 
%frq_chisq(LFY_ENF_14_16ANS_2); 
%frq_chisq(LFY_ENF_3_4ANS_2); 
%frq_chisq(LFY_ENF_5_6ANS_2); 
%frq_chisq(LFY_ENF_7_8ANS_2); 
%frq_chisq(LFY_ENF_9_10ANS_2); 
%frq_chisq(LFY_trekking2_2); 
%frq_chisq(LFY_therme_2); 
%frq_chisq(LFY_thalasso_2); 
%frq_chisq(LFY_sport_2); 
%frq_chisq(LFY_senior_HG_2); 
%frq_chisq(LFY_sej_CAP_2); 
%frq_chisq(LFY_sej_CAM_2); 
%frq_chisq(LFY_parc_lois_2); 
%frq_chisq(LFY_grou_enf_2); 
%frq_chisq(LFY_grou_adul_2); 
%frq_chisq(LFY_FAMILY_2); 
%frq_chisq(LFY_FAMILLE_2); 
%frq_chisq(LFY_GROUPE_2); 
%frq_chisq(LFY_HAUTGAMME_2); 
%frq_chisq(LFY_ETE_2); 
%frq_chisq(LFY_HA_2); 
%frq_chisq(LFY_HIVER_2); 
%frq_chisq(LFY_INTERNET_2); 
%frq_chisq(LFY_LASTTRAVEL_2); 
%frq_chisq(LFY_NBACT_HA_2); 
%frq_chisq(LFY_PLAGE_2); 
%frq_chisq(LFY_SENIOR_2); 
%frq_chisq(LFY_TRAVEL_BABY_2); 
%frq_chisq(LFY_trekking_2); 
%frq_chisq(LFY_celib_f_2); 
%frq_chisq(LFY_celibat_2); 
%frq_chisq(LFY_hotel_2); 
%frq_chisq(LFY_nbact_ha_s2); 
%frq_chisq(MT5Y_AGENCE_6); 
%frq_chisq(MT5Y_COURRIER_6); 
%frq_chisq(MT5Y_CURES_6); 
%frq_chisq(MT5Y_ENFANT_6); 
%frq_chisq(MT5Y_ENF_0_2ANS_6); 
%frq_chisq(MT5Y_ENF_11_12ANS_6); 
%frq_chisq(MT5Y_ENF_13_14ANS_6); 
%frq_chisq(MT5Y_ENF_14_16ANS_6); 
%frq_chisq(MT5Y_ENF_3_4ANS_6); 
%frq_chisq(MT5Y_ENF_5_6ANS_6); 
%frq_chisq(MT5Y_ENF_7_8ANS_6); 
%frq_chisq(MT5Y_ENF_9_10ANS_6); 
%frq_chisq(MT5Y_trekking2_6); 
%frq_chisq(MT5Y_therme_6); 
%frq_chisq(MT5Y_thalasso_6); 
%frq_chisq(MT5Y_sport_6); 
%frq_chisq(MT5Y_senior_HG_6); 
%frq_chisq(MT5Y_sej_CAP_6); 
%frq_chisq(MT5Y_sej_CAM_6); 
%frq_chisq(MT5Y_parc_lois_6); 
%frq_chisq(MT5Y_grou_enf_6); 
%frq_chisq(MT5Y_grou_adul_6); 
%frq_chisq(MT5Y_FAMILY_6); 
%frq_chisq(MT5Y_FAMILLE_6); 
%frq_chisq(MT5Y_GROUPE_6); 
%frq_chisq(MT5Y_HAUTGAMME_6); 
%frq_chisq(MT5Y_ETE_6); 
%frq_chisq(MT5Y_HA_6); 
%frq_chisq(MT5Y_HIVER_6); 
%frq_chisq(MT5Y_INTERNET_6); 
%frq_chisq(MT5Y_LASTTRAVEL_6); 
%frq_chisq(MT5Y_NBACT_HA_6); 
%frq_chisq(MT5Y_PLAGE_6); 
%frq_chisq(MT5Y_SENIOR_6); 
%frq_chisq(MT5Y_TRAVEL_BABY_6); 
%frq_chisq(MT5Y_trekking_6); 
%frq_chisq(MT5Y_celib_f_6); 
%frq_chisq(MT5Y_celibat_6); 
%frq_chisq(MT5Y_hotel_6); 

PROC PRINT DATA =chisq_quali;run;

/* visualisation */


/**------------------ Add a graphic for TARGET variable */


/* Graphic on Target variable */
PROC FORMAT;
    * Crée le format binaire 'BIN_FMT';
    VALUE target_cat
        0 = 'Non'
        1 = 'Oui';
RUN;

PROC freq DATA = scoring.data2;
    TABLES target;
    FORMAT target target_cat.;
RUN;


/* modify dataset*/

DATA SCORING.DATA_final2;
SET SCORING.DATA_final;

civilite_num = INPUT(civilite, 8.);

IF civilite_num IN (0,1);
KEEP civilite_num BIG_buyer SMALL_buyer Previous_buyer civilite LFY_ENF_14_16ANS_2 LFY_grou_enf_2 LFY_FAMILY_2
LFY_celib_f_2 LFY_celibat_2 LFY_hotel_2 MT5Y_AGENCE_6 MT5Y_ENF_14_16ANS_6 MT5Y_trekking2_6
MT5Y_therme_6  MT5Y_sej_CAP_6 MT5Y_celib_f_6 MT5Y_celibat_6 TARGET; 

DROP civilite;
RUN;


%MACRO bargraph(var);
PROC FREQ DATA=SCORING.DATA_final2;
    TABLES &var * TARGET / 
        OUT=FreqOut 
        OUTPCT; 
RUN;

PROC SGPLOT DATA=FreqOut;
    TITLE "Target selon &var";

    VBAR &var /
        RESPONSE=PCT_ROW           
        GROUP=TARGET                 
        GROUPDISPLAY=STACK          

       
        DATALABEL=PCT_ROW 
        DATALABELATTRS=(SIZE=9pt WEIGHT=BOLD COLOR=BLACK)
        DATALABELFITPOLICY=NONE;

    YAXIS LABEL="Pourcentage" 
        ; 
        
    XAXIS LABEL="categories";

    KEYLEGEND / TITLE="had subscribed to a previous offer for singles?";
RUN;
%MEND bargraph;

%bargraph(BIG_buyer);
%bargraph(SMALL_buyer);
%bargraph(Previous_buyer);
%bargraph(civilite_num); 
%bargraph(LFY_ENF_14_16ANS_2); 
%bargraph(LFY_grou_enf_2); 
%bargraph(LFY_FAMILY_2); 
%bargraph(LFY_celib_f_2); 
%bargraph(LFY_celibat_2); 
%bargraph(LFY_hotel_2); 
%bargraph(MT5Y_AGENCE_6); 
%bargraph(MT5Y_ENF_14_16ANS_6); 
%bargraph(MT5Y_trekking2_6); 
%bargraph(MT5Y_therme_6); 
%bargraph(MT5Y_sej_CAP_6); 
%bargraph(MT5Y_celib_f_6); 
%bargraph(MT5Y_celibat_6); 

/*-------------------------------  MODELISATION WITH REG LOG ---------------------------*/

/* Séparer la classe minoritaire (TARGET = 1) */
DATA minoritaire;
    SET SCORING.DATA_final2;
    WHERE TARGET = 1;
RUN;

/* Séparer la classe majoritaire (TARGET = 0) */
DATA majoritaire_originale;
    SET SCORING.DATA_final2;
    WHERE TARGET = 0;
RUN;
/* Sous-échantillonnage de 833 observations de la classe majoritaire (TARGET=0) */
PROC SURVEYSELECT DATA=majoritaire_originale 
    OUT=sample_target_0 
    METHOD=SRS /* Simple Random Sampling */
    SAMPSIZE=1667 ;
RUN;

/* Dataset merged */
DATA SCORING.data_train_equal;
    SET minoritaire sample_target_0;
RUN;

/*----------------------------------- Data Split before modeling */

Data SCORING.data_train SCORING.data_test ; 
set SCORING.data_train_equal ;  
If uniform(0)<=0.8 then output SCORING.data_train ;  
Else output SCORING.data_test ; 
Run ;  

PROC LOGISTIC data=SCORING.data_train descending outmodel= SCORING.model_regV1; 
class civilite_num BIG_buyer SMALL_buyer Previous_buyer LFY_ENF_14_16ANS_2 LFY_grou_enf_2 LFY_FAMILY_2
LFY_celib_f_2 LFY_celibat_2 LFY_hotel_2 MT5Y_AGENCE_6 MT5Y_ENF_14_16ANS_6 MT5Y_trekking2_6
MT5Y_therme_6  MT5Y_sej_CAP_6 MT5Y_celib_f_6 MT5Y_celibat_6  /param=ref ; 

model TARGET = civilite_num BIG_buyer SMALL_buyer Previous_buyer LFY_ENF_14_16ANS_2 LFY_grou_enf_2 LFY_FAMILY_2
LFY_celib_f_2 LFY_celibat_2 LFY_hotel_2 MT5Y_AGENCE_6 MT5Y_ENF_14_16ANS_6 MT5Y_trekking2_6
MT5Y_therme_6  MT5Y_sej_CAP_6 MT5Y_celib_f_6 MT5Y_celibat_6  ; 
output out = SCORING.apprentissage_V1 predprobs = (individual);  
run ;

/* stepwise  for best model selection */

proc logistic data=SCORING.data_train outmodel=SCORING.model_stepwise plots=none outest=scoring.coef_model;
    class civilite_num BIG_buyer SMALL_buyer Previous_buyer LFY_ENF_14_16ANS_2 LFY_grou_enf_2 LFY_FAMILY_2
LFY_celib_f_2 LFY_celibat_2 LFY_hotel_2 MT5Y_AGENCE_6 MT5Y_ENF_14_16ANS_6 MT5Y_trekking2_6
MT5Y_therme_6  MT5Y_sej_CAP_6 MT5Y_celib_f_6 MT5Y_celibat_6 / param=ref;
    
    model TARGET = civilite_num BIG_buyer SMALL_buyer Previous_buyer LFY_ENF_14_16ANS_2 LFY_grou_enf_2 LFY_FAMILY_2
LFY_celib_f_2 LFY_celibat_2 LFY_hotel_2 MT5Y_AGENCE_6 MT5Y_ENF_14_16ANS_6 MT5Y_trekking2_6
MT5Y_therme_6  MT5Y_sej_CAP_6 MT5Y_celib_f_6 MT5Y_celibat_6
          / selection=stepwise slentry=0.05 slstay=0.05 details;
run;


/*------------------- 2nd model with only significant variables------------------ */

/**** ROC Curve **/

ods graphics on;
proc logistic inmodel=SCORING.model_stepwise;
    score data=SCORING.data_test out=ROC_data outroc=roc_points fitstat;
run;

proc sgplot data=ROC_points;
    series x=_1mspec_ y=_sensit_;
    xaxis label="1 - Specificity";
    yaxis label="Sensitivity";
    title "ROC CURVE";
run;






/*-------------------------------- coef export ------------------ */

proc export data=scoring.coef_model
    outfile="/home/u62726202/scoring_project/coef_model.csv"
    dbms=csv
    replace;
run;
