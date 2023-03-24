% Template Matlab script to create a BIDS compatible:
%
%   sub-01_ses-01_task-FullExample_pet.json
%
% This example lists all REQUIRED, RECOMMENDED and OPTIONAL fields.

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
task_label = 'FullExample';

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
json.Manufacturer = '';
json.ManufacturersModelName = '';
json.Units = '';
json.InstitutionName = '';
json.InstitutionAddress = '';
json.InstitutionalDepartmentName = '';
json.BodyPart = '';
json.TracerName = '';
json.TracerRadionuclide = '';
json.InjectedRadioactivity = '';
json.InjectedRadioactivityUnits = '';
json.InjectedMass = '';
json.InjectedMassUnits = '';
json.SpecificRadioactivity = '';
json.SpecificRadioactivityUnits = '';
json.ModeOfAdministration = '';
json.TracerRadLex = '';
json.TracerSNOMED = '';
json.TracerMolecularWeight = '';
json.TracerMolecularUnits = '';
json.InjectedMassPerWeight = '';
json.InjectedMassPerWeightUnits = '';
json.SpecificRadioactivityMeasTime = '';
json.MolarActivity = '';
json.MolarActivityUnits = '';
json.MolarActivityMeasTime = '';
json.InfusionRadioActivity = '';
json.InfusionStart = '';
json.InfusionSpeed = '';
json.InfusionSpeedUnits = '';
json.InjectedVolume = '';
json.Purity = '';
json.PharamceuticalName = '';
json.PharmaceuticalDoseAmount = [];
json.PharmaceuticalDoseUnits = '';
json.PharmaceuticalDoseRegimen = '';
json.PharmaceuticalDoseTime = [];
json.Anaesthesia = '';
json.TimeZero = '';
json.ScanStart = '';
json.InjectionStart = '';
json.FrameTimesStart = [];
json.FrameDuration = [];
json.ScanDate = '';
json.InjectionEnd = '';
json.AcquisitionMode = '';
json.ImageDecayCorrected = '';
json.ImageDecayCorrectionTime = '';
json.ReconMethodName = '';
json.ReconMethodParameterLabels = [];
json.ReconMethodParameterUnits = [];
json.ReconMethodParameterValues = [];
json.ReconFilterType = [];
json.ReconFilterSize = [];
json.AttenuationCorrection = '';
json.ReconMethodImplementationVersion = '';
json.AttenuationCorrectionMethodReference = '';
json.ScaleFactor = [];
json.ScatterFraction = [];
json.DecayCorrectionFactor = [];
json.PromptRate = [];
json.RandomRate = [];
json.SinglesRate = [];

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
