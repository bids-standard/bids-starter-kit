%% Template Matlab script to create an BIDS compatible _ieeg.json file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% Writing json files relies on the JSONio library
% https://github.com/gllmflndn/JSONio
% Make sure it is in the matab/octave path
%
% DHermes, 2017
% modified RG 201809
% modified Jaap van der Aar & Giulio Castegnaro 30.11.18

%%

clear

root_dir = '../';
eeg_project = 'templates';
eeg_sub = '01';
eeg_ses = '01';
eeg_task = 'LongExample';
eeg_run = '01';

% you can also have acq- and proc-, but these are optional

eeg_json_name = fullfile(root_dir,eeg_project,[ 'sub-' eeg_sub ],...
    ['ses-' eeg_ses],...
    'eeg',...
    ['sub-' eeg_sub ...
    '_ses-' eeg_ses ...
    '_task-' eeg_task ...
    '_run-' eeg_run '_eeg.json']);



%% General fields, shared with MRI BIDS and MEG BIDS:



%% Required fields:
eeg_json.TaskName = ''; % Name of the task (for resting state use the rest
% prefix). No two tasks should have the same name. Task label is derived
% from this field by removing all non alphanumeric ([a-zA-Z0-9]) characters.
% Note this does not have to be a "behavioral task" that subjects perform, but can reflect some
% information about the conditions present when the data was acquired (e.g., "rest" or "sleep").

eeg_json.SamplingFrequency = ''; %Sampling frequency (in Hz) of all the iEEG channels
% in the recording (e.g., 2400). All other channels should have frequency specified
% as well in the channels.tsv file.

eeg_json.PowerLineFrequency = ''; %Frequency (in Hz) of the power grid where the
% iEEG recording was done (i.e., 50 or 60).

eeg_json.SoftwareFilters = ''; %  List of temporal software filters applied or
% ideally  key:value pairs of pre-applied filters and their parameter values.
% (n/a if none). E.g., "{'HighPass': {'HalfAmplitudeCutOffHz': 1, 'RollOff: '6dB/Octave'}}".

eeg_json.DCOffsetCorrection = ''; % A description of the method (if any) used to correct for
% a DC offset.If the method used was subtracting the mean value for each channel, use "mean".

%% Recommended fields:

HardwareFilters.HighpassFilter.CutoffFrequency = []; % Contains the high pass hardware filter
% cut off frequency.

HardwareFilters.LowpassFilter.CutoffFrequency = []; % Contains the low pass hardware filter
% cut off frequency.

eeg_json.HardwareFilters = HardwareFilters; % Cutoff frequencies of high and low pass filter
% are stored in this variable automatically. No further input necessary.

eeg_json.Manufacturer = ''; % Manufacturer of the amplifier system  (e.g. "TDT, blackrock")

eeg_json.ManufacturersModelName = ''; % Manufacturer's designation of the
%iEEG amplifier model (e.g. "TDT").

eeg_json.TaskDescription = ''; % Longer description of the task.

eeg_json.Instructions = ''; % Text of the instructions given to participants
% before the recording. This is especially important in context of resting
% state and distinguishing between eyes open and eyes closed paradigms.

eeg_json.CogAtlasID = ''; % URL of the corresponding Cognitive Atlas Task term

eeg_json.CogPOID = ''; %  URL of the corresponding CogPO term

eeg_json.InstitutionName = ''; %  The name of the institution in charge of
% the equipment that produced the composite instances.

eeg_json.InstitutionAddress = ''; % The address of the institution in charge
% of the equipment that produced the composite instances.

eeg_json.DeviceSerialNumber = ''; % The serial number of the equipment that
% produced the composite instances. A pseudonym can also be used to prevent
% the equipment from being identifiable, as long as each pseudonym is unique
% within the dataset.

eeg_json.ECOGChannelCount = ''; % Number of iEEG surface channels included in the recording (e.g. 120)

eeg_json.SEEGChannelCount = ''; % Number of iEEG depth channels included in the recording (e.g. 8)

eeg_json.EEGChannelCount = ''; % Number of scalp EEG channels recorded simultaneously (e.g., 21)

eeg_json.EOGChannelCount = ''; % Number of EOG channels

eeg_json.ECGChannelCount = ''; % Number of ECG channels

eeg_json.EMGChannelCount = ''; % Number of EMG channels

eeg_json.MiscChannelCount = ''; % Number of miscellaneous analog channels for auxiliary  signals

eeg_json.TriggerChannelCount = ''; % Number of channels for digital (TTL bit level) triggers.

eeg_json.RecordingDuration = ''; % Length of the recording in seconds (e.g. 3600)

eeg_json.RecordingType = ''; % Defines whether the recording is "continuous" or "epoched"; this latter
% limited to time windows about events of interest (e.g., stimulus presentations, subject responses etc.)

eeg_json.EpochLength = ''; % Duration of individual epochs in seconds (e.g. 1).
% If recording was continuous, leave out the field.

eeg_json.SubjectArtefactDescription = ''; % Freeform description of the observed
% subject artefact and its possible cause (e.g. door open, nurse walked into room at 2 min,
% "Vagus Nerve Stimulator", non-removable implant, seizure at 10 min).
% If this field is left empty, it will be interpreted as absence of artifacts.

eeg_json.SoftwareVersions = ''; % Manufacturer's designation of the acquisition software.



%% Specific EEG fields:


% If mixed types of references, manufacturers or electrodes are used, please
% specify in the corresponding table in the _electrodes.tsv file

%% Required fields:

eeg_json.EEGReference = ''; % General description of the reference scheme used and
% (when applicable) of location of the reference electrode in the raw recordings
% (e.g., "left mastoid", "bipolar", "T01" for electrode with name T01, "intracranial electrode
% on top of a grid, not included with data", "upside down electrode"). If different channels have
% a different reference, this field should have a general description and the channel specific
% reference should be defined in the _channels.tsv file.

%% Recommended fields:

eeg_json.ElectrodeManufacturer = ''; % can be used if all electrodes are of the same manufacturer
%(e.g., AD-TECH, DIXI). If electrodes of different manufacturers are used, please use the corresponding
% table in the _electrodes.tsv file.

eeg_json.ElectrodeManufacturersModelName = ''; % Specify model name. If different electrode types are used,
%  please use the corresponding table in the _electrodes.tsv file

eeg_json.EEGGround = ''; % Description of the location of the ground electrode
% ("placed on right mastoid (M2)").

eeg_json.iEEGPlacementScheme = ''; % Freeform description of the placement of the iEEG electrodes.
% Left/right/bilateral/depth/surface(e.g. "left frontal grid and bilateral hippocampal depth" or
% "surface strip and STN depth" or "clinical indication bitemporal, bilateral temporal strips and left grid").

eeg_json.iEEGElectrodeGroups = ''; % Field to describe the way electrodes are grouped
% into strips, grids or depth probes e.g., {'grid1': "10x8 grid on left temporal pole",
% 'strip2': "1x8 electrode strip on xxx"}.

%% Optional fields:

eeg_json.ElectricalStimulation = ''; % Boolean field to specify if electrical stimulation
% was done during the recording (options are "true" or "false"). Parameters for event-like
% stimulation should be specified in the _events.tsv file (see example underneath).

eeg_json.ElectricalStimulationParameters = ''; % Free form description of stimulation parameters,
% such as frequency, shape etc. Specific onsets can be specified in the _events.tsv file.
% Specific shapes can be described here in freeform text.


%% write
jsonSaveDir = fileparts(eeg_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier
% when opened in a text editor

try
    jsonwrite(eeg_json_name,ieeg_json,json_options)
catch
    warning( '%s\n%s\n%s\n%s',...
        'Writing the JSON file seems to have failed.', ...
        'Make sure that the following library is in the matlab/octave path:', ...
        'https://github.com/gllmflndn/JSONio')
end
