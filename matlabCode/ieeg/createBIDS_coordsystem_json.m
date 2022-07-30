%% Template Matlab script to create an BIDS compatible _electrodes.json file
% For BIDS-iEEG
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified Jaap van der Aar 30.11.18

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

name_spec.modality = 'ieeg';
name_spec.suffix = 'coordsystem';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%% Adding metadata
% Assign the fields in the Matlab structure that can be saved as a json.
% The following fields must be defined:

% to get the definition of each metadata,
% you can use the bids.Schema class from bids matlab
% For example
schema = bids.Schema;
def = schema.get_definition('iEEGCoordinateSystem');
fprintf(def.description);

%% Required fields
json.iEEGCoordinateSystem = '';
json.iEEGCoordinateUnits = '';

%% Recommended fields
json.iEEGCoordinateProcessingDescripton = '';
json.IndendedFor = '';
json.iEEGCoordinateProcessingDescription = '';
json.iEEGCoordinateProcessingReference = '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
