%% Template Matlab script to create an BIDS compatible _fmap.json file
% There are different cases, see BIDS spec 1.0.2 paragraph 8.9
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

%% Case 1: Phase difference image and at least one magnitude image
clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
acq_label = 'Case1';
run_label = '01';

name_spec.modality = 'fmap';
name_spec.suffix = 'phasediff';
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

json.EchoTime1 = '';
json.EchoTime2 = '';
% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
json.IntendedFor = {'sub-01/ses-01/func/...'
                    'sub-01/ses-01/func/...'};

% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);

%% Case 2: Two phase images and two magnitude images
clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
acq_label = 'Case2';
run_label = '01';

name_spec.modality = 'fmap';
name_spec.suffix = 'phase1';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'acq', acq_label, ...
                            'run', run_label);
% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
fmap1_json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

name_spec.suffix = 'phase2';
bids_file = bids.File(name_spec, 'use_schema', true);
fmap2_json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

fmap1_json.EchoTime = '';
% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap1_json.IntendedFor = {'sub-01/ses-01/func/...'
                          'sub-01/ses-01/func/...'};

fmap2_json.EchoTime = '';

% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap2_json.IntendedFor = {'sub-01/ses-01/func/...'
                          'sub-01/ses-01/func/...'};

% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(fmap1_json_name));
bids.util.jsonencode(fmap1_json_name, fmap1_json);
bids.util.jsonencode(fmap2_json_name, fmap2_json);

%% Case 3: A single, real fieldmap image (showing the field inhomogeneity in each voxel)

clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
acq_label = 'Case3';
run_label = '01';

name_spec.modality = 'fmap';
name_spec.suffix = 'fieldmap';
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

% The possible options are: Hz, rad/s, or Tesla.
json.Units = '';

% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
json.IntendedFor = {'sub-01/ses-01/func/...'
                    'sub-01/ses-01/func/...'};

% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);

%% Case 4: Multiple phase encoded directions (topup)

clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
acq_label = 'Case4';
run_label = '01';

% dir_label value can be set to arbitrary alphanumeric
% label ([a-zA-Z0-9]+ for example "LR" or "AP") that can help users to
% distinguish between different files, but should not be used to infer any
% scanning parameters (such as phase encoding directions) of the corresponding sequence.
dir_label = 'LR';

name_spec.modality = 'fmap';
name_spec.suffix = 'epi';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'acq', acq_label, ...
                            'run', run_label, ...
                            'dir', dir_label);
% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

% This technique combines two or more
% Spin Echo EPI scans with different phase encoding directions. In such a case,
% the phase encoding direction is specified in the corresponding JSON file as
% one of: i, j, k, i-, j-, k-
json.PhaseEncodingDirection = '';

% For these differentially phase encoded
% sequences, one also needs to specify the Total Readout Time defined as
% the time (in seconds) from the center of the first echo to the center
% of the last echo
json.TotalReadoutTime = '';

% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The path needs to use forward slashes instead of backward slashes.
json.IntendedFor = {'sub-01/ses-01/func/...'
                    'sub-01/ses-01/func/...'};

% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
