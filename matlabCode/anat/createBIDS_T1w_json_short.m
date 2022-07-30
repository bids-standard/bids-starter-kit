% Template Matlab script to create a BIDS compatible file:
%
%  sub-01_ses-01_acq-ShortExample_run-01_T1w.json
%
% This example lists only the REQUIRED fields.
% When adding additional metadata please use CamelCase

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

project = 'templates';

sub_label = '01';
ses_label = '01';
run_label = '01';

% The OPTIONAL acq-<label> key/value pair corresponds to a custom label
% the user MAY use to distinguish a different set of parameters used for
% acquiring the same modality.
acq_label = 'ShortExample';

name_spec.modality = 'anat';
name_spec.suffix = 'T1w';
name_spec.ext = '.json';

name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'acq', acq_label, ...
                            'run', run_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));

%%
% Assign the fields in the Matlab structure that can be saved as a json.
% all REQUIRED /RECOMMENDED /OPTIONAL metadata fields for Magnetic Resonance Imaging data

%% Adding metadata
% to get the definition of each metadata,
% you can use the bids.Schema class from bids matlab

% For example
schema = bids.Schema;
def = schema.get_definition('TaskName');
fprintf(def.description);

%% In-Plane Spatial Encoding metadata fields
json.PhaseEncodingDirection = ' ';
json.EffectiveEchoSpacing = ' ';
json.TotalReadoutTime = ' ';

%% Timing Parameters metadata fields
json.EchoTime = ' ';

%% Write JSON
bids.util.jsonencode(json_name, json);
