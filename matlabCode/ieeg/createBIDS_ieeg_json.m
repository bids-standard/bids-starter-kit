%% Template Matlab script to create an BIDS compatible _ieeg.json file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified Jaap van der Aar & Giulio Castegnaro 30.11.18

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
task_label = 'LongExample';
run_label = '01';

name_spec.modality = 'ieeg';
name_spec.suffix = 'ieeg';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'task', task_label, ...
                            'run', run_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%% General fields, shared with MRI BIDS and MEG BIDS:

%% Required fields:
json.TaskName = ''; % Name of the task (for resting state use the rest
% prefix). No two tasks should have the same name. Task label is derived
% from this field by removing all non alphanumeric ([a-zA-Z0-9]) characters.
% Note this does not have to be a "behavioral task" that subjects perform, but can reflect some
% information about the conditions present when the data was acquired (for example: "rest" or "sleep").

json.SamplingFrequency = ''; % Sampling frequency (in Hz) of all the iEEG channels
% in the recording (for example: 2400). All other channels should have frequency specified
% as well in the channels.tsv file.

json.PowerLineFrequency = ''; % Frequency (in Hz) of the power grid where the
% iEEG recording was done (for instance: 50 or 60).

json.SoftwareFilters = ''; % List of temporal software filters applied or
% ideally key:value pairs of pre-applied filters and their parameter values.
% (n/a if none). for example: "{'HighPass': {'HalfAmplitudeCutOffHz': 1, 'RollOff: '6dB/Octave'}}".

%% Recommended fields:

HardwareFilters.HighpassFilter.CutoffFrequency = []; % Contains the high pass hardware filter
% cut off frequency.

HardwareFilters.LowpassFilter.CutoffFrequency = []; % Contains the low pass hardware filter
% cut off frequency.

json.HardwareFilters = HardwareFilters; % Cutoff frequencies of high and low pass filter
% are stored in this variable automatically. No further input necessary.

json.Manufacturer = ''; % Manufacturer of the amplifier system (for example: "TDT, blackrock")

json.ManufacturersModelName = ''; % Manufacturer's designation of the
% iEEG amplifier model (for example: "TDT").

json.TaskDescription = ''; % Longer description of the task.

json.Instructions = ''; % Text of the instructions given to participants
% before the recording. This is especially important in context of resting
% state and distinguishing between eyes open and eyes closed paradigms.

json.CogAtlasID = ''; % URL of the corresponding Cognitive Atlas Task term

json.CogPOID = ''; % URL of the corresponding CogPO term

json.InstitutionName = ''; % The name of the institution in charge of
% the equipment that produced the composite instances.

json.InstitutionAddress = ''; % The address of the institution in charge
% of the equipment that produced the composite instances.

json.DeviceSerialNumber = ''; % The serial number of the equipment that
% produced the composite instances. A pseudonym can also be used to prevent
% the equipment from being identifiable, as long as each pseudonym is unique
% within the dataset.

json.ECOGChannelCount = ''; % Number of iEEG surface channels included in the recording (for example: 120)

json.SEEGChannelCount = ''; % Number of iEEG depth channels included in the recording (for example: 8)

json.EEGChannelCount = ''; % Number of scalp EEG channels recorded simultaneously (for example: 21)

json.EOGChannelCount = ''; % Number of EOG channels

json.ECGChannelCount = ''; % Number of ECG channels

json.EMGChannelCount = ''; % Number of EMG channels

json.MiscChannelCount = ''; % Number of miscellaneous analog channels for auxiliary signals

json.TriggerChannelCount = ''; % Number of channels for digital (TTL bit level) triggers.

json.RecordingDuration = ''; % Length of the recording in seconds (for example: 3600)

json.RecordingType = ''; % Defines whether the recording is "continuous" or "epoched"; this latter
% limited to time windows about events of interest (for example: stimulus presentations, subject responses etc.)

json.EpochLength = ''; % Duration of individual epochs in seconds (for example: 1).
% If recording was continuous, leave out the field.

json.SubjectArtefactDescription = ''; % Freeform description of the observed
% subject artefact and its possible cause (for example: door open, nurse walked into room at 2 min,
% "Vagus Nerve Stimulator", non-removable implant, seizure at 10 min).
% If this field is left empty, it will be interpreted as absence of artifacts.

json.SoftwareVersions = ''; % Manufacturer's designation of the acquisition software.

%% Specific iEEG fields:

% If mixed types of references, manufacturers or electrodes are used, please
% specify in the corresponding table in the _electrodes.tsv file

%% Required fields:

json.iEEGReference = ''; % General description of the reference scheme used and
% (when applicable) of location of the reference electrode in the raw recordings
% (for example: "left mastoid", "bipolar", "T01" for electrode with name T01, "intracranial electrode
% on top of a grid, not included with data", "upside down electrode"). If different channels have
% a different reference, this field should have a general description and the channel specific
% reference should be defined in the _channels.tsv file.

%% Recommended fields:

json.ElectrodeManufacturer = ''; % can be used if all electrodes are of the same manufacturer
% (for example: AD-TECH, DIXI). If electrodes of different manufacturers are used, please use the corresponding
% table in the _electrodes.tsv file.

json.ElectrodeManufacturersModelName = ''; % Specify model name. If different electrode types are used,
% please use the corresponding table in the _electrodes.tsv file

json.iEEGGround = ''; % Description of the location of the ground electrode
% ("placed on right mastoid (M2)").

json.iEEGPlacementScheme = ''; % Freeform description of the placement of the iEEG electrodes.
% Left/right/bilateral/depth/surface(for example: "left frontal grid and bilateral hippocampal depth" or
% "surface strip and STN depth" or "clinical indication bitemporal, bilateral temporal strips and left grid").

json.iEEGElectrodeGroups = ''; % Field to describe the way electrodes are grouped
% into strips, grids or depth probes for example: {'grid1': "10x8 grid on left temporal pole",
% 'strip2': "1x8 electrode strip on xxx"}.

%% Optional fields:

json.ElectricalStimulation = ''; % Boolean field to specify if electrical stimulation
% was done during the recording (options are "true" or "false"). Parameters for event-like
% stimulation should be specified in the _events.tsv file (see example underneath).

json.ElectricalStimulationParameters = ''; % Free form description of stimulation parameters,
% such as frequency, shape etc. Specific onsets can be specified in the _events.tsv file.
% Specific shapes can be described here in freeform text.

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
