%% Template Matlab script to create an BIDS compatible _electrodes.json file
% For BIDS-iEEG
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
%
% DHermes, 2017

%%

root_dir = '../';
ieeg_project = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';

electrodes_json_name = fullfile(root_dir,ieeg_project,...
    ['sub-' ieeg_sub ],['ses-' ieeg_ses],'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_coordsystem.json']);

%%
% Required fields:
loc_json.iEEGCoordinateSystem  = '';% This refers to the coordinate space to which the iEEG electrodes xyz positions are to be interpreted, specified in the BEP003: Common derivatives (e.g. T1w, Talairach, MNI152NLin6Sym, fsaverage6_sym)
loc_json.iEEGCoordinateUnits  = '';% This refers to how the coordinates of the iEEG channel positions are to be interpreted (e.g. ?mri?, ?ct?, "freesurfer_ras", ?Talairach?, "spm_mni" )
loc_json.iEEGCoordinateProcessingDescripton = ''; % This refers to whether any projection has been done on the electrode positions (e.g. ?surface_projection_Hermes?,  ?surface_projection_Dykstra?,  ?none?, "spm_normalize_mni" )
loc_json.IndendedFor = ''; % Relative path to the anatomical MRI to be used with the iEEG recording (e.g. "sub-<label>/ses-<label>/anat/sub-01_T1w.nii.gz")
loc_json.AssociatedImageCoordinateSystem = '';% Coordinate system used to represent the coordinate system of the AssociatedImage. For an MRI/surface this can be (?native-acpc?, ?freesurfer_ras?, ?Talairach-Tournoux?, if a specific atlas is used, see MEG-BIDS Appendix 7 for preferred coordinate systems). For an operative photo this should always be ?indices? (required).
loc_json.AssociatedImageCoordinateUnits = '';% MRI coordinate system used to represent the coordinates that are  listed in the other fields in this file, according to the software used (e.g. ?ctf?, "brainstorm_mri", "brainvisa_mri", "freesurfer_ras", "mni" or "other").  If "other" use the CoordinateSystemDescription field for more details. See 3.3.3. Fiducials information for more details.
% Optional fields:
loc_json.AssociatedImageCoordinateSystemDescription = ''; % Freeform description of the coordinate system. May also include a link to a documentation page or paper describing the system in greater detail.  See 3.3.3. Fiducials information for more details.
loc_json.iEEGCoordinateProcessingReference = ''; % If processing has been done, this field can be used to describe the reference to a paper or program. (e.g. ?Hermes et al., 2010 JNeuroMeth?,  ?Dykstra et al., 2012 NeuroImage?,  ?Curry? ).

jsonSaveDir = fileparts(electrodes_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier when opened in a text editor
jsonwrite(electrodes_json_name,loc_json,json_options)

