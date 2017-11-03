%% Template Matlab script to create an BIDS compatible _bold.json file
% This example only lists the required fields.
%
% DHermes, 2017

%%

root_dir = '.';
project_label = 'templates';
sub_label = '01';
ses_label = '01';
task_label = 'ShortExample';
run_label = '01';

% you can also have acq- and proc- fields, but these are optional

bold_json_name = fullfile(root_dir,project_label,[ 'sub-' sub_label ],...
    ['ses-' ses_label],...
    'fmri',...
    ['sub-' sub_label ...
    '_ses-' ses_label ...
    '_task-' task_label ...
    '_run-' run_label '_bold.json']);

%%

% General fields, shared with MRI BIDS and MEG BIDS:
% Required fields:
bold_json.TaskName = ''; % Name of the task (for resting state use the ?rest? prefix). No two tasks should have the same name. Task label is derived from this field by removing all non alphanumeric ([a-zA-Z0-9]) characters. 
bold_json.RepetitionTime = []; % The time in seconds between the beginning of an acquisition of one volume and the beginning of acquisition of the volume following it (TR). Please note that this definition includes time between scans (when no data has been acquired) in case of sparse acquisition schemes. This value needs to be consistent with the ?pixdim[4]? field (after accounting for units stored in ?xyzt_units? field) in the NIfTI header 

json_options.indent = '    '; % this just makes the json file look prettier when opened in a text editor

jsonSaveDir = fileparts(bold_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

jsonwrite(bold_json_name,bold_json,json_options)



