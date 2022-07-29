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
bids_file = bids_file.use_schema();
bids_file = bids_file.reorder_entities();

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%%
% Assign the fields in the Matlab structure that can be saved as a json.
% all REQUIRED /RECOMMENDED /OPTIONAL metadata fields for Magnetic Resonance Imaging data

%% Scanner Hardware metadata fields

% RECOMMENDED Manufacturer of the equipment that produced the composite instances.
json.Manufacturer = ' ';

% RECOMMENDED Manufacturer`s model name of the equipment that produced the
% composite instances. Corresponds to DICOM Tag 0008, 1090 "Manufacturers Model Name".
json.ManufacturersModelName = ' ';

% RECOMMENDED Nominal field strength of MR magnet in Tesla. Corresponds to
% DICOM Tag 0018,0087 "Magnetic Field Strength".
json.MagneticFieldStrength = ' ';

% RECOMMENDED The serial number of the equipment that produced the composite
% instances. Corresponds to DICOM Tag 0018, 1000 "DeviceSerialNumber".
json.DeviceSerialNumber = ' ';

% RECOMMENDED Institution defined name of the machine that produced the composite
% instances. Corresponds to DICOM Tag 0008, 1010 "Station Name"
json.StationName = ' ';

% RECOMMENDED Manufacturer's designation of software version of the equipment
% that produced the composite instances. Corresponds to
% DICOM Tag 0018, 1020 "Software Versions".
json.SoftwareVersions = ' ';

% RECOMMENDED (Deprecated) Manufacturer's designation of the software of the
% device that created this Hardcopy Image (the printer). Corresponds to
% DICOM Tag 0018, 101 "Hardcopy Device Software Version".
json.HardcopyDeviceSoftwareVersion = ' ';

% RECOMMENDED Information describing the receiver coil
json.ReceiveCoilName = ' ';

% RECOMMENDED Information describing the active/selected elements of the receiver coil.
json.ReceiveCoilActiveElements = ' ';

% RECOMMENDED the specifications of the actual gradient coil from the scanner model
json.GradientSetType = ' ';

% RECOMMENDED This is a relevant field if a non-standard transmit coil is used.
% Corresponds to DICOM Tag 0018, 9049 "MR Transmit Coil Sequence".
json.MRTransmitCoilSequence = ' ';

% RECOMMENDED A method for reducing the number of independent channels by
% combining in analog the signals from multiple coil elements. There are
% typically different default modes when using un-accelerated or accelerated
% (for example: GRAPPA, SENSE) imaging
json.MatrixCoilMode = ' ';

% RECOMMENDED Almost all fMRI studies using phased-array coils use
% root-sum-of-squares (rSOS) combination, but other methods exist.
% The image reconstruction is changed by the coil combination method
% (as for the matrix coil mode above), so anything non-standard should be reported.
json.CoilCombinationMethod = ' ';

%% Sequence Specifics metadata fields

% RECOMMENDED A general description of the pulse sequence used for the scan
% (for instance: MPRAGE, Gradient Echo EPI, Spin Echo EPI, Multiband gradient echo EPI).
json.PulseSequenceType = ' ';

% RECOMMENDED Description of the type of data acquired. Corresponds to
% DICOM Tag 0018, 0020 "Sequence Sequence".
json.ScanningSequence = ' ';

% RECOMMENDED Variant of the ScanningSequence. Corresponds to
% DICOM Tag 0018, 0021 "Sequence Variant".
json.SequenceVariant = ' ';

% RECOMMENDED Parameters of ScanningSequence. Corresponds to
% DICOM Tag 0018, 0022 "Scan Options".
json.ScanOptions = ' ';

% RECOMMENDED Manufacturer's designation of the sequence name. Corresponds
% to DICOM Tag 0018, 0024 "Sequence Name".
json.SequenceName = ' ';

% RECOMMENDED Information beyond pulse sequence type that identifies the
% specific pulse sequence used
json.PulseSequenceDetails = ' ';

% RECOMMENDED Boolean stating if the image saved has been corrected for
% gradient nonlinearities by the scanner sequence.
json.NonlinearGradientCorrection = ' ';

%% In-Plane Spatial Encoding metadata fields

% RECOMMENDED The number of RF excitations need to reconstruct a slice or volume.
% Please mind that this is not the same as Echo Train Length which denotes
% the number of lines of k-space collected after an excitation.
json.NumberShots = ' ';

% RECOMMENDED The parallel imaging (e.g, GRAPPA) factor. Use the denominator
% of the fraction of k-space encoded for each slice.
json.ParallelReductionFactorInPlane = ' ';

% RECOMMENDED The type of parallel imaging used (for example: GRAPPA, SENSE).
% Corresponds to DICOM Tag 0018, 9078 "Parallel Acquisition Technique".
json.ParallelAcquisitionTechnique = ' ';

% RECOMMENDED The fraction of partial Fourier information collected.
% Corresponds to DICOM Tag 0018, 9081 "Partial Fourier".
json.PartialFourier = ' ';

% RECOMMENDED The direction where only partial Fourier information was collected.
% Corresponds to DICOM Tag 0018, 9036 "Partial Fourier Direction"
json.PartialFourierDirection = ' ';

% RECOMMENDED defined as the displacement of the water signal with respect to
% fat signal in the image. Water-fat shift (WFS) is expressed in number of pixels
json.WaterFatShift = ' ';

% RECOMMENDED Number of lines in k-space acquired per excitation per image.
json.EchoTrainLength = ' ';

%% Timing Parameters metadata fields

% REQUIRED if corresponding fieldmap data is present or the data comes from
% a multi echo sequence. The echo time (TE) for the acquisition, specified in seconds.
% Corresponds to DICOM Tag 0018, 0081 "Echo Time"
json.EchoTime = ' ';

% RECOMMENDED The inversion time (TI) for the acquisition, specified in seconds.
% Inversion time is the time after the middle of inverting RF pulse to middle
% of excitation pulse to detect the amount of longitudinal magnetization
json.InversionTime = ' ';

% RECOMMENDED Possible values: "i", "j", "k", "i-", "j-", "k-" (the axis of the NIfTI data
% along which slices were acquired, and the direction in which SliceTiming
% is defined with respect to). "i", "j", "k" identifiers correspond to the
% first, second and third axis of the data in the NIfTI file. When present
% ,the axis defined by SliceEncodingDirection needs to be consistent with
% the slice_dim field in the NIfTI header.
json.SliceEncodingDirection = ' ';

% RECOMMENDED Actual dwell time (in seconds) of the receiver per point in the
% readout direction, including any oversampling. For Siemens, this corresponds
% to DICOM field (0019,1018) (in ns).
json.DwellTime = ' ';

%% RF & Contrast metadata field

% RECOMMENDED Flip angle for the acquisition, specified in degrees.
% Corresponds to: DICOM Tag 0018, 1314 "Flip Angle".
json.FlipAngle = ' ';

%% Slice Acceleration metadata field

% RECOMMENDED The multiband factor, for multiband acquisitions.
json.MultibandAccelerationFactor = ' ';

%% Anatomical landmarks metadata fields

% RECOMMENDED Key:value pairs of any number of additional anatomical landmarks
% and their coordinates in voxel units
json.AnatomicalLandmarkCoordinates = ' ';

%% Institution information metadata fields

% RECOMMENDED The name of the institution in charge of the equipment that
% produced the composite instances. Corresponds to
% DICOM Tag 0008, 0080 "InstitutionName".
json.InstitutionName = ' ';

% RECOMMENDED The address of the institution in charge of the equipment that
% produced the composite instances. Corresponds to
% DICOM Tag 0008, 0081 "InstitutionAddress"
json.InstitutionAddress = ' ';

% RECOMMENDED The department in the institution in charge of the equipment
% that produced the composite instances. Corresponds to
% DICOM Tag 0008, 1040 "Institutional Department Name".
json.InstitutionalDepartmentName = ' ';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
