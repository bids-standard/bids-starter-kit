%% Template Matlab script to create an BIDS compatible participants.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
%
% DHermes, 2017

%%
clear all
root_dir = '.';
project_label = 'templates';

participants_tsv_name = fullfile(root_dir,project_label,...
    'participants.tsv');

%% make a participants table and save 

participant_id = {'sub-01';'sub-02'}; % onsets in seconds
age = [40 50]';
sex = {'m';'f'}; 

t = table(participant_id,age,sex);

writetable(t,participants_tsv_name,'FileType','text','Delimiter','\t');


