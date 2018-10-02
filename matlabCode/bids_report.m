function bids_report(path2BIDS, Subj, Ses, Run, ReadGZ)
%bids_report Creates a short summary of the acquisition parameters of a
% BIDS data set. This is an adaptation of the pybids report module.
%
% INPUTS:
% - BIDS: path to a valid BIDS data set. Make sure you have validated it @
% http://incf.github.io/bids-validator/
%
% - Subj: Specifies which subject(s) to take as template.
% - Ses: Specifies which session(s) to take as template. Can be a vector.
% Set to 0 to do all sessions.
% - Run: Specifies which BOLD run(s) to take as template.
%
% Unless specified the function will only read the data from the first
% subject, session, and run (for each task of BOLD). This can be an issue
% if different subjects/sessions contain very different data.
%
% - ReadGZ. If set to 1 (default) the function will try to read the *.nii.gz file to get more
% information.
%
% At this stage this function relies on some SPM functions (>= SPM12 - v7219).
%
% tested on:
% - windows 10 / matlab 2017a / SPM12 - v7219
% - on all the empty raw data files from BIDS-examples
% - on ds006 and ds114 with data from BIDS-examples
%
%
% Example
% path2BIDS = 'D:\BIDS\ds114'
% bids_report(path2BIDS)
%
%
% RG 2018-09

%TO DO
% - deal with DWI bval/bvec values not read by spm_BIDS('query')
% - write output to a txt file?
% - deal with "EEG" / "MEG"
% - deal wiht "events": compute some summary statistics as suggested in
% COBIDAS report
% - report summary statistics on participants as suggested in
% COBIDAS report
% - check if all subjects have the same content?
% - adapts for several Subjects? Runs?
% - take care of other recommended metafield in BIDS specs or COBIDAS?

% check inputs
if nargin<1
    error('Point me to a folder containing valid BIDS dataset.')
end
if nargin<2 || isempty(Subj)
    Subj=1;
end
if nargin<3 || isempty(Ses)
    Ses=1;
end
if nargin<4
    Run=1;
end
if nargin<5
    ReadGZ=1;
end


% Check if we have SPM and the spm_BIDS in the path.
msg_1 = which('spm.m');
if isempty(msg_1)
    warning('SPM is not in the matlab path: this might not work.')
end

msg_2 = which('spm_BIDS.m');
if isempty(msg_2) || strcmp("'spm_BIDS.m' not found.'",msg_2)
    warning('spm_BIDS.m is not in the matlab path: this might not work.')
end
clear msg_1 msg_2


% read the content of the folder
fprintf('\n-------------------------\n')
fprintf('  Reading BIDS: %s', path2BIDS)
fprintf('\n-------------------------\n')
BIDS = spm_BIDS(path2BIDS);
fprintf('Done.\n\n')


subjs_ls = spm_BIDS(BIDS,'subjects');
sess_ls = spm_BIDS(BIDS,'sessions', 'sub', subjs_ls(Subj));
if Ses==0
    Ses = 1:numel(sess_ls);
end

%% Scanner details

%     out_str = ('MR data were acquired using a {tesla}-Tesla {manu} {model} MRI '
%                'scanner.')

% Loop through all the required sessions
for iSess = Ses
    
    if numel(Ses)~=1 && ~strcmp(sess_ls{iSess}, '')
        fprintf('\n-------------------------\n')
        fprintf('  Working on session: %s', sess_ls{iSess})
        fprintf('\n-------------------------\n')
    end
    
    types_ls = spm_BIDS(BIDS,'types', 'sub', subjs_ls(Subj), 'ses', sess_ls(iSess));
    tasks_ls = spm_BIDS(BIDS,'tasks', 'sub', subjs_ls(Subj), 'ses', sess_ls(iSess));
    
    % mods_ls = spm_BIDS(BIDS,'modalities');
    
    for iType = 1:numel(types_ls)
        
        switch types_ls{iType}
            
            case {'T1w' 'inplaneT2' 'T1map' 'FLASH'}
                
                %% Anatomical
                fprintf('Working on anat...\n')
                
                % anat text template
                anat_text = cat(2, ...
                    '%s %s %s structural MRI data were collected (%s slices; \n', ...
                    'repetition time, TR= %s ms; echo time, TE= %s ms; flip angle, FA=%s deg; \n', ...
                    'field of view, FOV= %s mm; matrix size= %s; voxel size= %s mm) \n\n');
                
                % get the parameters
                acq_param = get_acq_param(BIDS, subjs_ls{Subj}, sess_ls{iSess}, ...
                    types_ls{iType}, '', '', ReadGZ);
                
                % print output
                fprintf('\n ANAT REPORT \n')
                fprintf(anat_text,...
                    acq_param.type, acq_param.variants, acq_param.seqs, ...
                    acq_param.n_slices, acq_param.tr, ...
                    acq_param.te, acq_param.fa, ...
                    acq_param.fov, acq_param.ms, acq_param.vs);
                fprintf('\n')
                
                
            case 'bold'
                %% Functional
                fprintf('Working on func...\n')
                
                % func text template
                func_text = cat(2, ...
                    '%s run(s) of %s %s %s fMRI data were collected (%s slices acquired in a %s fashion; repetition time, TR= %s ms; \n', ...
                    'echo time, TE= %s ms; flip angle, FA= %s deg; field of view, FOV= %s mm; matrix size= %s; \n', ...
                    'voxel size= %s mm; multiband factor= %s; in-plane acceleration factor= %s). Each run was %s minutes in length, during which \n', ...
                    '%s functional volumes were acquired. \n\n');
                
                % loop through the tasks
                for iTask = 1:numel(tasks_ls)
                    
                    runs_ls = spm_BIDS(BIDS,'runs','sub', subjs_ls{Subj}, 'ses', sess_ls{iSess}, ...
                        'type', 'bold', 'task', tasks_ls{iTask});
                    
                    if isempty(runs_ls)
                        % get the parameters for that task
                        acq_param = get_acq_param(BIDS, subjs_ls{Subj}, sess_ls{iSess}, ...
                            'bold', tasks_ls{iTask}, '', ReadGZ);
                        % compute the number of BOLD run for that task
                        acq_param.run_str = '1';
                    else
                        % get the parameters for that task
                        acq_param = get_acq_param(BIDS, subjs_ls{Subj}, sess_ls{iSess}, ...
                            'bold', tasks_ls{iTask}, runs_ls{Run}, ReadGZ);
                        % compute the number of BOLD run for that task
                        acq_param.run_str = num2str(numel(runs_ls));
                    end
                    
                    % set run duration
                    if ~strcmp(acq_param.tr,'[XXXX]') && ~strcmp(acq_param.n_vols,'[XXXX]')
                        acq_param.length = num2str(str2double(acq_param.tr)/1000 * str2double(acq_param.n_vols) / 60);
                    end
                    
                    % print output
                    fprintf('\n FUNC REPORT \n')
                    fprintf(func_text,...
                        acq_param.run_str, acq_param.task, acq_param.variants, acq_param.seqs, ...
                        acq_param.n_slices, acq_param.so_str, acq_param.tr, ...
                        acq_param.te, acq_param.fa, ...
                        acq_param.fov, acq_param.ms, ...
                        acq_param.vs, acq_param.mb_str, acq_param.pr_str, ...
                        acq_param.length, ...
                        acq_param.n_vols);
                    fprintf('\n\n')
                end
                
                
            case 'phasediff'
                %% Fieldmap
                fprintf('Working on fmap...\n')
                
                % func text template
                fmap_text = cat(2, ...
                    'A %s %s field map (phase encoding: %s; %s slices; repetition time, TR= %s ms; \n',...
                    'echo time 1 / 2, TE 1/2= %s ms; flip angle, FA= %s deg; field of view, FOV= %s mm; matrix size= %s; \n',...
                    'voxel size= %s mm) was acquired %s. \n\n');
                
                % loop through the tasks
                for iTask = 1:numel(tasks_ls)
                    
                    runs_ls = spm_BIDS(BIDS,'runs','sub', subjs_ls{Subj}, 'ses', sess_ls{iSess}, ...
                        'type', 'phasediff');
                    
                    if isempty(runs_ls)
                        % get the parameters for that task
                        acq_param = get_acq_param(BIDS, subjs_ls{Subj}, sess_ls{iSess}, ...
                            'phasediff', '', '', ReadGZ);
                    else
                        % get the parameters for that task
                        acq_param = get_acq_param(BIDS, subjs_ls{Subj}, sess_ls{iSess}, ...
                            'phasediff', '', runs_ls{Run}, ReadGZ);
                    end
                    
                    % goes through task list to check which fieldmap is for which
                    % run
                    acq_param.for = [];
                    nb_run = [];
                    nb_run(iTask) = sum( ~cellfun('isempty', ...
                        strfind(acq_param.for_str,tasks_ls{iTask},'ForceCellOutput',1) ) ); %#ok<AGROW>
                    acq_param.for = sprintf('for %i runs of %s, ', nb_run, tasks_ls{iTask});
                    
                    % print output
                    fprintf('\n FMAP REPORT \n')
                    fprintf(fmap_text,...
                        acq_param.variants, acq_param.seqs, acq_param.phs_enc_dir, acq_param.n_slices, acq_param.tr, ...
                        acq_param.te, acq_param.fa, acq_param.fov, acq_param.ms, ...
                        acq_param.vs, acq_param.for);
                    fprintf('\n\n')
                    
                end
                
                
                
            case 'dwi'
                %% DWI
                fprintf('Working on dwi...\n')
                
                % func text template
                fmap_text = cat(2, ...
                    'One run of %s %s diffusion-weighted (dMRI) data were collected (%s  slices %s ; repetition time, TR= %s ms \n', ...
                    'echo time, TE= %s ms; flip angle, FA= %s deg; field of view, FOV= %s mm; matrix size= %s ; voxel size= %s mm \n', ...
                    'b-values of %s acquired; %s diffusion directions; multiband factor= %s ). \n\n');
                
                % get the parameters
                acq_param = get_acq_param(BIDS, subjs_ls{Subj}, sess_ls{iSess}, ...
                    'dwi', '', '', ReadGZ);
                
                % dirty hack to try to look into the BIDS structure as spm_BIDS does not
                % support querying directly for bval anb bvec
                try
                    acq_param.n_vecs = num2str(size(BIDS.subjects(Subj).dwi.bval,2));
                    %             acq_param.bval_str = ???
                catch
                    warning('Could not read the bval & bvec values.')
                end
                
                % print output
                fprintf('\n DWI REPORT \n')
                fprintf(fmap_text,...
                    acq_param.variants, acq_param.seqs, acq_param.n_slices, acq_param.so_str, acq_param.tr,...
                    acq_param.te, acq_param.fa, acq_param.fov, acq_param.ms, acq_param.vs, ...
                    acq_param.bval_str, acq_param.n_vecs, acq_param.mb_str);
                fprintf('\n\n')
                
                
            case 'physio'
                warning('physio not supported yet')
            case {'headshape' 'meg' 'eeg' 'channels'}
                warning('MEEG not supported yet')
            case 'events'
                warning('events not supported yet')
        end
        
    end
    
end

end


function acq_param = get_acq_param(BIDS, subj, sess, type, task, run, ReadGZ)
% Will get info from acquisition parameters from the BIDS structure or from
% the *.nii.gz file


%% to return dummy values in case nothing was specified
acq_param.type = type;
acq_param.variants = '[XXXX]';
acq_param.seqs = '[XXXX]';

acq_param.tr = '[XXXX]';
acq_param.te = '[XXXX]';
acq_param.fa = '[XXXX]';

acq_param.task  = task;

acq_param.run_str  = '[XXXX]'; % number of runs (dealt with outside this function but initialized here
acq_param.so_str  = '[XXXX]'; % slice order string
acq_param.mb_str  = '[XXXX]'; % multiband
acq_param.pr_str  = '[XXXX]'; % parallel imaging
acq_param.length  = '[XXXX]';

acq_param.for_str = '[XXXX]'; % for fmap: for which run this fmap is for.
acq_param.phs_enc_dir = '[XXXX]'; % phase encoding direction.

acq_param.bval_str = '[XXXX]';
acq_param.n_vecs = '[XXXX]';

acq_param.fov = '[XXXX]';
acq_param.n_slices = '[XXXX]';
acq_param.ms = '[XXXX]'; % matrix size
acq_param.vs = '[XXXX]'; % voxel size
acq_param.n_vols  = '[XXXX]';


%% look into the metadata sub-structure for BOLD data
if ismember(type, {'T1w' 'inplaneT2' 'T1map' 'FLASH' 'dwi'})
    
    filename = spm_BIDS(BIDS, 'data', 'sub', subj, 'ses', sess, 'type', type);
    metadata = spm_BIDS(BIDS, 'metadata', 'sub', subj, 'ses', sess, 'type', type);
    
elseif strcmp(type, 'bold')
    
    filename = spm_BIDS(BIDS, 'data', 'sub', subj, 'ses', sess, 'type', type, ...
        'task', task, 'run', run);
    metadata = spm_BIDS(BIDS, 'metadata', 'sub', subj, 'ses', sess, 'type', type, ...
        'task', task, 'run', run);
    
elseif strcmp(type, 'phasediff')
    
    filename = spm_BIDS(BIDS, 'data', 'sub', subj, 'ses', sess, 'type', type, 'run', run);
    metadata = spm_BIDS(BIDS, 'metadata', 'sub', subj, 'ses', sess, 'type', type, 'run', run);
    
end

fprintf(' - %s\n', filename{1})

if isfield(metadata, 'EchoTime')
    acq_param.te = num2str(metadata.EchoTime*1000);
elseif isfield(metadata, 'EchoTime1') && isfield(metadata, 'EchoTime2')
    acq_param.te = [num2str(metadata.EchoTime1*1000) ' / '  num2str(metadata.EchoTime2*1000)];
end

if isfield(metadata, 'RepetitionTime')
    acq_param.tr = num2str(metadata.RepetitionTime*1000);
end

if isfield(metadata, 'FlipAngle')
    acq_param.fa = num2str(metadata.FlipAngle);
end

if isfield(metadata, 'SliceTiming')
    acq_param.so_str = define_slice_timing(metadata.SliceTiming);
end

if isfield(metadata, 'PhaseEncodingDirection')
    acq_param.phs_enc_dir = metadata.PhaseEncodingDirection;
end

if isfield(metadata, 'IntendedFor')
    acq_param.for_str = metadata.IntendedFor;
end

%% try to read the relevant .nii.gz file to get more info from it
if ReadGZ
    fprintf('  Opening file %s.\n',filename{1})
    
    try
        % read the header of the nifti file
        hdr = spm_vol(filename{1});
        acq_param.n_vols  = num2str(numel(hdr)); % nb volumes
        
        hdr = hdr(1);
        dim = abs(hdr.dim);
        acq_param.n_slices = sprintf('%i', dim(3)); % nb slices
        acq_param.ms = sprintf('%i X %i', dim(1), dim(2)); %matrix size
        
        vs = abs(diag(hdr.mat));
        acq_param.vs = sprintf('%.2f X %.2f X %.2f', vs(1), vs(2), vs(3)); % voxel size
        
        acq_param.fov = sprintf('%.2f X %.2f', vs(1)*dim(1), vs(2)*dim(2)); % field of view
        
    catch
        warning('Could not read the file %s.', filename{1})
    end
end


end


function ST_def = define_slice_timing(SliceTiming)
% tries to figure out the ways the slices were acquired from their timing
if iscell(SliceTiming)
    SliceTiming = cell2mat(SliceTiming);
end
[~,I] = sort(SliceTiming);
if all(I==(1:numel(I))')
    ST_def = 'ascending';
elseif all(I==(numel(I):-1:1)')
    ST_def = 'descending';
elseif I(1)<I(2)
    ST_def = 'interleaved ascending';
elseif I(1)>I(2)
    ST_def = 'interleaved descending';
else
    ST_def = '????';
end
end