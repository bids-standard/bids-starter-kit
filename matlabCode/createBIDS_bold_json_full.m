%% Template Matlab script to create an BIDS compatible _bold.json file
% This example lists all required and optional fields.
% When adding additional metadata please use the camelcase version of DICOM ontology terms whenever possible.
%
% DHermes, 2017

%%

root_dir = '.';
project_label = 'template';
sub_label = '01';
ses_label = '01';
task_label = 'FullExample';
run_label = '01';

% you can also have acq- and proc-, but these are optional

bold_json_name = fullfile(root_dir,project_label,[ 'sub-' sub_label ],...
    ['ses-' ses_label],...
    'fmri',...
    ['sub-' sub_label ...
    '_ses-' ses_label ...
    '_task-' task_label ...
    '_run-' run_label '_bold.json']);

%%

% General fields, shared with MRI BIDS and MEG BIDS:
% Required fields:
bold_json.TaskName = ''; % Name of the task (for resting state use the ?rest? prefix). No two tasks should have the same name. Task label is derived from this field by removing all non alphanumeric ([a-zA-Z0-9]) characters. 
bold_json.RepetitionTime = ''; % The time in seconds between the beginning of an acquisition of one volume and the beginning of acquisition of the volume following it (TR). Please note that this definition includes time between scans (when no data has been acquired) in case of sparse acquisition schemes. This value needs to be consistent with the ?pixdim[4]? field (after accounting for units stored in ?xyzt_units? field) in the NIfTI header 

% Recommended fields:
bold_json.Manufacturer = ''; % Manufacturer of the equipment that produced the composite instances. Corresponds to DICOM Tag 0008, 0070 ?Manufacturer? .
bold_json.ManufacturersModelName = ''; % Manufacturer`s model name of the equipment that produced the composite instances. Corresponds to DICOM Tag 0008, 1090 ?Manufacturers Model Name?.
bold_json.MagenticFieldStrength = ''; % Nominal field strength of MR magnet in Tesla. Corresponds to DICOM Tag 0018,0087 ?Magnetic Field Strength? .
bold_json.DeviceSerialNumber = ''; % The serial number of the equipment that produced the composite instances. A pseudonym can also be used to prevent the equipment from being identifiable, as long as each pseudonym is unique within the dataset.
bold_json.SoftwareVersions = ''; % Manufacturer?s designation of software version of the equipment that produced the composite instances. Corresponds to DICOM Tag 0018, 1020 ?Software Versions?
bold_json.ReceiveCoilName = '';% Information describing the receiver coil (Note: This isn?t a consistent field name across vendors. This name is the dcmstack output from a GE dataset, but it doesn?t seem to be simply coded into the dcmstack output for a Siemens scan). This doesn?t correspond to a term in the DICOM ontology
bold_json.GradientSetType = '';% It should be possible to infer the gradient coil from the scanner model. If not, because of a custom upgrade or use of a gradient insert set, then the specifications of the actual gradient coil should be reported independently.
bold_json.MRTransmitCoilSequence = '';% This is a relevant field if a non-standard transmit coil is used. Corresponds to DICOM Tag 0018, 9049 ?MR Transmit Coil Sequence?
bold_json.MatrixCoilMode = '';% (If used) A method for reducing the number of independent channels by combining in analog the signals from multiple coil elements. There are typically different default modes when using un-accelerated or accelerated ( GRAPPA, SENSE) imaging.
bold_json.CoilCombinationMethod = '';%  Almost all fMRI studies using phased-array coils use root-sum-of-squares (rSOS) combination, but other methods exist. The image reconstruction is changed by the coil combination method (as for the matrix coil mode above), so anything non-standard should be reported.

bold_json.PulseSequenceType = '';% A general description of the pulse sequence used for the scan (i.e. MPRAGE, Gradient Echo EPI, Spin Echo EPI, Multiband gradient echo EPI). 
bold_json.PulseSequenceDetails = '';% Information beyond pulse sequence type that identifies the specific pulse sequence used (I.e. "Standard Siemens Sequence distributed with the VB17 software,? ?Siemens WIP ### version #.##,? or ?Sequence written by X using a version compiled on MM/DD/YYYY?).
bold_json.NumberShots = '';% The number of RF excitations need to reconstruct a slice or volume. Please mind that this is not the same as Echo Train Length which denotes the number of lines of k-space collected after an excitation.
bold_json.ParallelReductionFactorInPlane = '';% The parallel imaging (e.g, GRAPPA) factor. Use the denominator of the fraction of k-space encoded for each slice. For example, 2 means half of k-space is encoded. Corresponds to DICOM Tag 0018, 9069 ?Parallel Reduction Factor In-plane?.
bold_json.ParallelAcquisitionTechnique = '';% The type of parallel imaging used (e.g. GRAPPA, SENSE). Corresponds to DICOM Tag 0018, 9078 ?Parallel Acquisition Technique?.
bold_json.PartialFourier = '';% The fraction of partial Fourier information collected. Corresponds to DICOM Tag 0018, 9081 ?Partial Fourier?.
bold_json.PartialFourierDirection = '';%The direction where only partial Fourier information was collected. Corresponds to DICOM Tag 0018, 9036 ?Partial Fourier Direction?. 
bold_json.PhaseEncodingDirection  = '';% Possible values: ?i?, ?j?, ?k?, ?i-?, ?j-?, ?k-?. The letters ?i?, ?j?, ?k? correspond to the first, second and third axis of the data in the NIFTI file. The polarity of the phase encoding is assumed to go from zero index to maximum index unless ?-? sign is present (then the order is reversed - starting from the highest index instead of zero). PhaseEncodingDirection is defined as the direction along which phase is was modulated which may result in visible distortions. Note that this is not the same as the DICOM term InPlanePhaseEncodingDirection which can have ?ROW? or ?COL? values. This parameter is required if a corresponding fieldmap data is present or when using multiple runs with different phase encoding directions (which can be later used for field inhomogeneity correction).
bold_json.EffectiveEchoSpacing  = '';% The sampling interval also known as the dwell time; required for unwarping distortions using field maps; expressed in seconds. See here how to calculate it. This parameter is required if a corresponding fieldmap data is present.
bold_json.TotalReadoutTime  = ''; % defined as the time ( in seconds ) from the center of the first echo to the center of the last echo (aka ?FSL definition? - see here and here how to calculate it). This parameter is required if a corresponding multiple phase encoding directions fieldmap (see 8.9.4) data is present.

bold_json.EchoTime = '';% The echo time (TE) for the acquisition, specified in seconds. This parameter is required if a corresponding fieldmap data is present or the data comes from a multi echo sequence. Corresponds to DICOM Tag 0018, 0081 ?Echo Time?.
bold_json.InversionTime = '';% The inversion time (TI) for the acquisition, specified in seconds. Inversion time is the time after the middle of inverting RF pulse to middle of excitation pulse to detect the amount of longitudinal magnetization. Corresponds to DICOM Tag 0018, 0082 ?Inversion Time?.
bold_json.SliceTiming = '';% The time at which each slice was acquired during the acquisition. Slice timing is not slice order - it describes the time (sec) of each slice acquisition in relation to the beginning of volume acquisition. It is described using a list of times (in JSON format) referring to the acquisition time for each slice. The list goes through slices along the slice axis in the slice encoding dimension (see below). This parameter is required for sparse sequences. In addition without this parameter slice time correction will not be possible.
bold_json.SliceEncodingDirection = ''; % Possible values: ?i?, ?j?, ?k?, ?i-?, ?j-?, ?k-? (corresponding to the first, second and third axis of the data in the NIfTI file; ?-? sign corresponds to reverse order - starting from the highest index instead of zero). The axis of the NIfTI data along which a slices were acquired. This value needs to be consistent with the ?slice_dim? field in the NIfTI header.
bold_json.NumberOfVolumesDiscardedByScanner = ''; %Number of volumes ("dummy scans") discarded by the user (as opposed to those discarded by the user post hoc) before saving the imaging file. For example, a sequence that automatically discards the first 4 volumes before saving would have this field as 4. A sequence that doesn't discard dummy scans would have this set to 0. Please note that the onsets recorded in the _event.tsv file should always refer to the beginning of the acquisition of the first volume in the corresponding imaging file - independent of the value of NumberOfVolumesDiscardedByScanner field.
bold_json.NumberOfVolumesDiscardedByUser = '';% Number of volumes ("dummy scans") discarded by the user before including the file in the dataset. If possible, including all of the volumes is strongly recommended. Please note that the onsets recorded in the _event.tsv file should always refer to the beginning of the acquisition of the first volume in the corresponding imaging file - independent of the value of NumberOfVolumesDiscardedByUser field.
bold_json.DelayTime = ''; % User specified time (in seconds) to delay the acquisition of data for the following volume. If the field is not present it is assumed to be set to zero. Corresponds to Siemens CSA header field lDelayTimeInTR . This field is compulsory for sparse sequences that do not have the SliceTiming field set to allowed for accurate calculation of "acquisition time".

bold_json.FlipAngle = '';% Flip angle for the acquisition, specified in degrees. Corresponds to: DICOM Tag 0018, 1314 ?Flip Angle?.

bold_json.MultibandAccelerationFactor= ''; % The multiband factor, for multiband acquisitions.

bold_json.Instructions = ''; % Text of the instructions given to participants before the scan. This is especially important in context of resting state fMRI and distinguishing between eyes open and eyes closed paradigms.
bold_json.TaskDescription = '';% Longer description of the task.
bold_json.CogAtlasID = '';% URL of the corresponding Cognitive Atlas Task term.
bold_json.CogPOID = '';% URL of the corresponding CogPO term.

bold_json.InstitutionName = '';% The name of the institution in charge of the equipment that produced the composite instances. Corresponds to DICOM Tag 0008, 0080 ?InstitutionName?.
bold_json.InstitutionAddress = '';% The address of the institution in charge of the equipment that produced the composite instances. Corresponds to DICOM Tag 0008, 0081 ?InstitutionAddress?.

json_options.indent = '    '; % this just makes the json file look prettier when opened in a text editor

jsonSaveDir = fileparts(bold_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, first create: %s \n',jsonSaveDir)
end

jsonwrite(bold_json_name,bold_json,json_options)



