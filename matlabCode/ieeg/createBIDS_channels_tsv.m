%% Template Matlab script to create an BIDS compatible electrodes.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified Jaap van der Aar 30.11.18

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

%%
clear;

this_dir = fileparts(mfilename('fullpath'));
root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
task_label = 'LongExample';
run_label = '01';

name_spec.modality = 'ieeg';
name_spec.suffix = 'channels';
name_spec.ext = '.tsv';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'task', task_label, ...
                            'run', run_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
channels_tsv_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%% make a participants table and save

%% required columns
name = {'n/a'}; % Label of the channel, only contains letters and numbers. The label must
% correspond to _electrodes.tsv name and all ieeg type channels are required to have \
% a position. The reference channel name MUST be provided in the reference column

type = {'n/a'}; % Type of channel, see below for adequate keywords in this field

units = {'n/a'}; % Physical unit of the value represented in this channel, for example: V for Volt,
% specified according to the SI unit symbol and possibly prefix symbol (for example: mV, ?V),
% see the BIDS spec (section 15 Appendix V: Units) for guidelines for Units and Prefixes.

low_cutoff = [0]; % Frequencies used for the low pass filter applied to the
% channel in Hz. If no low pass filter was applied, use n/a. Note that
% anti-alias is a low pass filter, specify its frequencies here if applicable.

high_cutoff = [0]; % Frequencies used for the high pass filter applied to
% the channel in Hz. If no high pass filter applied, use n/a.

%% recommended columns:

reference = {'n/a'}; % Specification of the reference (for example: "mastoid", "ElectrodeName01",
% "intracranial", "CAR", "other", "n/a"). If the channel is not an electrode channel
% (for example: a microphone channel) use `n/a`.

group = {'n/a'}; % Which group of channels (grid/strip/probe) this channel belongs to.
% One group has one wire and noise can be shared. This can be a name or number.
% Note that any groups specified in `_electrodes.tsv` must match those present here.

%% optional columns

sampling_frequency = [0]; % Sampling rate of the channel in Hz.

description = {'n/a'}; % Brief free-text description of the channel, or other information of
% interest (for example: position (for example: 'left lateral temporal surface', 'unipolar/bipolar', etc.)).

notch = [0]; % Frequencies used for the notch filter applied to the channel,
% in Hz. If no notch filter applied, use n/a.

status = {'bad'}; % Data quality observed on the channel (good/bad). A channel is considered bad
% if its data quality is compromised by excessive noise. Description of noise type SHOULD be
% provided in [status_description].

status_description = {'n/a'}; % Freeform text description of noise or artifact affecting data
% quality on the channel. It is meant to explain why the channel was declared bad in [status].

%% write
t = table(name, type, units, low_cutoff, high_cutoff, reference, ...
          group, sampling_frequency, description, notch, status, status_description);

writetable(t, channels_tsv_name, 'FileType', 'text', 'Delimiter', '\t');
