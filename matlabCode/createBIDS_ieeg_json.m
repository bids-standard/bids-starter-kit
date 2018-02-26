%% Template Matlab script to create an BIDS compatible _ieeg.json file
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
%
% DHermes, 2017
%%

clear all

root_dir = '../';
ieeg_project = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';
ieeg_task = 'LongExample';
ieeg_run = '01';

% you can also have acq- and proc-, but these are optional

ieeg_json_name = fullfile(root_dir,ieeg_project,[ 'sub-' ieeg_sub ],...
    ['ses-' ieeg_ses],...
    'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_task-' ieeg_task ...
    '_run-' ieeg_run '_ieeg.json']);

%%

% General fields, shared with MRI BIDS and MEG BIDS:
% Required fields:
ieeg_json.TaskName = ''; % Name of the task (for resting state use the ?rest? prefix). No two tasks should have the same name. Task label is derived from this field by removing all non alphanumeric ([a-zA-Z0-9]) characters. 
ieeg_json.Manufacturer = ''; % Manufacturer of the amplifier system  (e.g. "TDT, blackrock")
% Optional fields:
ieeg_json.ManufacturersModelName = ''; % Manufacturer?s designation of the iEEG amplifier model (e.g. "TDT"). 
ieeg_json.TaskDescription = ''; % Longer description of the task.
ieeg_json.Instructions = ''; % Text of the instructions given to participants before the recording. This is especially important in context of resting state and distinguishing between eyes open and eyes closed paradigms. 
ieeg_json.CogAtlasID = ''; % URL of the corresponding Cognitive Atlas Task term
ieeg_json.CogPOID = ''; %  URL of the corresponding CogPO term
ieeg_json.InstitutionName = ''; %  The name of the institution in charge of the equipment that produced the composite instances. 
ieeg_json.InstitutionAddress = ''; % The address of the institution in charge of the equipment that produced the composite instances. 
ieeg_json.DeviceSerialNumber = ''; % The serial number of the equipment that produced the composite instances. A pseudonym can also be used to prevent the equipment from being identifiable, as long as each pseudonym is unique within the dataset.

% General fields, shared with MEG BIDS:
% Required fields:
ieeg_json.EEGChannelCount = ''; % Number of EEG channels included in the recording (e.g. 0)  
ieeg_json.EOGChannelCount = ''; % Number of EOG channels included in the recording (e.g. 1)
ieeg_json.ECGChannelCount = ''; % Number of ECG channels included in the recording (e.g. 1)
ieeg_json.EMGChannelCount = ''; % Number of EMG channels included in the recording (e.g. 1)
ieeg_json.MiscChannelCount = ''; % Number of miscellaneous channels included in the recording (e.g. 1)
ieeg_json.TriggerChannelCount = ''; % Number of channels for digital (TTL bit level) triggers (e.g. 0) 
ieeg_json.PowerLineFrequency = ''; % Frequency (in Hz) of the power grid where the iEEG recording was done (i.e. 50 or 60) 
% Optional fields:
ieeg_json.RecordingDuration = ''; % Length of the recording in seconds (e.g. 3600)
ieeg_json.RecordingType = ''; %  ?continuous?, ?epoched? 
ieeg_json.EpochLength = ''; % Duration of individual epochs in seconds (e.g. 1). If recording was continuous, set value to ?Inf?.
ieeg_json.DeviceSoftwareVersion = ''; % Manufacturer?s designation of the acquisition software.
ieeg_json.SubjectArtefactDescription = ''; % Freeform description of the observed subject artefact and its possible cause (e.g. ?door open?, ?nurse walked into room at 2 min?, "Vagus Nerve Stimulator", ?non-removable implant?, ?seizure at 10 min?). If this field is left empty, it will be interpreted as absence of artifacts.

% Specific iEEG fields:
% Required fields:
ieeg_json.iEEGSurfChannelCount = ''; % Number of iEEG surface channels included in the recording (e.g. 120) 
ieeg_json.iEEGDepthChannelCount = ''; % Number of iEEG depth channels included in the recording (e.g. 8) 
% Optional fields:
ieeg_json.iEEGPlacementScheme = ''; % General description of the placement of the iEEG electrodes. Left/right/bilateral/depth/surface (e.g. ?left frontal grid and bilateral hippocampal depth? or ?surface strip and STN depth?).
ieeg_json.iEEGReferenceScheme = ''; % Specify reference scheme if more complex than one channel or CAR.
ieeg_json.Stimulation = ''; % Optional field to specify if electrical stimulation was done during the recording (options are 1 for yes, 0 for no). Parameters for event-like stimulation should be specified in the _events.tsv file (see example underneath). Continuous parameters that change across ?scans? can be indicated in the the _scans.tsv file.
ieeg_json.Medication = ''; %  Optional field to add medication that the patient was on during a recording. 

jsonSaveDir = fileparts(ieeg_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier when opened in a text editor
jsonwrite(ieeg_json_name,ieeg_json,json_options)



