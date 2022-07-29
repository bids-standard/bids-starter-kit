%% Template Matlab script to create an BIDS compatible sub-01_ses-01_task-FullExample-01_events.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% anushkab, 2018

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
task_label = 'FullExample';
run_label = '01';

name_spec.modality = 'func';
name_spec.suffix = 'events';
name_spec.ext = '.tsv';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'task', task_label, ...
                            'run', run_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
events_tsv_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);
events_json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.json_filename);

%% make an event table and save

%% CONTAINS a set of REQUIRED and OPTIONAL columns
% REQUIRED Onset (in seconds) of the event measured from the beginning of
% the acquisition of the first volume in the corresponding task imaging data file.
% If any acquired scans have been discarded before forming the imaging data file,
% ensure that a time of 0 corresponds to the first image stored. In other words
% negative numbers in onset are allowed.
tsv.onset = 0;

% REQUIRED. Duration of the event (measured from onset) in seconds.
% Must always be either zero or positive. A "duration" value of zero implies
% that the delta function or event is so short as to be effectively modeled as an impulse.
tsv.duration = 0;

% OPTIONAL Primary categorisation of each trial to identify them as instances
% of the experimental conditions
tsv.trial_type = {'afraid'};

% OPTIONAL. Response time measured in seconds. A negative response time can be
% used to represent preemptive responses and n/a denotes a missed response.
tsv.response_time = 0;

% OPTIONAL Represents the location of the stimulus file (image, video, sound etc.)
% presented at the given onset time
tsv.stim_file = {' '};

% OPTIONAL Hierarchical Event Descriptor (HED) Tag.
tsv.HED = {' '};

%% Save table
bids.util.tsvwrite(events_tsv_name, tsv);

%% associated data dictionary

template = struct('LongName', '', ...
                  'Description', '', ...
                  'Levels', [], ...
                  'Units', '', ...
                  'TermURL', '');

json.trial_type = template;
json.trial_type.Description = 'Emotion image type';
json.trial_type.Levels = struct('afraid', 'A face showing fear is displayed', ...
                                'angry', 'A face showing anger is displayed');

json.identifier.LongName = 'Unique identifier from Karolinska (KDEF) database';
json.identifier.Description = 'ID from KDEF database used to identify the displayed image';

json.StimulusPresentation.OperatingSystem = 'Linux Ubuntu 18.04.5';
json.StimulusPresentation.SoftwareName = 'Psychtoolbox';
json.StimulusPresentation.SoftwareRRID = 'SCR_002881';
json.StimulusPresentation.SoftwareVersion = '3.0.14';
json.StimulusPresentation.Code = 'doi:10.5281/zenodo.3361717';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(events_json_name));
bids.util.jsonencode(events_json_name, json);
