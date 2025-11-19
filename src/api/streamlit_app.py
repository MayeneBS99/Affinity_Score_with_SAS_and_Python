
import sys
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, '..', '..')) 

if project_root not in sys.path:
    sys.path.append(project_root)


import streamlit as st
import pandas as pd
import numpy as np
from src.preprocessing.preprocessing import preprocessing_class


st.title("SCORE FOR CUSTOMERS :bulb:")
st.header("This application helps us to find the score for each of our customer regarding the futures offers for singles we want to propose")

civilite_num0 = st.selectbox("Select customer gender", ["male", "female"])
LFY_celibat_20 = st.selectbox("Did you select a stay for single in the last four years?", ["yes", "no"])
LFY_grou_enf_20 = st.selectbox("Did you select a stay for cheldren in the last four years?", ["yes", "no"])
LFY_celib_f_20= st.selectbox("Did you select a stay for female single in the last four years?", ["yes", "no"])
MT5Y_celibat_60 = st.selectbox("Did you select a stay for single in the last eight years?", ["yes", "no"])

MT5Y_ENF_14_16ANS_60 = st.selectbox("Did you select a stay for children between 14 and 16 years old in the last eight years?", ["yes", "no"])
MT5Y_celib_f_60 = st.selectbox("Did you select a stay for women single in the last eight years?", ["yes", "no"])
LFY_ENF_14_16ANS_20 = st.selectbox("Did you select a stay for children between 14 and 16 years old in the last?", ["yes", "no"])
LFY_hotel_20 = st.selectbox("Did the customer select a stay at hotel during the last four years?", ["yes", "no"])


def compute_and_store_score(df) :
    """
    Instanciate object class and compute score
    """
    processor = preprocessing_class(df)
    final_score = processor.compute_score()
    st.session_state['customer_score'] = final_score
    

row = np.array([civilite_num0, LFY_celibat_20, LFY_grou_enf_20, LFY_celib_f_20, MT5Y_celibat_60 , MT5Y_ENF_14_16ANS_60, 
                MT5Y_celib_f_60, LFY_ENF_14_16ANS_20, LFY_hotel_20])

df_row = pd.DataFrame(row.reshape(1, -1), 
                      columns = ["civilite_num0", "LFY_celibat_20", "LFY_grou_enf_20", "LFY_celib_f_20", "MT5Y_celibat_60" , "MT5Y_ENF_14_16ANS_60", 
                            "MT5Y_celib_f_60", "LFY_ENF_14_16ANS_20", "LFY_hotel_20"] )


if st.button("Compute customer score"):
    compute_and_store_score(df_row)

if 'customer_score' in st.session_state:
    score = st.session_state['customer_score']
    st.subheader("Scoring results")
    st.success(f"The customer score is : **{score:.2f}**")