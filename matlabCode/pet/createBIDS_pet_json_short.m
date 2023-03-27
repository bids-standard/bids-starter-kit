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

project = 'templates';

sub_label = '01';
ses_label = '01';
task_label = 'ShortExample';

name_spec.modality = 'pet';
name_spec.suffix = 'pet';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'task', task_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

% get the definition of each column,
% use the bids.Schema class from bids matlab
% example:
%
% schema = bids.Schema;
% def = schema.get_definition('TaskName');

json.TaskName = task_label;
json.Manufacturer =  '';
json.ManufacturersModelName =  '';
json.Units =  '';
json.TracerName =  '';
json.TracerRadionuclide =  '';
json.InjectedRadioactivity =  '';
json.InjectedRadioactivityUnits =  '';
json.InjectedMass =  '';
json.InjectedMassUnits =  '';
json.SpecificRadioactivity =  '';
json.SpecificRadioactivityUnits =  '';
json.ModeOfAdministration =  '';
json.TimeZero =  '';
json.ScanStart =  '';
json.InjectionStart =  '';
json.FrameTimesStart =  [];
json.FrameDuration =  [];
json.AcquisitionMode =  '';
json.ImageDecayCorrected =  '';
json.ImageDecayCorrectionTime =  '';
json.ReconMethodName =  '';
json.ReconMethodParameterLabels =  [];
json.ReconMethodParameterUnits =  [];
json.ReconMethodParameterValues =  [];
json.ReconFilterType =  [];
json.ReconFilterSize =  [];
json.AttenuationCorrection =  '';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
