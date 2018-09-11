function [ output_args ] = bids_report(path2BIDS, Subj, Ses, Run, ReadGZ)
%bids_report Creates a short summary of the acquisition parameters of a
% BIDS data set. This is an adaptation of the pybids report module.
%
% INPUTS:
% - BIDS: path to a valid BIDS data set. Make sure you have validated it @
% http://incf.github.io/bids-validator/
%
% - Subj: Specifies which subject to take as template.
% - Ses: Specifies which session to take as template.
% - Run: Specifies which BOLD run to take as template.
% Unless specified the function will only read the data from the first
% subject, session, and run (for each task of BOLD only).
% This can be an issue if different subjects/sessions contain very different data.
%
% - ReadGZ. If set to 1 (default) the function will try to read the *.nii.gz file to get more
% information.
%
% This function relies on some SPM functions. If the relevant version of SPM
% (>= SPM12 - v7219) is not installed, the subfun folder containing the dependencies
% will be added to the matlab path.
%
% This function assumes will assume
%
%
%
% Example
% path2BIDS = 'D:\BIDS\ds114'
% bids_report(path2BIDS)

%TO DO
% - deal with fieldmaps and DWI
% - write output to a txt file
% - deal with EEG and MEG
% - check if all subjects have the same content?
% - loop through subjects?
% - adapts for several sessions?


clc

% check inputs
if nargin<1
    error('Point me to a folder containing valid BIDS dataset.')
end
if nargin<2
    Subj=1;
end
if nargin<3
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
    warning('Adding missing SPM function to path.')
    addpath(genpath(fullfile(pwd,'subfun','SPM')))
end

msg_2 = which('spm_BIDS.m');
if isempty(msg_2) || strcmp("'spm_BIDS.m' not found.'",msg_2)
    warning('Adding missing spm_BIDS.m to path.')
    addpath(genpath(fullfile(pwd,'subfun','spm_BIDS')))
end
clear msg_1 msg_2


% read the content of the folder
fprintf('Reading BIDS: %s\n', path2BIDS)
BIDS = spm_BIDS(path2BIDS);
fprintf('Done.\n\n')


%% Scanner details

%     out_str = ('MR data were acquired using a {tesla}-Tesla {manu} {model} MRI '
%                'scanner.')


%% Anatomical

fprintf('Working on anat...\n')

% anat text template
anat_text = cat(2, ...
    '%s %s %s structural MRI data were collected (%s slices; \n', ...
    'repetition time, TR= %s ms; echo time, TE= %s ms; flip angle, FA=%s deg; \n', ...
    'field of view, FOV= %s mm; matrix size= %s; voxel size= %s mm) \n\n');

% loop through all the anat files
for iAnat = 1:numel(BIDS.subjects(Subj).anat)
    if ~isempty(BIDS.subjects(Subj).anat(iAnat))
        
        
        % get the parameters
        fprintf(' - %s\n', BIDS.subjects(Subj).anat(iAnat).filename)
        FP = fullfile(BIDS.subjects(Subj).path, 'anat');
        acq_param = get_acq_param(BIDS.subjects(Subj).anat(iAnat), ReadGZ, FP);
        
        
        % print output
        fprintf('\n ANAT REPORT \n')
        fprintf(anat_text,...
            acq_param.type, acq_param.variants, acq_param.seqs, ...
            acq_param.n_slices, acq_param.tr, ...
            acq_param.te, acq_param.fa, ...
            acq_param.fov, acq_param.ms, acq_param.vs);
        fprintf('\n')
    end
end


%% Functional

fprintf('Working on func...\n')

% func text template
func_text = cat(2, ...
    '%s run(s) of %s %s %s fMRI data were collected (%s slices acquired in a %s fashion; repetition time, TR= %s ms; \n', ...
    'echo time, TE= %s ms; flip angle, FA= %s deg; field of view, FOV= %s mm; matrix size= %s; \n', ...
    'voxel size= %s mm; multiband factor=%s; in-plane acceleration factor=%s). Each run was %s minutes in length, during which \n', ...
    '%s functional volumes were acquired. \n\n');

% list all existing task in that data set
ls_tasks = unique({BIDS.subjects(Subj).func(:).task});

% loop through the tasks
for iFunc = 1:numel(ls_tasks)
    
    % take only files for that task
    is_task = strcmp({BIDS.subjects(Subj).func(:).task}',ls_tasks{iFunc});
    % that are BOLD
    is_type = strcmp({BIDS.subjects(Subj).func(:).type}','bold');
    % of the target session
    is_ses = strcmp({BIDS.subjects(Subj).func(:).ses}', num2str(Ses));
    if sum(is_ses) == 0
        is_ses = []; % In case no session was defined this will be ignored
    end
    % of the targer run
    is_run = str2num(char({BIDS.subjects(1).func(:).run}')) == Run;
    
    % apply AND across those
    file2choose = all([is_task is_type is_ses is_run],2);
    
    
    % get the parameters for that task
    fprintf(' - %s\n', BIDS.subjects(Subj).func(file2choose).filename)
    FP = fullfile(BIDS.subjects(Subj).path, 'func');
    acq_param = get_acq_param(BIDS.subjects(Subj).func(file2choose), ReadGZ, FP);
    
    % compute the number of BOLD run for that task
    acq_param.run_str = num2str(sum(all([is_task is_type],2)));
    
    % set run duration
    if ~strcmp(acq_param.tr,'[XXXX]') || ~strcmp(acq_param.n_vols,'[XXXX]')
        acq_param.length = num2str(str2double(acq_param.tr)*str2double(acq_param.n_vols) / 60);
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


%% Fieldmap
%            A {variants} {seqs} field map (phase encoding:
%            {dir_}; {n_slices} slices; repetition time, TR={tr}ms;
%            echo time, TE={te}ms; flip angle, FA={fa}<deg>;
%            field of view, FOV={fov}mm; matrix size={ms};
%            voxel size={vs}mm) was acquired{for_str}.


%% DWI
%
%            One run of {variants} {seqs} diffusion-weighted (dMRI) data were collected
%            ({n_slices} slices{so_str}; repetition time, TR={tr}ms;
%            echo time, TE={te}ms; flip angle, FA={fa}<deg>;
%            field of view, FOV={fov}mm; matrix size={ms}; voxel size={vs}mm;
%            b-values of {bval_str} acquired;
%            {n_vecs} diffusion directions{mb_str}).


end


function acq_param = get_acq_param(Struct, ReadGZ, FP)
% Will get info from acquisition parameters from the BIDS structure or from
% the *.nii.gz file

File2Read = fullfile(FP, Struct.filename);

% to return dummy values in case nothing was specified
acq_param.task  = '[XXXX]';
acq_param.type = '[XXXX]';
acq_param.variants = '[XXXX]';
acq_param.seqs = '[XXXX]';

acq_param.tr = '[XXXX]';
acq_param.te = '[XXXX]';
acq_param.fa = '[XXXX]';

acq_param.run_str  = '[XXXX]'; % number of runs (dealt with outside this function but initialized here
acq_param.so_str  = '[XXXX]'; % slice order string
acq_param.mb_str  = '[XXXX]'; % multiband
acq_param.pr_str  = '[XXXX]'; % parallel imaging
acq_param.length  = '[XXXX]';

acq_param.fov = '[XXXX]';
acq_param.n_slices = '[XXXX]';
acq_param.ms = '[XXXX]'; % matrix size
acq_param.vs = '[XXXX]'; % voxel size
acq_param.n_vols  = '[XXXX]';


%% list all the fields of we want to fill
fields = fieldnames(acq_param);

% loop through them and only fill them if they exist are not empty in the
% input structure
for iField=1:numel(fields)
    if isfield(Struct, fields{iField}) && ~isempty(Struct.(fields{iField}))
        if ~ischar(Struct.(fields{iField}))
            acq_param.(fields{iField}) = sprintf('%.2f', Struct.(fields{iField}) );
        else
            acq_param.(fields{iField}) = Struct.(fields{iField});
        end
    end
end


%% look into the metadata sub-structure for BOLD data
if isfield(Struct.meta, 'EchoTime')
    acq_param.te = num2str(Struct.meta.EchoTime);
end
if isfield(Struct.meta, 'RepetitionTime')
    acq_param.tr = num2str(Struct.meta.RepetitionTime*1000);
end
if isfield(Struct.meta, 'FlipAngle')
    acq_param.fa = num2str(Struct.meta.FlipAngle);
end
if isfield(Struct.meta, 'SliceTiming')
    acq_param.so_str = define_slice_timing(Struct.meta.SliceTiming);
end


%% try to read the relevant .nii.gz file to get more info from it
if ReadGZ
    fprintf('  Opening file %s.\n',File2Read)
    
    try
        
        % read the header of the nifti file
        hdr = spm_vol(File2Read);
        hdr = hdr(1);
        
        dim = hdr.dim;
        acq_param.n_slices = sprintf('%i', dim(3)); % nb slices
        acq_param.ms = sprintf('%i X %i', dim(1), dim(2)); %matrix size
        
        acq_param.n_vols  = num2str(numel(hdr)); % nb volumes
        
        vs = diag(hdr.mat);
        acq_param.vs = sprintf('%.2f X %.2f X %.2f', vs(1), vs(2), vs(3)); % voxel size
        
        acq_param.fov = sprintf('%.2f X %.2f', vs(1)*dim(1), vs(2)*dim(2)); % field of view
        
    catch
        warning('Could not read the file %s.', File2Read)
    end
end


end


function ST_def = define_slice_timing(SliceTiming)
% tries to figure out the ways the slices were acquired from their timing

SliceTiming = cell2mat(SliceTiming);
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