%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create JSON using MATLAB for MEG BIDS:
%
% This template is for MEG data of any kind, including but not limited to task-based,
% resting-state, and noise recordings.
%
% If multiple Tasks were performed within a single Run,
% the task description can be set to "task-multitask".
%
% The _meg.json SHOULD contain details on the Tasks.
%
% Some manufacturers data storage conventions use folders
% which contain data files of various nature:
% for example: CTF's .ds format, or 4D/BTi.
%
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

%% Adding metadata
% Assign the fields in the Matlab structure that can be saved as a json.
% The following fields must be defined:

% to get the definition of each metadata,
% you can use the bids.Schema class from bids matlab
% For example
schema = bids.Schema;
def = schema.get_definition('TaskName');
fprintf(def.description);

%%
json.TaskName = task_label;

%%
json.SamplingFrequency = [];
json.PowerLineFrequency = [];
json.DewarPosition = '';
json.SoftwareFilters = '';
json.DigitizedLandmarks = '';
json.DigitizedHeadPoints = '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
