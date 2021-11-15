% requires:
% - moxunit: https://github.com/MOxUnit/MOxUnit
% - bids-matlab

addpath(fullfile(pwd, '..'));

input_file = fullfile(pwd, '..', 'input', 'spreadsheet_to_convert.xlsx');
files_out = bids_spreadsheet2participants(input_file, 'ignore', 'comment', 'export', pwd);

json_expected = jsonread(fullfile(pwd, 'data', 'participants.json'));
json_actual = jsonread(fullfile(pwd, 'participants.json'));
% uses moxunit assertEqual
assertEqual(json_actual, json_expected);

tsv_expected  = bids.util.tsvread(fullfile(pwd, 'data', 'participants.tsv'));
tsv_actual  = bids.util.tsvread(fullfile(pwd, 'participants.tsv'));
assertEqual(tsv_actual, tsv_expected);
