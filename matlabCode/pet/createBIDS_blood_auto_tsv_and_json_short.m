% Template Matlab script to create a BIDS compatible:
%
%   sub-01_ses-01_recording-AutosamplerShortExample_blood.tsv
%   sub-01_ses-01_recording-AutosamplerShortExample_blood.json
%
% This example lists all REQUIRED, RECOMMENDED and OPTIONAL fields.
%
% Writing json files relies on bids-matlab
% https://github.com/bids-standard/bids-matlab
% Make sure it is in the matab/octave path

clear;

root_dir = ['..' filesep '..'];

project_label = 'templates';

sub_id = '01';
ses_id = '01';
recording = 'AutosamplerShortExample';
suffix = '_blood';
data_type = 'pet';
extension = '.tsv';

file_name = fullfile(root_dir, project_label, ...
                     ['sub-' sub_id], ...
                     ['ses-' ses_id], ...
                     data_type, ...
                     ['sub-' sub_id '_ses-' ses_id '_recording-' recording suffix extension]);

%% Write TSV
content.time = 0;
content.whole_blood_radioactivity = 0;

bids.util.tsvwrite(file_name, content);

%% Write JSON
% this makes the json look prettier when opened in a txt editor
json_options.indent = '    ';

extension = '.json';

file_name = fullfile(root_dir, project_label, ...
                     ['sub-' sub_id], ...
                     ['ses-' ses_id], ...
                     data_type, ...
                     ['sub-' sub_id '_ses-' ses_id '_recording-' recording suffix extension]);

clear content;

content.PlasmaAvail = false;
content.WholeBloodAvail = true;
content.MetaboliteMethod = false;
content.DispersionCorrected = false;
content.time = struct('Description', ...
                      'Time in relation to time zero defined by the _pet.json', ...
                      'Units', 's');
content.whole_blood_radioactivity = struct('Description', ...
                                            'Radioactivity in uncorrected whole blood samples from Allogg autosampler.', ...
                                            'Units', 'kBq/ml');

jsonSaveDir = fileparts(file_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist, create: %s \n', jsonSaveDir);
end

try
    bids.util.jsonencode(file_name, content, json_options);
catch
    warning('%s\n%s\n%s\n%s', ...
            'Writing the JSON file seems to have failed.', ...
            'Make sure that the following library is in the matlab/octave path:', ...
            'https://github.com/bids-standard/bids-matlab');
end
