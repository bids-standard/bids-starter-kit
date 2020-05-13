%% Template Matlab script to create an BIDS compatible sub-01_ses-01_acq-ShortExample_run-01_T1w.json file
% This example lists only the required  fields.
% When adding additional metadata please use CamelCase
%
% Writing json files relies on the JSONio library
% https://github.com/gllmflndn/JSONio
% Make sure it is in the matab/octave path
%
% anushkab, 2018
% modified RG 201809

%%
clear
root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_id = '01';
ses_id = '01';

%The OPTIONAL acq-<label> key/value pair corresponds to a custom label
% the user MAY use to distinguish a different set of parameters used for
% acquiring the same modality.

acq_id = 'ShortExample';

acquisition = 'anat';

%OPTIONAL ce-<label> key/value can be used to distinguish sequences
% using different contrast enhanced images
%OPTIONAL rec-<label> key/value can be used to distinguish different
% reconstruction algorithms

run_id='01';

anat_json_name = fullfile(root_dir,project_label,...
    ['sub-' sub_id],...==
    ['ses-' ses_id],acquisition,...
    ['sub-' sub_id ...
    '_ses-' ses_id ...
    '_acq-' acq_id ...
    '_run-' run_id '_T1w.json']);


%%
% Assign the fields in the Matlab structure that can be saved as a json.
% all REQUIRED /RECOMMENDED /OPTIONAL metadata fields for Magnetic Resonance Imaging data



%% In-Plane Spatial Encoding metadata fields

%REQUIRED if corresponding fieldmap data is present or when using multiple
% runs with different phase encoding directions phaseEncodingDirection is
% defined as the direction along which phase is was modulated which may
% result in visible distortions.
anat_json.PhaseEncodingDirection=' ';

%REQUIRED if corresponding fieldmap data is present. The effective sampling
% interval, specified in seconds, between lines in the phase-encoding direction,
% defined based on the size of the reconstructed image in the phase direction.
anat_json.EffectiveEchoSpacing=' ';

%REQUIRED if corresponding field/distortion maps acquired with opposing phase
% encoding directions are present. This is actually the effective total
% readout time , defined as the readout duration, specified in seconds,
% that would have generated data with the given level of distortion.
% It is NOT the actual, physical duration of the readout train
anat_json.TotalReadoutTime=' ';



%% Timing Parameters metadata fields

%REQUIRED if corresponding fieldmap data is present or the data comes from a multi echo sequence
%The echo time (TE) for the acquisition, specified in seconds.
%Corresponds to DICOM Tag 0018, 0081 "Echo Time"
anat_json.EchoTime=' ';

%REQUIRED for sparse sequences that do not have the DelayTime field set.
% In addition without this parameter slice time correction will not be possible.
%The time at which each slice was acquired within each volume (frame) of the acquisition.
anat_json.SliceTiming=' ';



%% Write JSON
% this makes the json look prettier when opened in a txt editor
json_options.indent = '    ';

jsonSaveDir = fileparts(anat_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

try
    jsonwrite(anat_json_name,anat_json,json_options)
catch
    warning( '%s\n%s\n%s\n%s',...
        'Writing the JSON file seems to have failed.', ...
        'Make sure that the following library is in the matlab/octave path:', ...
        'https://github.com/gllmflndn/JSONio')
end
