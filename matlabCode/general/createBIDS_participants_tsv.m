%% Template Matlab script to create an BIDS compatible participants.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified RG 201809

%%
clear
root_dir = ['..' filesep '..'];
project_label = 'templates';

participants_tsv_name = fullfile(root_dir,project_label,...
    'participants.tsv');

%% make a participants table and save 

participant_id = {'sub-01'};
age = [0]';
sex = {'m'}; 
handedness = {'l'}; 

t = table(participant_id,age,sex);

writetable(t,participants_tsv_name,'FileType','text','Delimiter','\t');

%% associated data dictionary

template = struct(...
'LongName', '', ...
'Description', '', ...
'Levels', [], ...
'Units', '', ...
'TermURL', '');

dd_json.age = template;
dd_json.age.Description = 'age of the participant';
dd_json.age.Units = 'years';

dd_json.sex = template;
dd_json.sex.Description = 'sex of the participant as reported by the participant';
dd_json.sex.Levels = struct(...
'm', 'male', ...
'f', 'female');

dd_json.handedness = template;
dd_json.handedness.Description = 'handedness of the participant as reported by the participant';
dd_json.handedness.Levels = struct(...
'l', 'left', ...
'r', 'right');


%% Write JSON

json_options.indent = '    '; % this just makes the json file look prettier
% when opened in a text editor

jsonSaveDir = fileparts(participants_tsv_name);
if ~isdir(jsonSaveDir)
    fprintf('Warning: directory to save json file does not exist: %s \n',jsonSaveDir)
end

try
    jsonwrite(strrep(participants_tsv_name, '.tsv', '.json'), dd_json, json_options)
catch
    warning( '%s\n%s\n%s\n%s',...
        'Writing the JSON file seems to have failed.', ...
        'Make sure that the following library is in the matlab/octave path:', ...
        'https://github.com/gllmflndn/JSONio')
end