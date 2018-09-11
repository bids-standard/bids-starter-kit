function [ output_args ] = bids_report(path2BIDS, Subj, Ses, Run)
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
% This function relies on some SPM functions. If the relevant version of SPM
% (>= SPM12 - v7219) is not installed, the subfun folder containing the dependencies
% will be added to the matlab path.
%
% This function assumes will assume 
%
%
%
% Example
% path2BIDS = 'D:\Dropbox\GitHub\BIDS-examples\7t_trt'
% bids_report(path2BIDS)

%TO DO
% - check if all subjects have the same content?
% - loop through subjects?
% - adapts for several sessions?
% - write output to a txt file
% - deal with EEG and MEG
% - unpack *nii.gz to read image dim



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


% Check if we have SPM and the spm_BIDS in the path.
msg_1 = which('spm.m');
if isempty(msg_1)
    addpath(genpath(fullfile(pwd,'subfun','SPM')))
end

msg_2 = which('spm_BIDS.m');
if ~isempty(msg_2)
    addpath(genpath(fullfile(pwd,'subfun','spm_BIDS')))
end
clear msg_1 msg_2


% read the content of the folder
BIDS = spm_BIDS(path2BIDS);


%     out_str = ('MR data were acquired using a {tesla}-Tesla {manu} {model} MRI '
%                'scanner.')


%% Anatomical

% anat text template
anat_text = cat(2, ...
    '%s %s %s structural MRI data were collected (%s slices; \n', ...
    'repetition time, TR= %s ms; echo time, TE= %s ms; flip angle, FA=%s deg; \n', ...
    'field of view, FOV= %s mm; matrix size= %s; voxel size= %s mm) \n\n');

% loop through all the anat files
for iAnat = 1:numel(BIDS.subjects(Subj).anat)
    if ~isempty(BIDS.subjects(Subj).anat(iAnat))
        
        % get the parameters
        acq_param = get_acq_param(BIDS.subjects(Subj).anat(iAnat));
        
        % print output
        fprintf(anat_text,...
            acq_param.type, acq_param.variants, acq_param.seqs, ...
            acq_param.n_slices, acq_param.tr, ...
            acq_param.te, acq_param.fa, ...
            acq_param.fov, acq_param.ms, acq_param.vs);
    end
end


%% Functional

% func text template
func_text = cat(2, ...
    '%s run(s) of %s %s %s fMRI data were collected (%s %s; repetition time, TR= %s ms; \n', ...
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
    % of the targer run
    is_run = strcmp({BIDS.subjects(Subj).func(:).run}', num2str(Run)); 
    
    % apply AND across those
    file2choose = all([is_task is_type is_ses is_run],2); 
 
    % get the parameters for that task
    acq_param = get_acq_param(BIDS.subjects(Subj).func(file2choose));
    
    % compute the number of BOLD run for that task
    acq_param.run_str = num2str(sum(all([is_task is_type],2))); 
    
    % print output
    fprintf(func_text,...
        acq_param.run_str, acq_param.task, acq_param.variants, acq_param.seqs, ...
        acq_param.n_slices, acq_param.so_str, acq_param.tr, ...
        acq_param.te, acq_param.fa, ...
        acq_param.fov, acq_param.ms, ...
        acq_param.vs, acq_param.mb_str, acq_param.pr_str, ...
        acq_param.length, ...
        acq_param.n_vols);

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


%% Misc
%            Dicoms were converted to NIfTI-1 format{software_str}.
%            This section was (in part) generated
%            automatically using pybids ({meth_vers}).



end


function acq_param = get_acq_param(Struct)

% to return dummy values in case nothing was specified
acq_param.task  = '[XXXX]';
acq_param.type = '[XXXX]';
acq_param.variants = '[XXXX]';
acq_param.seqs = '[XXXX]';

acq_param.tr = '[XXXX]';
acq_param.te = '[XXXX]';
acq_param.fa = '[XXXX]';

acq_param.run_str  = '[XXXX]'; %Number of runs (dealt with outside this function but initialized here
acq_param.so_str  = '[XXXX]';
acq_param.mb_str  = '[XXXX]'; % multiband
acq_param.pr_str  = '[XXXX]'; % parallel imaging
acq_param.length  = '[XXXX]';

acq_param.fov = '[XXXX]';
acq_param.n_slices = '[XXXX]';
acq_param.ms = '[XXXX]'; %matrix size
acq_param.vs = '[XXXX]'; %voxel size
acq_param.n_vols  = '[XXXX]';


% list all the fields of we want to fill
fields = fieldnames(acq_param);

% loop through them and only fill them if they exist are not empty in the
% input structure
for iField=1:numel(fields)
    if isfield(Struct, fields{iField}) && ~isempty(Struct.(fields{iField}))
        if ~ischar(Struct.(fields{iField}))
            acq_param.(fields{iField}) = sprintf('3.2%f', Struct.(fields{iField}) );
        else
            acq_param.(fields{iField}) = Struct.(fields{iField});
        end
    end
end

% look into the metadata sub-structure for BOLD data
if strcmp(Struct.type, 'bold')
    if isfield(Struct.meta, 'EchoTime')
        acq_param.te = num2str(Struct.meta.EchoTime);
    end
    if isfield(Struct.meta, 'RepetitionTime')
        acq_param.tr = num2str(Struct.meta.RepetitionTime*1000);
    end
end

end