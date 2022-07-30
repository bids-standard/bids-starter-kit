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

%% Required fields
% REQUIRED Name of the task (for resting state use the ?rest? prefix). No two tasks
% should have the same name. Task label is derived from this field by
% removing all non alphanumeric ([a-zA-Z0-9]) characters.
json.TaskName = '';

% REQUIRED The time in seconds between the beginning of an acquisition of
% one volume and the beginning of acquisition of the volume following it
% (TR). Please note that this definition includes time between scans
% (when no data has been acquired) in case of sparse acquisition schemes.
% This value needs to be consistent with the pixdim[4] field
% (after accounting for units stored in xyzt_units field) in the NIfTI header
json.RepetitionTime = [];

% REQUIRED This field is mutually exclusive with RepetitionTime and DelayTime.
% If defined, this requires acquisition time (TA) be defined via either SliceTiming
% or AcquisitionDuration be defined.
%
% The time at which each volume was acquired during the acquisition.
% It is described using a list of times (in JSON format) referring to the
% onset of each volume in the BOLD series. The list must have the same length
% as the BOLD series, and the values must be non-negative and monotonically
% increasing.
json.VolumeTiming = [];

% RECOMMENDED This field is mutually exclusive with VolumeTiming.
%
% User specified time (in seconds) to delay the acquisition of
% data for the following volume. If the field is not present it is assumed
% to be set to zero. Corresponds to Siemens CSA header field lDelayTimeInTR.
% This field is REQUIRED for sparse sequences using the RepetitionTime field
% that do not have the SliceTiming field set to allowed for accurate calculation
% of "acquisition time".
json.DelayTime = [];

% REQUIRED for sparse sequences that do not have the DelayTime field set.
% This parameter is required for sparse sequences. In addition without this
% parameter slice time correction will not be possible.
%
% In addition without this parameter slice time correction will not be possible.
% The time at which each slice was acquired within each volume (frame) of the acquisition.
% The time at which each slice was acquired during the acquisition. Slice
% timing is not slice order - it describes the time (sec) of each slice
% acquisition in relation to the beginning of volume acquisition. It is
% described using a list of times (in JSON format) referring to the acquisition
% time for each slice. The list goes through slices along the slice axis in the
% slice encoding dimension.
json.SliceTiming = '';

% RECOMMENDED This field is REQUIRED for sequences that are described with
% the VolumeTiming field and that not have the SliceTiming field set to allowed
% for accurate calculation of "acquisition time". This field is mutually
% exclusive with RepetitionTime.
%
% Duration (in seconds) of volume acquisition. Corresponds to
% DICOM Tag 0018,9073 "Acquisition Duration".
json.AcquisitionDuration = [];

%% Required fields if using a fieldmap
% REQUIRED if corresponding fieldmap data is present or when using multiple
% runs with different phase encoding directions PhaseEncodingDirection is
% defined as the direction along which phase is was modulated which may
% result in visible distortions.
json.PhaseEncodingDirection = '';

% REQUIRED if corresponding fieldmap data is present.
% The effective sampling interval, specified in seconds, between lines in
% the phase-encoding direction, defined based on the size of the reconstructed
% image in the phase direction.
json.EffectiveEchoSpacing = '';

% REQUIRED if corresponding fieldmap data is present or the data comes from
% a multi echo sequence. The echo time (TE) for the acquisition, specified in seconds.
% Corresponds to DICOM Tag 0018, 0081 "Echo Time"
json.EchoTime = '';

%% Recommended fields:

%% Scanner Hardware metadata fields

% RECOMMENDED Manufacturer of the equipment that produced the composite instances.
json.Manufacturer = '';

% RECOMMENDED Manufacturer`s model name of the equipment that produced the
% composite instances. Corresponds to DICOM Tag 0008, 1090 "Manufacturers
% Model Name"
json.ManufacturersModelName = '';

% RECOMMENDED Nominal field strength of MR magnet in Tesla. Corresponds to
% DICOM Tag 0018,0087 "Magnetic Field Strength".
json.MagneticFieldStrength = '';

% RECOMMENDED The serial number of the equipment that produced the composite
% instances. Corresponds to DICOM Tag 0018, 1000 "DeviceSerialNumber".
json.DeviceSerialNumber = '';

% RECOMMENDED Institution defined name of the machine that produced the composite
% instances. Corresponds to DICOM Tag 0008, 1010 Station Name
json.StationName = ' ';

% RECOMMENDED Manufacturer's designation of software version of the equipment
% that produced the composite instances. Corresponds to
% DICOM Tag 0018, 1020 "Software Versions".
json.SoftwareVersions = ' ';

% RECOMMENDED (Deprecated) Manufacturer's designation of the software of the
% device that created this Hardcopy Image (the printer). Corresponds to
% DICOM Tag 0018, 101 "Hardcopy Device Software Version".
json.HardcopyDeviceSoftwareVersion = '';

% RECOMMENDED Information describing the receiver coil
json.ReceiveCoilName = ' ';

% RECOMMENDED Information describing the active/selected elements of the receiver coil.
anat_json.ReceiveCoilActiveElements = '';

% RECOMMENDED the specifications of the actual gradient coil from the scanner model
json.GradientSetType = '';

% RECOMMENDED This is a relevant field if a non-standard transmit coil is used.
% Corresponds to DICOM Tag 0018, 9049 "MR Transmit Coil Sequence".
json.MRTransmitCoilSequence = '';

% RECOMMENDED A method for reducing the number of independent channels by
% combining in analog the signals from multiple coil elements. There are
% typically different default modes when using un-accelerated or accelerated
% (for example: GRAPPA, SENSE) imaging
json.MatrixCoilMode = '';

% RECOMMENDED Almost all fMRI studies using phased-array coils use
% root-sum-of-squares (rSOS) combination, but other methods exist.
% The image reconstruction is changed by the coil combination method
% (as for the matrix coil mode above), so anything non-standard should be reported.
json.CoilCombinationMethod = '';

%% Sequence Specifics metadata fields

% RECOMMENDED A general description of the pulse sequence used for the scan
% (for instance: MPRAGE, Gradient Echo EPI, Spin Echo EPI, Multiband gradient echo EPI).
json.PulseSequenceType = '';

% RECOMMENDED Description of the type of data acquired. Corresponds to
% DICOM Tag 0018, 0020 "Sequence Sequence".
json.ScanningSequence = '';

% RECOMMENDED Variant of the ScanningSequence. Corresponds to
% DICOM Tag 0018, 0021 "Sequence Variant".
json.SequenceVariant = '';

% RECOMMENDED Parameters of ScanningSequence. Corresponds to
% DICOM Tag 0018, 0022 "Scan Options".
json.ScanOptions = '';

% RECOMMENDED Manufacturer's designation of the sequence name. Corresponds
% to DICOM Tag 0018, 0024 "Sequence Name".
json.SequenceName = '';

% RECOMMENDED Information beyond pulse sequence type that identifies the
% specific pulse sequence used
json.PulseSequenceDetails = '';

% RECOMMENDED Boolean stating if the image saved has been corrected for
% gradient nonlinearities by the scanner sequence.
json.NonlinearGradientCorrection = '';

%% In-Plane Spatial Encoding metadata fields

% RECOMMENDED The number of RF excitations need to reconstruct a slice or volume.
% Please mind that this is not the same as Echo Train Length which denotes
% the number of lines of k-space collected after an excitation.
json.NumberShots = '';

% RECOMMENDED The parallel imaging (e.g, GRAPPA) factor. Use the denominator
% of the fraction of k-space encoded for each slice.
json.ParallelReductionFactorInPlane = '';

% RECOMMENDED The type of parallel imaging used (for example: GRAPPA, SENSE).
% Corresponds to DICOM Tag 0018, 9078 "Parallel Acquisition Technique".
json.ParallelAcquisitionTechnique = '';

% RECOMMENDED The fraction of partial Fourier information collected.
% Corresponds to DICOM Tag 0018, 9081 "Partial Fourier".
json.PartialFourier = '';

% RECOMMENDED The direction where only partial Fourier information was collected.
% Corresponds to DICOM Tag 0018, 9036 "Partial Fourier Direction"
json.PartialFourierDirection = '';

% RECOMMENDED defined as the displacement of the water signal with respect to
% fat signal in the image. Water-fat shift (WFS) is expressed in number of pixels
json.WaterFatShift = '';

% RECOMMENDED Number of lines in k-space acquired per excitation per image.
json.EchoTrainLength = '';

%% Timing Parameters metadata fields

% RECOMMENDED The inversion time (TI) for the acquisition, specified in seconds.
% Inversion time is the time after the middle of inverting RF pulse to middle
% of excitation pulse to detect the amount of longitudinal magnetization
json.InversionTime = '';

% RECOMMENDED Possible values: "i", "j", "k", "i-", "j-", "k-" (the axis of the NIfTI data
% along which slices were acquired, and the direction in which SliceTiming
% is defined with respect to). "i", "j", "k" identifiers correspond to the
% first, second and third axis of the data in the NIfTI file. When present
% ,the axis defined by SliceEncodingDirection needs to be consistent with
% the slice_dim field in the NIfTI header.
json.SliceEncodingDirection = '';

% RECOMMENDED Actual dwell time (in seconds) of the receiver per point in the
% readout direction, including any oversampling. For Siemens, this corresponds
% to DICOM field (0019,1018) (in ns).
json.DwellTime = '';

% RECOMMENDED TotalReadoutTime defined as the time ( in seconds ) from the center of the first echo to
% the center of the last echo (aka "FSL definition" - see here and here how
% to calculate it). This parameter is required if a corresponding multiple
% phase encoding directions fieldmap (see 8.9.4) data is present.
json.TotalReadoutTime = '';

% RECOMMENDED Duration (in seconds) from trigger delivery to scan onset.
% This delay is commonly caused by adjustments and loading times. This specification
% is entirely independent of NumberOfVolumesDiscardedByScanner or
% NumberOfVolumesDiscardedByUser, as the delay precedes the acquisition.
json.DelayAfterTrigger = [];

% RECOMMENDED Number of volumes ("dummy scans") discarded by the user (as opposed to those
% discarded by the user post hoc) before saving the imaging file. For example,
% a sequence that automatically discards the first 4 volumes before saving
% would have this field as 4. A sequence that doesn't discard dummy scans would
% have this set to 0. Please note that the onsets recorded in the _event.tsv
% file should always refer to the beginning of the acquisition of the first
% volume in the corresponding imaging file - independent of the value of
% NumberOfVolumesDiscardedByScanner field.
json.NumberOfVolumesDiscardedByScanner = '';

% RECOMMENDED Number of volumes ("dummy scans") discarded by the user before including
% the file in the dataset. If possible, including all of the volumes is
% strongly recommended. Please note that the onsets recorded in the _event.tsv
% file should always refer to the beginning of the acquisition of the first
% volume in the corresponding imaging file - independent of the value of
% NumberOfVolumesDiscardedByUser field.
json.NumberOfVolumesDiscardedByUser = '';

%% RF & Contrast metadata field

% RECOMMENDED Flip angle for the acquisition, specified in degrees.
% Corresponds to: DICOM Tag 0018, 1314 "Flip Angle".
json.FlipAngle = '';

%% Slice Acceleration metadata field

% RECOMMENDED The multiband factor, for multiband acquisitions.
json.MultibandAccelerationFactor = '';

%% Task metadata field

% RECOMMENDED Text of the instructions given to participants before the scan.
% This is especially important in context of resting state fMRI and
% distinguishing between eyes open and eyes closed paradigms.
json.Instructions = '';

% RECOMMENDED Longer description of the task.
json.TaskDescription = '';

% RECOMMENDED URL of the corresponding Cognitive Atlas Task term.
json.CogAtlasID = '';

% RECOMMENDED URL of the corresponding CogPO term.
json.CogPOID = '';

%% Institution information metadata fields

% RECOMMENDED The name of the institution in charge of the equipment that
% produced the composite instances. Corresponds to
% DICOM Tag 0008, 0080 "InstitutionName".
json.InstitutionName = '';

% RECOMMENDED The address of the institution in charge of the equipment that
% produced the composite instances. Corresponds to
% DICOM Tag 0008, 0081 "InstitutionAddress"
json.InstitutionAddress = '';

% RECOMMENDED The department in the institution in charge of the equipment
% that produced the composite instances. Corresponds to
% DICOM Tag 0008, 1040 "Institutional Department Name".
json.InstitutionalDepartmentName = '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
