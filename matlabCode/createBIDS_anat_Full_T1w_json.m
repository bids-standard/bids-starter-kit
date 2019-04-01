%% Template Matlab script to create an BIDS compatible sub-01_ses-01_acq-FullExample_run-01_T1w.json file
% This example lists all required  RECOMMENDED and optional fields.
% When adding additional metadata please use CamelCase 
%
% Writing json files relies 
% 
% anushkab, 2018
% modified RG 201809

%%
clear all
root_dir = '../';
project_label = 'templates';
sub_id = '01';
ses_id = '01';

%The OPTIONAL acq-<label> key/value pair corresponds to a custom label 
% the user MAY use to distinguish a different set of parameters used for 
% acquiring the same modality.  

acq_id = 'FullExample'; 

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



%% Scanner Hardware metadata fields

%RECOMMENDED Manufacturer of the equipment that produced the composite instances.
anat_json.Manufacturer=' ';

%RECOMMENDED Manufacturer`s model name of the equipment that produced the 
% composite instances. Corresponds to DICOM Tag 0008, 1090 "Manufacturers Model Name".
anant_json.ManufacturersModelName=' ';

%RECOMMENDED Nominal field strength of MR magnet in Tesla. Corresponds to 
% DICOM Tag 0018,0087 "Magnetic Field Strength".
anat_json.MagneticFieldStrength=' ';

%RECOMMENDED The serial number of the equipment that produced the composite 
% instances. Corresponds to DICOM Tag 0018, 1000 "DeviceSerialNumber". 
anat_json.DeviceSerialNumber=' ';

%RECOMMENDED Institution defined name of the machine that produced the composite 
% instances. Corresponds to DICOM Tag 0008, 1010 "Station Name"
anat_json.StationName= ' '; 

%RECOMMENDED Manufacturer's designation of software version of the equipment 
% that produced the composite instances. Corresponds to 
% DICOM Tag 0018, 1020 "Software Versions".
anat_json.SoftwareVersions= ' ';

%RECOMMENDED (Deprecated) Manufacturer's designation of the software of the 
% device that created this Hardcopy Image (the printer). Corresponds to 
% DICOM Tag 0018, 101 "Hardcopy Device Software Version".
anat_json.HardcopyDeviceSoftwareVersion=' ';

%RECOMMENDED Information describing the receiver coil
anat_json.ReceiveCoilName= ' ' ;

%RECOMMENDED Information describing the active/selected elements of the receiver coil. 
anat_json.ReceiveCoilActiveElements=' ';

%RECOMMENDED the specifications of the actual gradient coil from the scanner model
anat_json.GradientSetType=' ';

%RECOMMENDED This is a relevant field if a non-standard transmit coil is used. 
% Corresponds to DICOM Tag 0018, 9049 "MR Transmit Coil Sequence".
anat_json.MRTransmitCoilSequence=' ';

%RECOMMENDED A method for reducing the number of independent channels by 
% combining in analog the signals from multiple coil elements. There are 
% typically different default modes when using un-accelerated or accelerated 
% (e.g. GRAPPA, SENSE) imaging
anat_json.MatrixCoilMode=' ';

%RECOMMENDED Almost all fMRI studies using phased-array coils use 
% root-sum-of-squares (rSOS) combination, but other methods exist. 
% The image reconstruction is changed by the coil combination method 
% (as for the matrix coil mode above), so anything non-standard should be reported.
anat_json.CoilCombinationMethod=' ';



%% Sequence Specifics metadata fields

%RECOMMENDED A general description of the pulse sequence used for the scan 
% (i.e. MPRAGE, Gradient Echo EPI, Spin Echo EPI, Multiband gradient echo EPI).
anat_json.PulseSequenceType=' ';

%RECOMMENDED Description of the type of data acquired. Corresponds to 
% DICOM Tag 0018, 0020 "Sequence Sequence".
anat_json.ScanningSequence=' ';

%RECOMMENDED Variant of the ScanningSequence. Corresponds to 
% DICOM Tag 0018, 0021 "Sequence Variant".
anat_json.SequenceVariant=' ';

%RECOMMENDED Parameters of ScanningSequence. Corresponds to 
% DICOM Tag 0018, 0022 "Scan Options".
anat_json.ScanOptions=' ';

%RECOMMENDED Manufacturer's designation of the sequence name. Corresponds 
% to DICOM Tag 0018, 0024 "Sequence Name".
anat_json.SequenceName=' ';

%RECOMMENDED Information beyond pulse sequence type that identifies the 
% specific pulse sequence used
anat_json.PulseSequenceDetails=' ';

%RECOMMENDED Boolean stating if the image saved  has been corrected for 
% gradient nonlinearities by the scanner sequence. 
anat_json.NonlinearGradientCorrection=' ';



%% In-Plane Spatial Encoding metadata fields

%RECOMMENDED The number of RF excitations need to reconstruct a slice or volume. 
% Please mind that  this is not the same as Echo Train Length which denotes 
% the number of lines of k-space collected after an excitation. 
anat_json.NumberShots=' ';

%RECOMMENDED The parallel imaging (e.g, GRAPPA) factor. Use the denominator 
% of the fraction of k-space encoded for each slice.
anat_json.ParallelReductionFactorInPlane=' ';

%RECOMMENDED The type of parallel imaging used (e.g. GRAPPA, SENSE). 
% Corresponds to DICOM Tag 0018, 9078 "Parallel Acquisition Technique". 
anat_json.ParallelAcquisitionTechnique=' ';

%RECOMMENDED The fraction of partial Fourier information collected. 
% Corresponds to DICOM Tag 0018, 9081 "Partial Fourier".
anat_json.PartialFourier=' ';

%RECOMMENDED The direction where only partial Fourier information was collected. 
% Corresponds to DICOM Tag 0018, 9036 "Partial Fourier Direction"
anat_json.PartialFourierDirection=' ';

%RECOMMENDED defined as the displacement of the water signal with respect to 
% fat signal in the image. Water-fat shift (WFS) is expressed in number of pixels 
anat_json.WaterFatShift=' ';

%RECOMMENDED Number of lines in k-space acquired per excitation per image.
anat_json.EchoTrainLength=' ';



%% Timing Parameters metadata fields

%REQUIRED if corresponding fieldmap data is present or the data comes from 
% a multi echo sequence. The echo time (TE) for the acquisition, specified in seconds. 
%Corresponds to DICOM Tag 0018, 0081 "Echo Time"
anat_json.EchoTime=' ';



%RECOMMENDED The inversion time (TI) for the acquisition, specified in seconds. 
% Inversion time is the time after the middle of inverting RF pulse to middle 
% of excitation pulse to detect the amount of longitudinal magnetization
anat_json.InversionTime=' ';

%RECOMMENDED  Possible values: "i", "j", "k", "i-", "j-", "k-" (the axis of the NIfTI data 
% along which slices were acquired, and the direction in which SliceTiming 
% is  defined with respect to). "i", "j", "k" identifiers correspond to the 
% first, second and third axis of the data in the NIfTI file. When present 
% ,the axis defined by SliceEncodingDirection  needs to be consistent with 
% the slice_dim field in the NIfTI header.
anat_json.SliceEncodingDirection=' ';

%RECOMMENDED Actual dwell time (in seconds) of the receiver per point in the 
% readout direction, including any oversampling.  For Siemens, this corresponds 
% to DICOM field (0019,1018) (in ns).   
anat_json.DwellTime=' ';



%% RF & Contrast metadata field

%RECOMMENDED Flip angle for the acquisition, specified in degrees. 
% Corresponds to: DICOM Tag 0018, 1314 "Flip Angle".
anat_json.FlipAngle=' ';



%% Slice Acceleration metadata field

%RECOMMENDED The multiband factor, for multiband acquisitions.
anat_json.MultibandAccelerationFactor=' ';



%% Anatomical landmarks metadata fields

%RECOMMENDED Key:value pairs of any number of additional anatomical landmarks 
% and their coordinates in voxel units
anat_json.AnatomicalLandmarkCoordinates=' ';



%% Institution information metadata fields

%RECOMMENDED The name of the institution in charge of the equipment that 
% produced the composite instances. Corresponds to 
% DICOM Tag 0008, 0080 "InstitutionName".
anat_json.InstitutionName=' ';

%RECOMMENDED The address of the institution in charge of the equipment that 
% produced the composite instances. Corresponds to 
% DICOM Tag 0008, 0081 "InstitutionAddress"
anat_json.InstitutionAddress=' ';

%RECOMMENDED The department in the  institution in charge of the equipment 
% that produced the composite instances. Corresponds to 
% DICOM Tag 0008, 1040 "Institutional Department Name".
anat_json.InstitutionalDepartmentName=' ';


%OPTIONAL JSON field specific to anatomical scans
%Active ingredient of agent.  Values MUST be one of: IODINE, GADOLINIUM, 
% CARBON DIOXIDE, BARIUM, XENON Corresponds to DICOM Tag 0018,1048.
anat_json.ContrastBolusIngredient=' ';



%% Write JSON
% this makes the json look pretier when opened in a txt editor
json_options.indent = '    '; 

jsonSaveDir = fileparts(anat_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

try
    % bids.util.jsonencode(anat_json_name, anat_json)
    jsonwrite(anat_json_name,anat_json,json_options)
catch
    str = sprintf('%s\n%s\n%s\n%s',...
        'Writing the JSON file seems to have failed.', ...
        'Make sure that the following libraries are in the matlab/octave path:', ...
        '-https://github.com/gllmflndn/JSONio', ...
        '-https://github.com/bids-standard/bids-matlab');
    warning(str)
end

