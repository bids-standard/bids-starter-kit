% Template Matlab script to create a BIDS compatible:
%
%   sub-01_ses-01_task-ShortExample_pet.json
%
% This example lists all REQUIRED fields.

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

clear;
this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');
project_label = 'templates';
sub_id = '01';
ses_id = '01';
task_id = 'ShortExample';
data_type = 'pet';

% this makes the json look prettier when opened in a txt editor
json_options.indent = '    ';

json_name = fullfile(root_dir, project_label, ...
                     ['sub-' sub_id], ...
                     ['ses-' ses_id], ...
                     data_type, ...
                     ['sub-' sub_id '_ses-' ses_id '_task-' task_id '_pet.json']);

content.Manufacturer =  '';
content.ManufacturersModelName =  '';
content.Units =  '';
content.TracerName =  '';
content.TracerRadionuclide =  '';
content.InjectedRadioactivity =  '';
content.InjectedRadioactivityUnits =  '';
content.InjectedMass =  '';
content.InjectedMassUnits =  '';
content.SpecificRadioactivity =  '';
content.SpecificRadioactivityUnits =  '';
content.ModeOfAdministration =  '';
content.TimeZero =  '';
content.ScanStart =  '';
content.InjectionStart =  '';
content.FrameTimesStart =  [];
content.FrameDuration =  [];
content.AcquisitionMode =  '';
content.ImageDecayCorrected =  '';
content.ImageDecayCorrectionTime =  '';
content.ReconMethodName =  '';
content.ReconMethodParameterLabels =  [];
content.ReconMethodParameterUnits =  [];
content.ReconMethodParameterValues =  [];
content.ReconFilterType =  [];
content.ReconFilterSize =  [];
content.AttenuationCorrection =  '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
