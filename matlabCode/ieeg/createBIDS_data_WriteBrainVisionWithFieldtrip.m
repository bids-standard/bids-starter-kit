% %%%%% save data as BrainVision BIDS %%%%%
%
% Sample script that calls Fieldtrip functions to write a Brainvision dataset
% Added fields are examples, read these from the raw data
%
% Fieldtrip has to be in the path!
%
% D. Hermes 2018

% provide necessary labels and path to save the data:
dataRootPath = '';
sub_label = '01';
ses_label = '01';
task_label = 'visual';
run_label = '01';

% name to save data:
ieeg_name_save = fullfile(dataRootPath, ['sub-' sub_label], ['ses-' ses_label], 'ieeg', ...
                          ['sub-' sub_label...
                           '_ses-' ses_label...
                           '_task-' task_label...
                           '_run-' run_label ...
                           '_ieeg']);

%%%% assign header fields:

% sampling frequency
dataStruct.hdr.Fs = 1000;
dataStruct.hdr.nChans = 128;

% number of channels
dataStruct.hdr.label = cell(dataStruct.hdr.nChans, 1);
for kk = 1:dataStruct.hdr.nChans
    dataStruct.hdr.label{kk} = ['iEEG' int2str(kk)];
end

% number of samples
dataStruct.hdr.nSamples = 10000;

% ?
dataStruct.hdr.nSamplesPre = 0;

% 1 trial for continuous data
dataStruct.hdr.nTrials = 1;

% channels type, see BIDS list of types
dataStruct.hdr.chantype = cell(dataStruct.hdr.nChans, 1);
for kk = 1:dataStruct.hdr.nChans
    dataStruct.hdr.chantype{kk} = ['ECOG'];
end

% I still don't how to indicate the mu in BIDS, now using letter u
dataStruct.hdr.chanunit = repmat({'uV'}, size(d.data, 2), 1);

% labels again, same as before
dataStruct.label = dataStruct.hdr.label;

% time vector
dataStruct.time{1} = [1:dataStruct.hdr.nSamples] / dataStruct.hdr.Fs;

% put the data matrix here: electrodes x samples
dataStruct.trial{1} = data;

% sampling freq again, same as before
dataStruct.fsample = dataStruct.hdr.Fs;

% ?
dataStruct.sampleinfo = [1 dataStruct.hdr.nSamples];

% now fetch a header
hdr_data = ft_fetch_header(dataStruct);

% save the data
ft_write_data(ieeg_name_save, dataStruct.trial{1}, 'header', hdr_data, 'dataformat', 'brainvision_eeg');
