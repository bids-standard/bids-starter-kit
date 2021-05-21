%% Template Matlab script to create an BIDS compatible sub-01_ses-01_task-FullExample-01_events.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% anushkab, 2018

%%
clear;
root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_id = '01';
ses_id = '01';
task_id = 'FullExample';

acquisition = 'func';
run_id = '01';

events_tsv_name = fullfile(root_dir, project_label, ...
                           ['sub-' sub_id], ...
                           ['ses-' ses_id], acquisition, ...
                           ['sub-' sub_id ...
                            '_ses-' ses_id ...
                            '_task-' task_id ...
                            '_run-' run_id '_events.tsv']);

%% make an event table and save

%% CONTAINS a set of REQUIRED and OPTIONAL columns
% REQUIRED Onset (in seconds) of the event measured from the beginning of
% the acquisition of the first volume in the corresponding task imaging data file.
% If any acquired scans have been discarded before forming the imaging data file,
% ensure that a time of 0 corresponds to the first image stored. In other words
% negative numbers in onset are allowed.
onset = [0]';

% REQUIRED. Duration of the event (measured from onset) in seconds.
% Must always be either zero or positive. A "duration" value of zero implies
% that the delta function or event is so short as to be effectively modeled as an impulse.
duration = [0]';

% OPTIONAL Primary categorisation of each trial to identify them as instances
% of the experimental conditions
trial_type = {'afraid'};

% OPTIONAL. Response time measured in seconds. A negative response time can be
% used to represent preemptive responses and n/a denotes a missed response.
response_time = [0]';

% OPTIONAL Represents the location of the stimulus file (image, video, sound etc.)
% presented at the given onset time
stim_file = {' '};

% OPTIONAL Hierarchical Event Descriptor (HED) Tag.
HED = {' '};

%% Save table
t = table(onset, duration, trial_type, response_time, stim_file, HED);

writetable(t, events_tsv_name, 'FileType', 'text', 'Delimiter', '\t');

%% associated data dictionary

template = struct( ...
                  'LongName', '', ...
                  'Description', '', ...
                  'Levels', [], ...
                  'Units', '', ...
                  'TermURL', '');

dd_json.trial_type = template;
dd_json.trial_type.Description = 'Emotion image type';
dd_json.trial_type.Levels = struct( ...
                                   'afraid', 'A face showing fear is displayed', ...
                                   'angry', 'A face showing anger is displayed');

dd_json.identifier.LongName = 'Unique identifier from Karolinska (KDEF) database';
dd_json.identifier.Description = 'ID from KDEF database used to identify the displayed image';

dd_json.StimulusPresentation.OperatingSystem = 'Linux Ubuntu 18.04.5';
dd_json.StimulusPresentation.SoftwareName = 'Psychtoolbox';
dd_json.StimulusPresentation.SoftwareRRID = 'SCR_002881';
dd_json.StimulusPresentation.SoftwareVersion = '3.0.14';
dd_json.StimulusPresentation.Code = 'doi:10.5281/zenodo.3361717';

%% Write JSON

json_options.indent = ' '; % this just makes the json file look prettier
% when opened in a text editor

jsonSaveDir = fileparts(events_tsv_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist: %s \n', jsonSaveDir);
end

try
    jsonwrite(strrep(events_tsv_name, '.tsv', '.json'), dd_json, json_options);
catch
    warning('%s\n%s\n%s\n%s', ...
            'Writing the JSON file seems to have failed.', ...
            'Make sure that the following library is in the matlab/octave path:', ...
            'https://github.com/gllmflndn/JSONio');
end
