<<<<<<< Updated upstream
%% Template Matlab script to create an BIDS compatible _electrodes.json file
% For BIDS-iEEG
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase 
%
% DHermes, 2017
% modified RG 201809
% modified Jaap van der Aar 30.11.18

%%
clear
root_dir = '../';
ieeg_project = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';

electrodes_json_name = fullfile(root_dir,ieeg_project,...
    ['sub-' ieeg_sub ],['ses-' ieeg_ses],'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_coordsystem.json']);



%%  Required fields

loc_json.iEEGCoordinateSystem  = '';% Defines the coordinate system for the iEEG electrodes. 
% For example, “ACPC”. See Appendix VIII: preferred names of Coordinate systems. 
% If "Other" (e.g., individual subject MRI), provide definition of the coordinate system in iEEGCoordinateSystemDescription 
% If positions correspond to pixel indices in a 2D image (of either a volume-rendering, 
% surface-rendering, operative photo, or operative drawing), this must be “pixels”.
% See section 3.4.1: Electrode locations for more information on electrode locations. 

loc_json.iEEGCoordinateUnits  = '';% Units of the _electrodes.tsv, MUST be “m”, “mm”, “cm” or “pixels”. 


%% Recommended fields

loc_json.iEEGCoordinateProcessingDescripton = ''; % Freeform text description or link to document 
% describing the iEEG coordinate system system in detail (e.g., “Coordinate system with the origin 
% at anterior commissure (AC), negative y-axis going through the posterior commissure (PC), z-axis 
% going to a mid-hemisperic point which lies superior to the AC-PC line, x-axis going to the right”)

loc_json.IndendedFor = ''; % This can be an MRI/CT or a file containing the operative photo, x-ray 
% or drawing with path relative to the project folder. If only a surface reconstruction is available,
% this should point to the surface reconstruction file. Note that this file should have the same coordinate 
% system specified in iEEGCoordinateSystem. (e.g. "sub-<label>/ses-<label>/anat/sub-01_T1w.nii.gz")
% for example 
% T1: "/sub-<label>/ses-<label>/anat/sub-01_T1w.nii.gz"
% Surface: "/derivatives/surfaces/sub-<label>/ses-<label>/anat/sub-01_T1w_pial.R.surf.gii" 
% Operative photo: "/sub-<label>/ses-<label>/ieeg/sub-0001_ses-01_acq-photo1_photo.jpg" 
% Talairach: "/derivatives/surfaces/sub-Talairach/ses-01/anat/sub-Talairach_T1w_pial.R.surf.gii”

loc_json.iEEGCoordinateProcessingDescription = ''; % Has any projection been done on the electrode positions 
% (e.g., “surface_projection”,  “none”).

loc_json.iEEGCoordinateProcessingReference = '' % A reference to a paper that defines in more detail
% the method used to project or localize the electrodes


%% Write
jsonSaveDir = fileparts(electrodes_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier 
% when opened in a text editor
jsonwrite(electrodes_json_name,loc_json,json_options)

=======
%% Template Matlab script to create an BIDS compatible _electrodes.json file
% For BIDS-iEEG
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase 
%
% DHermes, 2017
% modified RG 201809

%%
clear
root_dir = '../';
ieeg_project = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';

electrodes_json_name = fullfile(root_dir,ieeg_project,...
    ['sub-' ieeg_sub ],['ses-' ieeg_ses],'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_coordsystem.json']);



%%  Required fields

loc_json.iEEGCoordinateSystem  = '';% This refers to the coordinate space to 
% which the iEEG electrodes xyz positions are to be interpreted, specified in 
% the BEP003: Common derivatives (e.g. T1w, Talairach, MNI152NLin6Sym, fsaverage6_sym)

loc_json.iEEGCoordinateUnits  = '';% This refers to how the coordinates of 
% the iEEG channel positions are to be interpreted (e.g. ?mri?, ?ct?, "freesurfer_ras", 
% ?Talairach?, "spm_mni" )

loc_json.iEEGCoordinateProcessingDescripton = ''; % This refers to whether 
% any projection has been done on the electrode positions (e.g. ?surface_projection_Hermes?,  
% ?surface_projection_Dykstra?,  ?none?, "spm_normalize_mni" )

loc_json.IndendedFor = ''; % Relative path to the anatomical MRI to be used 
% with the iEEG recording (e.g. "sub-<label>/ses-<label>/anat/sub-01_T1w.nii.gz")

loc_json.AssociatedImageCoordinateSystem = '';% Coordinate system used to 
% represent the coordinate system of the AssociatedImage. For an MRI/surface 
% this can be (?native-acpc?, ?freesurfer_ras?, ?Talairach-Tournoux?, if a 
% specific atlas is used, see MEG-BIDS Appendix 7 for preferred coordinate 
% systems). For an operative photo this should always be ?indices? (required).

loc_json.AssociatedImageCoordinateUnits = '';% MRI coordinate system used to 
% represent the coordinates that are  listed in the other fields in this file, 
% according to the software used (e.g. ?ctf?, "brainstorm_mri", "brainvisa_mri", 
% "freesurfer_ras", "mni" or "other").  If "other" use the CoordinateSystemDescription 
% field for more details. See 3.3.3. Fiducials information for more details.



%% Optional fields

loc_json.AssociatedImageCoordinateSystemDescription = ''; % Freeform description 
% of the coordinate system. May also include a link to a documentation page 
% or paper describing the system in greater detail.  See 3.3.3. Fiducials 
% information for more details.

loc_json.iEEGCoordinateProcessingReference = ''; % If processing has been done, 
% this field can be used to describe the reference to a paper or program. 
% (e.g. ?Hermes et al., 2010 JNeuroMeth?,  ?Dykstra et al., 2012 NeuroImage?,  ?Curry? ).



%% Write
jsonSaveDir = fileparts(electrodes_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier 
% when opened in a text editor
jsonwrite(electrodes_json_name,loc_json,json_options)

>>>>>>> Stashed changes
