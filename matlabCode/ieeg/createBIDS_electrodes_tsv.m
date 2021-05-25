%% Template Matlab script to create an BIDS compatible electrodes.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified Giulio Castegnaro 201811

%%
clear;
root_dir = ['..' filesep '..'];
project_label = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';

electrodes_tsv_name = fullfile(root_dir, project_label, ...
                               ['sub-' ieeg_sub], ['ses-' ieeg_ses], 'ieeg', ...
                               ['sub-' ieeg_sub ...
                                '_ses-' ieeg_ses ...
                                '_electrodes.tsv']);

%% make a participants table and save

%% required columns
name = {''}; % Name of the electrode contact point
x = [0]'; % X position. The positions of the center of each electrode in xyz space.
% Units are in millimeters or pixels and are specified in _*space-<label>_electrode.json.
y = [0]'; % Y position.
z = [0]'; % Z position. If electrodes are in 2D space this should be a column of n/a values.
Size = [0]'; % Surface area in mm^2

%% recommended columns
material = {''}; % Material of the electrodes
manufacturer = {''}; % Optional field to specify the electrode manufacturer
% for each electrode. Can be used if electrodes were manufactured by more than one company.
group = {''}; % Optional field to specify the group that the electrode is a part of.
% Note that any group specified here should match a group specified in `_channels.tsv`
hemisphere = {''}; % Optional field to specify the hemisphere in which
% the electrode is placed, one of ["L" or "R"] (use capital).

%% optional columns
type = {''}; % Optional type of the electrode,e.g.,cup, ring, clip-on, wire, needle, ...
impedance = {''}; % Impedance of the electrode in kOhm.

%% write
t = table(name, x, y, z, Size, material, manufacturer, group, hemisphere, type, impedance);

writetable(t, electrodes_tsv_name, 'FileType', 'text', 'Delimiter', '\t');

clear Size;
