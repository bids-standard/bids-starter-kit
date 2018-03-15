%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create JSON using MATLAB for MEG BIDS:
% This template is for MEG data of any kind, including but not limited to task-based, resting-state, and noise
% recordings. If multiple Tasks were performed within a single Run, the task description can be set to
% “task-multitask”. The _meg.json SHOULD contain details on the Tasks. Some manufacturers data storage
% conventions use folders which contain data files of various nature: e.g., CTF’s .ds format, or 4D/BTi.
% Please refer to Appendix VI for examples from a selection of MEG manufacturers
%
% By @Cofficer, Created 14/03/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


root_dir        = './';
project_label   = 'templates';
sub_id          = '01';
ses_id          = '01';
task_id         = 'ShortExample'
acq_id          = 'CTF'
run_id          = '1';

% A “proc” (processed) label has been added, especially useful for files coming from Maxfilter (e.g. sss,
% tsss, trans, quat, mc, etc.)
proc_id         = 'sss';

acquisition     = 'meg';

meg_json_name = fullfile(root_dir,project_label,...
              ['sub-' sub_id],...
              ['ses-' ses_id],acquisition,...
              ['sub-' sub_id ...
              '_task-' task_id ...
              '_acq-' acq_id ...
              '_run-' run_id ...
              '_proc-' proc_id '_meg.json']);

% Assign the fields in the Matlab structure that can be saved as a json.
%The following fields must be defined:

%%

% Tasks SHOULD NOT have the same name. The Task label is derived
% from this field by removing all non alphanumeric ([a-zA-Z0-9])
% characters:
meg_json.TaskName                        ='';

%%

% The following MEG specific fields must also be defined:

% Sampling frequency (in Hz) of all the data in the recording,
% regardless of their type (e.g., 2400):
meg_json.SamplingFrequency               ='';

% Frequency (in Hz) of the power grid at the geographical location of
% the MEG instrument (i.e. 50 or 60):
meg_json.PowerLineFrequency              ='';

% Position of the dewar during the MEG scan: "upright", "supine" or
% "degrees" of angle from vertical: for example on CTF systems,
% upright=15°, supine = 90°:
meg_json.DewarPosition                   ='';

% List of temporal and/or spatial software filters applied, or ideally
% key:value pairs of pre-applied software filters and their parameter
% values: e.g., {"SSS": {"frame": "head", "badlimit": 7}},
% {"SpatialCompensation": {"GradientOrder": Order of the gradient
% compensation}}. Write “n/a” if no software filters applied.
meg_json.SoftwareFilters                 ='';

% Boolean (“true” or “false”) value indicating whether anatomical
% landmark points (i.e. fiducials) are contained within this recording.
meg_json.DigitizedLandmarks              ='';

% Boolean (“true” or “false”) value indicating whether head points
% outlining the scalp/face surface are contained within this recording
meg_json.DigitizedHeadPoints             ='';


json_options.indent               = '    '; % this makes the json look pretier when opened in a txt editor

jsonSaveDir = fileparts(meg_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end


jsonwrite(meg_json_name,meg_json,json_options)
