%% Template Matlab script to create an BIDS compatible sub-01_ses-01_acq-highres_run-01_T1w.json file
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
% 
%
% anushkab, 2018
%%
clear all
root_dir = '../';
project_label = 'templates';
sub_id = '01';
ses_id = '01';
acq_id = 'highres'

acquisition = 'anat';
run_id='01';


anat_json_name = fullfile(root_dir,project_label,...
  ['sub-' sub_id],...
              ['ses-' ses_id],acquisition,...
              ['sub-' sub_id ...
              '_ses-' ses_id ...
              '_acq-' acq_id ...
              '_run-' run_id '_T1w.json']);

% Assign the fields in the Matlab structure that can be saved as a json.
%The following fields must be defined:

%%
%The “effective” sampling interval, specified in seconds, between lines in the phase-encoding direction, defined based on the size of the reconstructed image in the phase direction.  It is frequently, but incorrectly, referred to as  “dwell time” (see DwellTime parameter below for actual dwell time).  It is  required for unwarping distortions using field maps. Note that beyond just in-plane acceleration, a variety of other manipulations to the phase encoding need to be accounted for properly, including partial fourier, phase oversampling, phase resolution, phase field-of-view and interpolation. This parameter is REQUIRED if corresponding fieldmap data is present. 

anat_json.EffectiveEchoSpacing='0.0000074';
%PhaseEncodingDirection is defined as the direction along which phase is was modulated which may result in visible distortions. Note that this is not the same as the DICOM term InPlanePhaseEncodingDirection which can have “ROW” or “COL” values. 
anat_json.PhaseEncodingDirection=' k ';

%%

json_options.indent               = '    '; % this makes the json look pretier when opened in a txt editor

jsonSaveDir = fileparts(anat_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end


jsonwrite(anat_json_name,anat_json,json_options)


