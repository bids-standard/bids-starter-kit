%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create JSON using MATLAB for MEG BIDS:
% This template is for MEG data of any kind, including but not limited to task-based,
% resting-state, and noise recordings.
% If multiple Tasks were performed within a single Run, the task description can be set to "task-multitask".
% The _meg.json SHOULD contain details on the Tasks.
% Some manufacturers data storage conventions use folders which contain data files of various nature:
% for example: CTF's .ds format, or 4D/BTi.
% Please refer to Appendix VI for examples from a selection of MEG manufacturers
%
% By Cofficer, Created 14/03/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
task_label = 'ShortExample';
acq_label = 'CTF';
run_label = '1';

% A "proc" (processed) label has been added, especially useful for files coming from Maxfilter
% (for example: sss, tsss, trans, quat, mc, etc.)
proc_label = 'sss';

name_spec.modality = 'meg';
name_spec.suffix = 'meg';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'acq', acq_label, ...
                            'ses', ses_label, ...
                            'task', task_label, ...
                            'run', run_label, ...
                            'proc', proc_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

% Assign the fields in the Matlab structure that can be saved as a json.
% The following fields must be defined:

%%

% Tasks SHOULD NOT have the same name. The Task label is derived
% from this field by removing all non alphanumeric ([a-zA-Z0-9])
% characters:
json.TaskName = '';

%%

% The following MEG specific fields must also be defined:

% Sampling frequency (in Hz) of all the data in the recording,
% regardless of their type (for example: 2400):
json.SamplingFrequency = '';

% Frequency (in Hz) of the power grid at the geographical location of
% the MEG instrument (for instance: 50 or 60):
json.PowerLineFrequency = '';

% Position of the dewar during the MEG scan: "upright", "supine" or
% "degrees" of angle from vertical: for example on CTF systems,
% upright=15, supine = 90:
json.DewarPosition = '';

% List of temporal and/or spatial software filters applied, or ideally
% key:value pairs of pre-applied software filters and their parameter
% values: for example: {"SSS": {"frame": "head", "badlimit": 7}},
% {"SpatialCompensation": {"GradientOrder": Order of the gradient
% compensation}}. Write "n/a" if no software filters applied.
json.SoftwareFilters = '';

% Boolean ("true" or "false") value indicating whether anatomical
% landmark points (for instance: fiducials) are contained within this recording.
json.DigitizedLandmarks = '';

% Boolean ("true" or "false") value indicating whether head points
% outlining the scalp/face surface are contained within this recording
json.DigitizedHeadPoints = '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
