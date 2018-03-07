%% Template Matlab script to create an BIDS compatible electrodes.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
%
% DHermes, 2017

%%
clear all
root_dir = '../';
project_label = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';

electrodes_tsv_name = fullfile(root_dir,project_label,...
    ['sub-' ieeg_sub ],['ses-' ieeg_ses],'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_electrodes.tsv']);


%% make a participants table and save 

% required columns
name = {''}; % Name of the electrode
x = [0]';
y = [0]';
z = [0]';
size = [0]'; % Diameter in mm 
type = [0]'; % Type of intracranial electrode, one of [?surface?,  ?depth? , ?dbs?] 

% optional columns:
material = {''}; % Material of the electrodes
tissue = {''}; % If a clinician has made an observation about the tissue underneath the electrode  (e.g. epilepsy, tumor, if nothing state n/a)
manufacturer = {''}; % Optional field to specify the electrode manufacturer for each electrode. Can be used if electrodes were manufactured by more than one company.
grid_size = {''}; % Optional field to specify the dimensions of the grid the electrode is a part of. Should be of the form `(M, N)`. E.g., (8, 8) or(1, 4).

t = table(name,x,y,z,size,type,material,tissue,manufacturer,grid_size);

writetable(t,electrodes_tsv_name,'FileType','text','Delimiter','\t');

clear size

