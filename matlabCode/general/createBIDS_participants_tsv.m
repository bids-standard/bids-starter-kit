%% Template Matlab script to create an BIDS compatible participants.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017

% Writing json files relies on the JSONio library
% https://github.com/bids-standard/bids-matlab
%
% Make sure it is in the matab/octave path
try
    bids.bids_matlab_version;
catch
    warning('%s\n%s\n%s\n%s', ...
            'Writing the JSON file seems to have failed.', ...
            'Make sure that the following library is in the matlab/octave path:', ...
            'https://github.com/bids-standard/bids-matlab');
end

%%
clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project_label = 'templates';

participants_tsv_name = fullfile(root_dir, project_label, 'participants.tsv');

%% make a participants table and save

tsv.participant_id = {'sub-01'; 'sub-epilepsy01'};
tsv.age = [0; 10];
tsv.sex = {'m'; 'f'};
tsv.handedness = {'l'; 'r'};

bids.util.tsvwrite(participants_tsv_name, tsv);

%% associated data dictionary

template = struct( ...
                  'LongName', '', ...
                  'Description', '', ...
                  'Levels', struct(), ...
                  'Units', '', ...
                  'TermURL', 'http://www.todo.com/fixme');

json.age = template;
json.age.Description = 'age of the participant';
json.age.Units = 'years';

json.sex = template;
json.sex.Description = 'sex of the participant as reported by the participant';
json.sex.Levels = struct( ...
                         'm', 'male', ...
                         'f', 'female');

json.handedness = template;
json.handedness.Description = 'handedness of the participant as reported by the participant';
json.handedness.Levels = struct( ...
                                'l', 'left', ...
                                'r', 'right');

json_name = fullfile(root_dir, project_label, 'participants.json');

% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
