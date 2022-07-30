% Template Matlab script to create a BIDS compatible file:
%
%  sub-01_ses-01_run-01_acq-FullExample_T1w.json
%
% This example lists only the REQUIRED, RECOMMENDED and OPTIONAL fields.
% When adding additional metadata please use CamelCase

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
run_label = '01';

% The OPTIONAL acq-<label> key/value pair corresponds to a custom label
% the user MAY use to distinguish a different set of parameters used for
% acquiring the same modality.
acq_label = 'FullExample';

name_spec.modality = 'anat';
name_spec.suffix = 'T1w';
name_spec.ext = '.json';

name_spec.entities = struct('ses', ses_label, ...
                            'acq', acq_label, ...
                            'run', run_label, ...
                            'sub', sub_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%%
% Assign the fields in the Matlab structure that can be saved as a json.
% all REQUIRED /RECOMMENDED /OPTIONAL metadata fields for Magnetic Resonance Imaging data

%% Adding metadata
% to get the definition of each metadata,
% you can use the bids.Schema class from bids matlab

% For example
schema = bids.Schema;
def = schema.get_definition('TaskName');
fprintf(def.description);

%% Scanner Hardware metadata fields
json.Manufacturer = ' ';
json.ManufacturersModelName = ' ';
json.MagneticFieldStrength = ' ';
json.DeviceSerialNumber = ' ';
json.StationName = ' ';
json.SoftwareVersions = ' ';
json.HardcopyDeviceSoftwareVersion = ' ';
l;
json.ReceiveCoilName = ' ';
json.ReceiveCoilActiveElements = ' ';
json.GradientSetType = ' ';
json.MRTransmitCoilSequence = ' ';
json.MatrixCoilMode = ' ';
json.CoilCombinationMethod = ' ';

%% Sequence Specifics metadata fields
json.PulseSequenceType = ' ';
json.ScanningSequence = ' ';
json.SequenceVariant = ' ';
json.ScanOptions = ' ';
json.SequenceName = ' ';
json.PulseSequenceDetails = ' ';
json.NonlinearGradientCorrection = ' ';

%% In-Plane Spatial Encoding metadata fields
json.NumberShots = ' ';
json.ParallelReductionFactorInPlane = ' ';
json.ParallelAcquisitionTechnique = ' ';
json.PartialFourier = ' ';
json.PartialFourierDirection = ' ';
json.WaterFatShift = ' ';
json.EchoTrainLength = ' ';

%% Timing Parameters metadata fields
json.EchoTime = ' ';
json.InversionTime = ' ';
json.SliceEncodingDirection = ' ';
json.DwellTime = ' ';

%% RF & Contrast metadata field
json.FlipAngle = ' ';

%% Slice Acceleration metadata field
json.MultibandAccelerationFactor = ' ';

%% Anatomical landmarks metadata fields
json.AnatomicalLandmarkCoordinates = ' ';

%% Institution information metadata fields
json.InstitutionName = ' ';
json.InstitutionAddress = ' ';
json.InstitutionalDepartmentName = ' ';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
