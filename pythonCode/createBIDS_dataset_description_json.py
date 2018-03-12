import json
from collections import OrderedDict

data= OrderedDict()
data['Name'] = ''
data['BIDSVersion'] = '1.0.2';
data['License'] = ''

data['Authors'] = ['','','']
data['Acknowledgements'] = ''
data['HowToAcknowledge'] = ''
data['Funding'] = ['','','']
data['ReferencesAndLinks'] = ['','','']
data['DatasetDOI'] = ''

root_dir = '' 
project_label = 'templates'


dataset_json_folder = root_dir+project_label
dataset_json_name=dataset_json_folder+'/'+'dataset_description.json'

with open(dataset_json_name, 'w') as ff:
    json.dump(data, ff,sort_keys=False, indent=4)
