%% Template Matlab script to create an BIDS compatible _fmap.json file
% There are different cases, see BIDS spec 1.0.2 paragraph 8.9
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% Writing json files relies on the JSONio library
% https://github.com/gllmflndn/JSONio
% Make sure it is in the matab/octave path
%
% DHermes, 2017
% modified RG 201809

%% 8.9.1 Case 1: Phase difference image and at least one magnitude image
clear;

root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_label = '01';
ses_label = '01';
task_label = 'Case1';
run_label = '01';

clear fmap_json;

fmap_json_name = fullfile(root_dir, project_label, ['sub-' sub_label], ...
                          ['ses-' ses_label], ...
                          'fmap', ...
                          ['sub-' sub_label ...
                           '_ses-' ses_label ...
                           '_task-' task_label ...
                           '_run-' run_label '_phasediff.json']);

fmap_json.EchoTime1 = '';
fmap_json.EchoTime2 = '';
% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap_json.IntendedFor = '';

json_options.indent = '    '; % this just makes the json file look prettier
% when opened in a text editor
jsonSaveDir = fileparts(fmap_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n', jsonSaveDir);
end
jsonwrite(fmap_json_name, fmap_json, json_options);

%% 8.9.2 Case 2: Two phase images and two magnitude images
clear;

root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_label = '01';
ses_label = '01';
task_label = 'Case2';
run_label = '01';

fmap1_json_name = fullfile(root_dir, project_label, ['sub-' sub_label], ...
                           ['ses-' ses_label], ...
                           'fmap', ...
                           ['sub-' sub_label ...
                            '_ses-' ses_label ...
                            '_task-' task_label ...
                            '_run-' run_label '_phase1.json']);
fmap2_json_name = fullfile(root_dir, project_label, ['sub-' sub_label], ...
                           ['ses-' ses_label], ...
                           'fmap', ...
                           ['sub-' sub_label ...
                            '_ses-' ses_label ...
                            '_task-' task_label ...
                            '_run-' run_label '_phase2.json']);

fmap1_json.EchoTime = '';
% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap1_json.IntendedFor = '';

fmap2_json.EchoTime = '';
% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap2_json.IntendedFor = '';

json_options.indent = '    '; % this just makes the json file look prettier
% when opened in a text editor
jsonSaveDir = fileparts(fmap1_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n', jsonSaveDir);
end

jsonwrite(fmap1_json_name, fmap1_json, json_options);
jsonwrite(fmap2_json_name, fmap2_json, json_options);

%% 8.9.3 Case 3: A single, real fieldmap image (showing the field inhomogeneity in each voxel)

clear;
root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_label = '01';
ses_label = '01';
task_label = 'Case3';
run_label = '01';

fmap_json_name = fullfile(root_dir, project_label, ['sub-' sub_label], ...
                          ['ses-' ses_label], ...
                          'fmap', ...
                          ['sub-' sub_label ...
                           '_ses-' ses_label ...
                           '_task-' task_label ...
                           '_run-' run_label '_fieldmap.json']);

fmap_json.Units = ''; % The possible options are: Hz, rad/s, or Tesla.
% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap_json.IntendedFor = '';

json_options.indent = '    '; % this just makes the json file look prettier
% when opened in a text editor
jsonSaveDir = fileparts(fmap_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n', jsonSaveDir);
end
jsonwrite(fmap_json_name, fmap_json, json_options);

%% 8.9.4 Case 4: Multiple phase encoded directions (topup)

clear;
root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_label = '01';
ses_label = '01';
task_label = 'Case4';
run_label = '01';

% dir_label value can be set to arbitrary alphanumeric
% label ([a-zA-Z0-9]+ for example "LR" or "AP") that can help users to
% distinguish between different files, but should not be used to infer any
% scanning parameters (such as phase encoding directions) of the corresponding sequence.
dir_label = 'LR';

fmap_json_name = fullfile(root_dir, project_label, ['sub-' sub_label], ...
                          ['ses-' ses_label], ...
                          'fmap', ...
                          ['sub-' sub_label ...
                           '_ses-' ses_label ...
                           '_task-' task_label ...
                           '_dir-' dir_label ...
                           '_run-' run_label '_epi.json']);

% This technique combines two or more
% Spin Echo EPI scans with different phase encoding directions. In such a case,
% the phase encoding direction is specified in the corresponding JSON file as
% one of: i, j, k, i-, j-, k-
fmap_json.PhaseEncodingDirection = '';

% For these differentially phase encoded
% sequences, one also needs to specify the Total Readout Time defined as
% the time (in seconds) from the center of the first echo to the center
% of the last echo
fmap_json.TotalReadoutTime = '';

% Fieldmap data are linked to a specific scan(s)
% it was acquired for by filling the IntendedFor field. The IntendedFor field
% may contain one or more filenames with paths relative to the subject subfolder.
% The pathneeds to use forward slashes instead of backward slashes.
fmap_json.IntendedFor = '';

% this just makes the json file look prettier
% when opened in a text editor
json_options.indent = '    ';

jsonSaveDir = fileparts(fmap_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n', jsonSaveDir);
end

try
    jsonwrite(fmap_json_name, fmap_json, json_options);
catch
    warning('%s\n%s\n%s\n%s', ...
            'Writing the JSON file seems to have failed.', ...
            'Make sure that the following library is in the matlab/octave path:', ...
            'https://github.com/gllmflndn/JSONio');
end
