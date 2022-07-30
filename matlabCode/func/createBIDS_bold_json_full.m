%% Template Matlab script to create an BIDS compatible _bold.json file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
% Use version of DICOM ontology terms whenever possible.
%
% DHermes, 2017

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
name_spec.suffix = 'bold';
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

%% Adding metadata
% to get the definition of each metadata,
% you can use the bids.Schema class from bids matlab

% For example
schema = bids.Schema;
def = schema.get_definition('TaskName');
fprintf(def.description);

%% Required fields
json.TaskName = 'FullExample';
json.RepetitionTime = [];

%% Required fields if using a fieldmap
json.PhaseEncodingDirection = '';
json.EffectiveEchoSpacing = [];
json.EchoTime = [];

%% Recommended fields:

%% Scanner Hardware metadata fields
json.Manufacturer = '';
json.ManufacturersModelName = '';
json.MagneticFieldStrength = [];
json.DeviceSerialNumber = '';
json.StationName = ' ';
json.SoftwareVersions = ' ';
json.HardcopyDeviceSoftwareVersion = '';
json.ReceiveCoilName = ' ';
json.ReceiveCoilActiveElements = '';
json.GradientSetType = '';
json.MRTransmitCoilSequence = '';
json.MatrixCoilMode = '';
json.CoilCombinationMethod = '';

%% Sequence Specifics metadata fields
json.PulseSequenceType = '';
json.ScanningSequence = '';
json.SequenceVariant = '';
json.ScanOptions = '';
json.SequenceName = '';
json.PulseSequenceDetails = '';
json.NonlinearGradientCorrection = '';

%% In-Plane Spatial Encoding metadata fields
json.NumberShots = [];
json.ParallelReductionFactorInPlane = '';
json.ParallelAcquisitionTechnique = '';
json.PartialFourier = '';
json.PartialFourierDirection = '';
json.WaterFatShift = '';
json.EchoTrainLength = '';

%% Timing Parameters metadata fields
json.InversionTime = [];
json.SliceEncodingDirection = '';
json.DwellTime = [];
json.TotalReadoutTime = [];
json.DelayAfterTrigger = [];
json.NumberOfVolumesDiscardedByScanner = [];
json.NumberOfVolumesDiscardedByUser = [];

%% RF & Contrast metadata field
json.FlipAngle = [];

%% Slice Acceleration metadata field
json.MultibandAccelerationFactor = [];

%% Task metadata field
json.Instructions = '';
json.TaskDescription = '';
json.CogAtlasID = 'https://www.cognitiveatlas.org/FIXME';
json.CogPOID = 'http://www.cogpo.org/ontologies/CogPOver1.owl#FIXME';

%% Institution information metadata fields
json.InstitutionName = '';
json.InstitutionAddress = '';
json.InstitutionalDepartmentName = '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
