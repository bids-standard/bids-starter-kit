% Template Matlab script to create a BIDS compatible:
%
%   sub-01_ses-01_recording-AutosamplerShortExample_blood.tsv
%   sub-01_ses-01_recording-AutosamplerShortExample_blood.json
%
% This example lists all REQUIRED, RECOMMENDED and OPTIONAL fields.

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

clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
recording_label = 'AutosamplerShortExample';

name_spec.modality = 'pet';
name_spec.suffix = 'blood';
name_spec.ext = '.tsv';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'recording', recording_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
tsv_file_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);
json_file_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.json_filename);

%% Write TSV
tsv.time = 0;
tsv.whole_blood_radioactivity = 0;

bids.util.tsvwrite(tsv_file_name, tsv);

%% Write JSON
% this makes the json look prettier when opened in a txt editor
json.PlasmaAvail = false;
json.WholeBloodAvail = true;
json.MetaboliteMethod = false;
json.DispersionCorrected = false;

% get the definition of each column,
% use the bids.Schema class from bids matlab
schema = bids.Schema;

def = schema.get_definition('time');
json.time.Description = def.description;
json.time.Unit = def.unit;

def = schema.get_definition('whole_blood_radioactivity');
json.whole_blood_radioactivity.Description = def.description;
json.whole_blood_radioactivity.Unit = def.unit;

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_file_name));
bids.util.jsonencode(json_file_name, json);
