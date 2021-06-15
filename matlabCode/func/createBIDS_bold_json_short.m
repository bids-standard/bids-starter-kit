%% Template Matlab script to create an BIDS compatible _bold.json file
% This example only lists the required fields.
% When adding additional metadata please use CamelCase
% Use version of DICOM ontology terms whenever possible.
%
% Writing json files relies on the JSONio library
% https://github.com/gllmflndn/JSONio
% Make sure it is in the matab/octave path
%
% DHermes, 2017

%%

root_dir = '../';
project_label = 'templates';
sub_label = '01';
ses_label = '01';
task_label = 'ShortExample';
run_label = '01';

% you can also have acq- and proc- fields, but these are optional

bold_json_name = fullfile(root_dir, project_label, ['sub-' sub_label], ...
                          ['ses-' ses_label], ...
                          'func', ...
                          ['sub-' sub_label ...
                           '_ses-' ses_label ...
                           '_task-' task_label ...
                           '_run-' run_label '_bold.json']);

%%

%% Required fields
% REQUIRED Name of the task (for resting state use the "rest" prefix). No two tasks
% should have the same name. Task label is derived from this field by
% removing all non alphanumeric ([a-zA-Z0-9]) characters.
bold_json.TaskName = '';

% REQUIRED The time in seconds between the beginning of an acquisition of
% one volume and the beginning of acquisition of the volume following it
% (TR). Please note that this definition includes time between scans
% (when no data has been acquired) in case of sparse acquisition schemes.
% This value needs to be consistent with the pixdim[4] field
% (after accounting for units stored in xyzt_units field) in the NIfTI header
bold_json.RepetitionTime = [];

% REQUIRED This field is mutually exclusive with RepetitionTime and DelayTime.
% If defined, this requires acquisition time (TA) be defined via either SliceTiming
% or AcquisitionDuration be defined.
%
% The time at which each volume was acquired during the acquisition.
% It is described using a list of times (in JSON format) referring to the
% onset of each volume in the BOLD series. The list must have the same length
% as the BOLD series, and the values must be non-negative and monotonically
% increasing.
bold_json.VolumeTiming = [];

% RECOMMENDED This field is mutually exclusive with VolumeTiming.
%
% User specified time (in seconds) to delay the acquisition of
% data for the following volume. If the field is not present it is assumed
% to be set to zero. Corresponds to Siemens CSA header field lDelayTimeInTR.
% This field is REQUIRED for sparse sequences using the RepetitionTime field
% that do not have the SliceTiming field set to allowed for accurate calculation
% of "acquisition time".
bold_json.DelayTime = [];

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
bold_json.SliceTiming = '';

% RECOMMENDED This field is REQUIRED for sequences that are described with
% the VolumeTiming field and that not have the SliceTiming field set to allowed
% for accurate calculation of "acquisition time". This field is mutually
% exclusive with RepetitionTime.
%
% Duration (in seconds) of volume acquisition. Corresponds to
% DICOM Tag 0018,9073 "Acquisition Duration".
bold_json.AcquisitionDuration = [];

%% Required fields if using a fieldmap
% REQUIRED if corresponding fieldmap data is present or when using multiple
% runs with different phase encoding directions PhaseEncodingDirection is
% defined as the direction along which phase is was modulated which may
% result in visible distortions.
bold_json.PhaseEncodingDirection = '';

% REQUIRED if corresponding fieldmap data is present.
% The effective sampling interval, specified in seconds, between lines in
% the phase-encoding direction, defined based on the size of the reconstructed
% image in the phase direction.
bold_json.EffectiveEchoSpacing = '';

% REQUIRED if corresponding fieldmap data is present or the data comes from
% a multi echo sequence. The echo time (TE) for the acquisition, specified in seconds.
% Corresponds to DICOM Tag 0018, 0081 "Echo Time"
bold_json.EchoTime = '';

%% Write
% this just makes the json file look prettier when opened in a text editor
json_options.indent = ' ';

jsonSaveDir = fileparts(bold_json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, first create: %s \n', jsonSaveDir);
end

try
    jsonwrite(bold_json_name, bold_json, json_options);
catch
    warning('%s\n%s\n%s\n%s', ...
            'Writing the JSON file seems to have failed.', ...
            'Make sure that the following library is in the matlab/octave path:', ...
            'https://github.com/gllmflndn/JSONio');
end
