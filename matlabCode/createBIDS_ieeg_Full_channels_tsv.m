%% Template Matlab script to create an BIDS compatible sub-01_ses-01_task-FullExample-01_run-01_channels.tsv file
% To genertae A .tsv file listing amplifier metadata such as channel names, types, sampling frequency, and other information.
% This example lists all required and optional fields.
% When adding additional metadata please use camelcase
% 
%
% anushkab, 2018
%%
clear all
root_dir = '../';
project_label = 'templates';
sub_id = '01';
ses_id = '01';
task_id = 'FullExample'; 

acquisition = 'ieeg';
run_id='01';


channels_tsv_name = fullfile(root_dir,project_label,...
  ['sub-' sub_id],...
              ['ses-' ses_id],acquisition,...
              ['sub-' sub_id ...
              '_ses-' ses_id ...
              '_task-' task_id ...
              '_run-' run_id '_channels.tsv']);
              
%% make a _channels table and save 
%% CONTAINS a set of REQUIRED RECOMMENDED and OPTIONAL columns

%REQUIRED Label of the channel, only contains letters and numbers. The label must correspond to _electrodes.tsv name and all ieeg type channels are required to have a position. In case of bipolar recordings where the channels are plugged into the hardware in bipolar manner, the channel name must be “Name01-Name02” with a dash between the two electrode names.  

name= {' '};

%REQUIRED Type of channel
type={' '};
 
%REQUIRED Physical unit of the data values recorded by this channel
units ={' '};

%REQUIRED Sampling rate of the channel in Hz 
sampling_frequency=[0]';

%REQUIRED Frequencies used for the low pass filter applied to the channel in Hz. If no low pass filter was applied, use n/a.
low_cutoff=[0]';

%REQUIRED Frequencies used for the high pass filter applied to the channel in Hz. If no high pass filter applied, use n/a
high_cutoff=[0]';
%REQUIRED Frequencies used for the notch filter applied to the channel, in Hz. If no notch filter applied, use n/a
notch=[0]';

%RECOMMENDED Which group of channels (grid/strip/probe) this channel belongs to. One group has one wire and noise can be shared. This can be a name or number
group={' '};

%RECOMMENDED Specification of the reference (options: ‘bipolar’, ‘mastoid’, ‘intracranial’, ’ElectrodeName01’
reference={' '};

%OPTIONAL Brief free-text description of the channel, or other information of interest (e.g. position (e.g., “left lateral temporal surface”, “unipolar/bipolar”, etc.)
description={ ' '};

%OPTIONAL status Has good or bad: good channels can be taken into analysis. Bad indicates that the channel does not measure physiology: it is excessively noisy or broken or sitting on top of another grid, throughout the whole recording. More subtle descriptions should go in status_description.
status={' '};

%OPTIONAL Freeform text to specify subtle noise, or why a channel is bad.
status_description={' '};

% Optional field in case additional software filters were used.
software_filters={' '};


t = table(name,type,units,sampling_frequency,low_cutoff,notch,group,reference,description,status,status_description,software_filters);

writetable(t,channels_tsv_name,'FileType','text','Delimiter','\t');
