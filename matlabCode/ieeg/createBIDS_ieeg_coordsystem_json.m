%% Template Matlab script to create an BIDS compatible _electrodes.json file
% For BIDS-iEEG
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% Writing json files relies on the JSONio library
% https://github.com/gllmflndn/JSONio
% Make sure it is in the matab/octave path
%
% DHermes, 2017
% modified RG 201809
% modified Jaap van der Aar 30.11.18

%%
clear
root_dir = ['..' filesep '..'];
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
% For example, "ACPC". See Appendix VIII: preferred names of Coordinate systems.
% If "Other" (e.g., individual subject MRI), provide definition of the coordinate system in iEEGCoordinateSystemDescription
% If positions correspond to pixel indices in a 2D image (of either a volume-rendering,
% surface-rendering, operative photo, or operative drawing), this must be "pixels".
% See section 3.4.1: Electrode locations for more information on electrode locations.

loc_json.iEEGCoordinateUnits  = '';% Units of the _electrodes.tsv, MUST be "m", "mm", "cm" or "pixels".


%% Recommended fields

loc_json.iEEGCoordinateProcessingDescripton = ''; % Freeform text description or link to document
% describing the iEEG coordinate system system in detail (e.g., "Coordinate system with the origin
% at anterior commissure (AC), negative y-axis going through the posterior commissure (PC), z-axis
% going to a mid-hemisperic point which lies superior to the AC-PC line, x-axis going to the right")

loc_json.IndendedFor = ''; % This can be an MRI/CT or a file containing the operative photo, x-ray
% or drawing with path relative to the project folder. If only a surface reconstruction is available,
% this should point to the surface reconstruction file. Note that this file should have the same coordinate
% system specified in iEEGCoordinateSystem. (e.g. "sub-<label>/ses-<label>/anat/sub-01_T1w.nii.gz")
% for example
% T1: "/sub-<label>/ses-<label>/anat/sub-01_T1w.nii.gz"
% Surface: "/derivatives/surfaces/sub-<label>/ses-<label>/anat/sub-01_T1w_pial.R.surf.gii"
% Operative photo: "/sub-<label>/ses-<label>/ieeg/sub-0001_ses-01_acq-photo1_photo.jpg"
% Talairach: "/derivatives/surfaces/sub-Talairach/ses-01/anat/sub-Talairach_T1w_pial.R.surf.gii"

loc_json.iEEGCoordinateProcessingDescription = ''; % Has any projection been done on the electrode positions
% (e.g., "surface_projection",  "none").

loc_json.iEEGCoordinateProcessingReference = ''; % A reference to a paper that defines in more detail
% the method used to project or localize the electrodes


%% Write
jsonSaveDir = fileparts(electrodes_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n',jsonSaveDir)
end

json_options.indent = '    '; % this just makes the json file look prettier
% when opened in a text editor

try
    jsonwrite(electrodes_json_name,loc_json,json_options)
catch
    warning( '%s\n%s\n%s\n%s',...
        'Writing the JSON file seems to have failed.', ...
        'Make sure that the following library is in the matlab/octave path:', ...
        'https://github.com/gllmflndn/JSONio')
end
