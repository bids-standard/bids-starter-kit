# Code to generate "modality agnostic" BIDS files

## bids_spreadsheet2participants

This function requires Matlab 2018a or above to run.

Run the following in Matlab:

```matlab
cd matlabCode/general
input_file = fullfile(pwd, 'input', 'input_to_create_participants_file.xlsx')
files_out = bids_spreadsheet2participants(input_file, 'ignore', 'comment')
```
