% Template Matlab script to create a BIDS compatible:
%
%   sub-01_ses-01_task-FullExample_pet.json
%
% This example lists all required  RECOMMENDED and OPTIONAL fields.
%
% Writing json files relies on bids-matlab
% https://github.com/bids-standard/bids-matlab
% Make sure it is in the matab/octave path

clear;
root_dir = ['..' filesep '..'];
project_label = 'templates';
sub_id = '01';
ses_id = '01';
task_id = 'FullExample';
data_type = 'pet';

% this makes the json look prettier when opened in a txt editor
json_options.indent = '    ';

json_name = fullfile(root_dir, project_label, ...
                     ['sub-' sub_id], ...
                     ['ses-' ses_id], ...
                     data_type, ...
                     ['sub-' sub_id '_ses-' ses_id '_task-' task_id '_pet.json']);

content.Manufacturer = '';
content.ManufacturersModelName = '';
content.Units = '';
content.InstitutionName = '';
content.InstitutionAddress = '';
content.InstitutionalDepartmentName = '';
content.BodyPart = '';
content.TracerName = '';
content.TracerRadionuclide = '';
content.InjectedRadioactivity = '';
content.InjectedRadioactivityUnits = '';
content.InjectedMass = '';
content.InjectedMassUnits = '';
content.SpecificRadioactivity = '';
content.SpecificRadioactivityUnits = '';
content.ModeOfAdministration = '';
content.TracerRadLex = '';
content.TracerSNOMED = '';
content.TracerMolecularWeight = '';
content.TracerMolecularUnits = '';
content.InjectedMassPerWeight = '';
content.InjectedMassPerWeightUnits = '';
content.SpecificRadioactivityMeasTime = '';
content.MolarActivity = '';
content.MolarActivityUnits = '';
content.MolarActivityMeasTime = '';
content.InfusionRadioActivity = '';
content.InfusionStart = '';
content.InfusionSpeed = '';
content.InfusionSpeedUnits = '';
content.InjectedVolume = '';
content.Purity = '';
content.PharamceuticalName = '';
content.PharmaceuticalDoseAmount = [];
content.PharmaceuticalDoseUnits = '';
content.PharmaceuticalDoseRegimen = '';
content.PharmaceuticalDoseTime = [];
content.Anaesthesia = '';
content.TimeZero = '';
content.ScanStart = '';
content.InjectionStart = '';
content.FrameTimesStart = [];
content.FrameDuration = [];
content.ScanDate = '';
content.InjectionEnd = '';
content.AcquisitionMode = '';
content.ImageDecayCorrected = '';
content.ImageDecayCorrectionTime = '';
content.ReconMethodName = '';
content.ReconMethodParameterLabels = [];
content.ReconMethodParameterUnits = [];
content.ReconMethodParameterValues = [];
content.ReconFilterType = [];
content.ReconFilterSize = [];
content.AttenuationCorrection = '';
content.ReconMethodImplementationVersion = '';
content.AttenuationCorrectionMethodReference = '';
content.ScaleFactor = [];
content.ScatterFraction = [];
content.DecayCorrectionFactor = [];
content.PromptRate = [];
content.RandomRate = [];
content.SinglesRate = [];

%% Write JSON

jsonSaveDir = fileparts(json_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n', jsonSaveDir);
end

try
    bids.util.jsonencode(json_name, content, json_options);
catch
    warning('%s\n%s\n%s\n%s', ...
            'Writing the JSON file seems to have failed.', ...
            'Make sure that the following library is in the matlab/octave path:', ...
            'https://github.com/bids-standard/bids-matlab');
end
