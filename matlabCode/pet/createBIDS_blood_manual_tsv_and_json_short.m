% Template Matlab script to create a BIDS compatible:
%
%   sub-01_ses-01_recording-ManualFullExample_blood.tsv
%   sub-01_ses-01_recording-ManualFullExample_blood.json
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
recording_label = 'ManualShortExample';

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
tsv.metabolite_parent_fraction = 0;

bids.util.tsvwrite(tsv_file_name, tsv);

%% Write JSON

% get the definition of each column,
% use the bids.Schema class from bids matlab
% example:
%
% schema = bids.Schema;
% def = schema.get_definition('metabolite_parent_fraction');

json.PlasmaAvail = '';
json.MetaboliteAvail = '';
json.WholeBloodAvail = '';
json.DispersionCorrected = '';
json.MetaboliteMethod = '';
json.MetaboliteRecoveryCorrectionApplied = '';
json.time = struct('Description', ...
                   'Time in relation to time zero defined by the _pet.json', ...
                   'Units', 's');
json.metabolite_parent_fraction = struct('Description', ...
                                         'Parent fraction of the radiotracer.', ...
                                         'Units', 'unitless');

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_file_name));
bids.util.jsonencode(json_file_name, json);
