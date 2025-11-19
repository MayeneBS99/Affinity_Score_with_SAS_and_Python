
import pandas as pd
import numpy as np
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
file_path2 = os.path.join(current_dir, '..', 'model', 'coef_model2.csv')


class preprocessing_class :

    def __init__(self, raw_df):
        self.raw_df = raw_df
    
    def transform_variables(self):
        for var in self.raw_df:
             self.raw_df[var] = self.raw_df[var].replace({"yes" : 1,
                                                          "no" : 0})
             self.raw_df[var] = self.raw_df[var].replace({"female" : 1,
                                                          "male" : 0})
        return self.raw_df

    def compute_score(self) :
        """
        Help us to compute the score for each customer
        """
        df_score = pd.read_csv(file_path2)
        data = self.transform_variables()

        df_score = df_score.loc[:, ~df_score.columns.str.contains("^Unnamed")]

        coefficients = df_score.drop(columns=["Intercept"], axis = 1)
        intercept_value = df_score["Intercept"].iloc[0]

        multiplied_terms = (data.values * coefficients.values)
        score = multiplied_terms.sum(axis=1)[0] + intercept_value

        return score
        
        
