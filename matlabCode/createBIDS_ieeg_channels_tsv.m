%% Template Matlab script to create an BIDS compatible electrodes.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase 
%
% DHermes, 2017
% modified RG 201809
% modified Jaap van der Aar 30.11.18

%%
clear
root_dir = '../';
project_label = 'templates';
ieeg_sub = '01';
ieeg_ses = '01';
ieeg_task = 'LongExample';
ieeg_run = '01';

channels_tsv_name = fullfile(root_dir,project_label,...
    ['sub-' ieeg_sub ],['ses-' ieeg_ses],'ieeg',...
    ['sub-' ieeg_sub ...
    '_ses-' ieeg_ses ...
    '_task-' ieeg_task ...
    '_run-' ieeg_run '_channels.tsv']);



%% make a participants table and save 


%% required columns
name = {''}; % Label of the channel, only contains letters and numbers. 
% The label must correspond to _electrodes.tsv name and all ieeg type channels 
% are required to have a position. In case of bipolar recordings where the 
% channels are plugged into the hardware in bipolar manner, the channel name 
% must be ?Name01-Name02? with a dash between the two electrode names. The
% reference channel name MUST be provided in the reference column

type = {''}; % Type of channel e.g. SEEG, ECOG. 

units = {''}; % Physical unit of the value represented in this channel,
% e.g. V for Volt, specified according to the SI unit symbol and possibly 
% prefix (e.g. milliV, microV), see BIDS spec for Units and Prefixes.

low_cutoff = [0]; %Frequencies used for the low pass filter applied to the 
% channel in Hz. If no low pass filter was applied, use n/a. Note that 
% anti-alias is a low pass filter, specify its frequencies here if applicable.

high_cutoff = [0]; % Frequencies used for the high pass filter applied to 
% the channel in Hz. If no high pass filter applied, use n/a.


%% recommended columns:

reference = {''}; % Specification of the reference (e.g., ‘mastoid’, ’ElectrodeName01’,
% ‘intracranial’, ’CAR’, ’other’, ‘n/a’). If the channel is not an electrode channel 
% (e.g., a microphone channel) use `n/a`.

group = {''}; % Which group of channels (grid/strip/probe) this channel belongs to. 
% One group has one wire and noise can be shared. This can be a name or number.


%% optional  columns
 
sampling_frequency = [0];% Sampling rate of the channel in Hz.

description = {''}; % Brief free-text description of the channel, or other information of 
% interest (e.g. position (e.g., 'left lateral temporal surface', 'unipolar/bipolar', etc.)).

notch = [0]; % Frequencies used for the notch filter applied to the channel, 
% in Hz. If no notch filter applied, use n/a (required). 

status = {''}; %: Has good or bad: good channels can be taken into analysis. Bad indicates that
% the channel does not measure physiology: it is excessively noisy or broken or sitting on top 
% of another grid, throughout the whole recording. More subtle descriptions should go in status_description.

status_description = {''}; % Freeform text to specify subtle noise, or why a channel is bad.


%% write
t = table(name,type,units,low_cutoff,high_cutoff,reference,...
    group,sampling_frequency,description,notch,status,status_description);

writetable(t,channels_tsv_name,'FileType','text','Delimiter','\t');