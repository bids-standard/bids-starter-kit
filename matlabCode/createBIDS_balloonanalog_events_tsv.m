%% Template Matlab script to create an BIDS compatible sub-01_ses-01_task-balloonanalogrisktask_run-01_events.tsv file
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
task_id = 'balloonanalogrisktask';

acquisition = 'func';
run_id='01';


events_tsv_name = fullfile(root_dir,project_label,...
  ['sub-' sub_id],...
              ['ses-' ses_id],acquisition,...
              ['sub-' sub_id ...
              '_ses-' ses_id ...
              '_task-' task_id ...
              '_run-' run_id '_events.tsv']);
%% make a participants table and save 
onset = [0.061]'; % onsets in seconds
duration = [0.772]'; % duration in seconds (measured from onset)
trial_type={'pumps_demean'};  %Primary categorisation of each trial to identify them as instances of the experimental conditions
cash_demean={'n/a'}; %
control_pumps_demean={'n/a'};
explode_demean={'n/a'};
pumps_demean= [-2.00]';
response_time=[2.420]'; %Response time measured in seconds. A negative response time can be used to represent preemptive responses and “n/a” denotes a missed response.


t = table(onset,duration,trial_type,cash_demean,control_pumps_demean,explode_demean,pumps_demean,response_time);

writetable(t,events_tsv_name,'FileType','text','Delimiter','\t');

