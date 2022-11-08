# import OS module
import os
import pandas as pd 
import numpy as np

# Get the list of all files and directories
path = "C://Users//Jenni//Documents//GitHub//MWASHypertension//samples"
dir_list = os.listdir(path)
case = []

for folder in dir_list:
	case.append(folder.split("_")[0])

data = {'Samples': dir_list, 'Case': case}  
df = pd.DataFrame(data)  

print(df)

df.to_csv('file_name.csv', encoding='utf-8')