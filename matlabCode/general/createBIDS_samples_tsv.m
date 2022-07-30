%% Template Matlab script to create an BIDS compatible samples.tsv file

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

samples_tsv_name = fullfile(root_dir, project_label, 'samples.tsv');

%% make a participants table and save

tsv.sample_id = {'sample-01'; 'sample-02'};
tsv.participant_id = {'sub-01'; 'sub-epilepsy01'};
tsv.sample_type = {'tissue'; 'tissue'};

bids.util.tsvwrite(samples_tsv_name, tsv);

%% associated data dictionary

% use the BIDS schema to get the official definitions
schema = bids.Schema;

columns = fieldnames(tsv);

for i = 1:numel(columns)
    def = schema.get_definition(columns{i});
    json.(columns{i}).LongName = def.display_name;
    json.(columns{i}).Description = def.description;
end

json_name = fullfile(root_dir, project_label, 'samples.json');

% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
