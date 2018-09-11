function varargout = spm_BIDS(varargin)
% Parse directory structure formated according to the BIDS standard
% FORMAT BIDS = spm_BIDS(root)
% root   - directory formated according to BIDS [Default: pwd]
% BIDS   - structure containing the BIDS file layout
%
% FORMAT result = spm_BIDS(BIDS,query,...)
% BIDS   - BIDS directory name or structure containing the BIDS file layout
% query  - type of query
% result - query's result
%__________________________________________________________________________
%
% BIDS (Brain Imaging Data Structure): http://bids.neuroimaging.io/
%   The brain imaging data structure, a format for organizing and
%   describing outputs of neuroimaging experiments.
%   K. J. Gorgolewski et al, Scientific Data, 2016.
%__________________________________________________________________________
% Copyright (C) 2016-2017 Wellcome Trust Centre for Neuroimaging

% Guillaume Flandin
% $Id: spm_BIDS.m 7120 2017-06-20 11:30:30Z spm $


%-Validate input arguments
%==========================================================================
if ~nargin
    root = pwd;
elseif nargin == 1
    if ischar(varargin{1})
        root = spm_select('CPath',varargin{1});
    else
        varargout = varargin(1);
        return;
    end
else
    BIDS = spm_BIDS(varargin{1});
    varargout{1} = BIDS_query(BIDS,varargin{2:end});
    return;
end

%-BIDS structure
%==========================================================================

BIDS = struct(...
    'dir',root, ...               % BIDS directory
    'description',struct([]), ... % content of dataset_description.json
    'sessions',{{}},...           % cellstr of sessions
    'scans',struct([]),...        % content of sub-<participant_label>_scans.tsv (should go within subjects)
    'sess',struct([]),...         % content of sub-participants_label>_sessions.tsv (should go within subjects)
    'participants',struct([]),... % content of participants.tsv
    'subjects',struct([]));       % structure array of subjects

%-Validation of BIDS root directory
%==========================================================================
if isempty(BIDS.dir)
    error('A BIDS directory has to be specified.');
elseif ~exist(BIDS.dir,'dir')
    error('BIDS directory does not exist.');
elseif ~exist(fullfile(BIDS.dir,'dataset_description.json'),'file')
    error('BIDS directory not valid: missing dataset_description.json.');
end

%-Dataset description
%==========================================================================
try
    BIDS.description = spm_jsonread(fullfile(BIDS.dir,'dataset_description.json'));
catch
    error('BIDS dataset description could not be read.');
end
if ~isfield(BIDS.description,'BIDSVersion') || ~isfield(BIDS.description,'Name')
    error('BIDS dataset description not valid.');
end
% See also optional README and CHANGES files

%-Optional directories
%==========================================================================
% [code/]
% [derivatives/]
% [stimuli/]
% [sourcedata/]
% [phenotype]

%-Scans key file
%==========================================================================

% sub-<participant_label>/[ses-<session_label>/]
%     sub-<participant_label>_scans.tsv

%-Participant key file
%==========================================================================
p = spm_select('FPList',BIDS.dir,'^participants\.tsv$');
if ~isempty(p)
    BIDS.participants = spm_load(p);
end
p = spm_select('FPList',BIDS.dir,'^participants\.json$');
if ~isempty(p)
    BIDS.participants.meta = spm_jsonread(p);
end

%-Sessions file
%==========================================================================

% sub-<participant_label>/[ses-<session_label>/]
%      sub-<participant_label>[_ses-<session_label>]_sessions.tsv

%-Tasks: JSON files are accessed through metadata
%==========================================================================
%t = spm_select('FPList',BIDS.dir,...
%    '^task-.*_(beh|bold|events|channels|physio|stim|meg)\.(json|tsv)$');

%-Subjects
%==========================================================================
sub = cellstr(spm_select('List',BIDS.dir,'dir','^sub-.*$'));
if isequal(sub,{''})
    error('No subjects found in BIDS directory.');
end

for su=1:numel(sub)
    sess = cellstr(spm_select('List',fullfile(BIDS.dir,sub{su}),'dir','^ses-.*$'));    
    for se=1:numel(sess)
        if isempty(BIDS.subjects)
            BIDS.subjects = parse_subject(BIDS.dir, sub{su}, sess{se});
        else
            BIDS.subjects(end+1) = parse_subject(BIDS.dir, sub{su}, sess{se});
        end
    end
end

varargout = { BIDS };


%==========================================================================
%-Parse a subject's directory
%==========================================================================
function subject = parse_subject(p, subjname, sesname)

subject.name = subjname;   % subject name ('sub-<participant_label>')
subject.path = fullfile(p,subjname,sesname); % full path to subject directory
subject.session = sesname; % session name ('' or 'ses-<label>')
subject.anat = struct([]); % anatomy imaging data
subject.func = struct([]); % task imaging data
subject.fmap = struct([]); % fieldmap data
subject.beh = struct([]);  % behavioral experiment data
subject.dwi = struct([]);  % diffusion imaging data
subject.meg = struct([]);  % MEG data
subject.pet = struct([]);  % PET imaging data


%--------------------------------------------------------------------------
%-Anatomy imaging data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'anat');
if exist(pth,'dir')
    f = spm_select('List',pth,...
        sprintf('^%s.*_([a-zA-Z0-9]+){1}\\.nii(\\.gz)?$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        %-Anatomy imaging data file
        %------------------------------------------------------------------
        p = parse_filename(f{i}, {'sub','ses','acq','ce','rec','fa','echo','inv','run'});
        subject.anat = [subject.anat p];
        
    end
end

%--------------------------------------------------------------------------
%-Task imaging data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'func');
if exist(pth,'dir')
    
    %-Task imaging data file
    %----------------------------------------------------------------------
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_bold\\.nii(\\.gz)?$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','acq','rec','fa','echo','inv','run','recording', 'meta'});
        subject.func = [subject.func p];
        subject.func(end).meta = struct([]); % ?
        
    end
    
    %-Task events file
    %----------------------------------------------------------------------
    % (!) TODO: events file can also be stored at higher levels (inheritance principle)
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_events\\.tsv$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','acq','rec','fa','echo','inv','run','recording', 'meta'});
        subject.func = [subject.func p];
        subject.func(end).meta = spm_load(fullfile(pth,f{i})); % ?

    end
        
    %-Physiological and other continuous recordings file
    %----------------------------------------------------------------------
    % (!) TODO: stim file can also be stored at higher levels (inheritance principle)
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_(physio|stim)\\.tsv\\.gz$',subject.name));
    % see also [_recording-<label>]
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','acq','rec','fa','echo','inv','run','recording', 'meta'});
        subject.func = [subject.func p];
        subject.func(end).meta = struct([]); % ?
         
    end
end

%--------------------------------------------------------------------------
%-Fieldmap data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'fmap');
if exist(pth,'dir')
    f = spm_select('List',pth,...
        sprintf('^%s.*\\.nii(\\.gz)?$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    j = 1;

    %-Phase difference image and at least one magnitude image
    %----------------------------------------------------------------------
    labels = regexp(f,[...
        '^sub-[a-zA-Z0-9]+' ...              % sub-<participant_label>
        '(?<ses>_ses-[a-zA-Z0-9]+)?' ...     % ses-<label>
        '(?<acq>_acq-[a-zA-Z0-9]+)?' ...     % acq-<label>
        '(?<run>_run-[a-zA-Z0-9]+)?' ...     % run-<index>
        '_phasediff\.nii(\.gz)?$'],'names'); % NIfTI file extension
    if any(~cellfun(@isempty,labels))
        idx = find(~cellfun(@isempty,labels));
        for i=1:numel(idx)
            fb = spm_file(spm_file(f{idx(i)},'basename'),'basename');
            metafile = fullfile(pth,spm_file(fb,'ext','json'));
            subject.fmap(j).type = 'phasediff';
            subject.fmap(j).filename = f{idx(i)};
            subject.fmap(j).magnitude = {...
                strrep(f{idx(i)},'_phasediff.nii','_magnitude1.nii'),...
                strrep(f{idx(i)},'_phasediff.nii','_magnitude2.nii')}; % optional
            subject.fmap(j).ses = regexprep(labels{idx(i)}.ses,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).acq = regexprep(labels{idx(i)}.acq,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).run = regexprep(labels{idx(i)}.run,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).meta = spm_jsonread(metafile);
            j = j + 1;
        end
    end

    %-Two phase images and two magnitude images
    %----------------------------------------------------------------------
    labels = regexp(f,[...
        '^sub-[a-zA-Z0-9]+' ...           % sub-<participant_label>
        '(?<ses>_ses-[a-zA-Z0-9]+)?' ...  % ses-<label>
        '(?<acq>_acq-[a-zA-Z0-9]+)?' ...  % acq-<label>
        '(?<run>_run-[a-zA-Z0-9]+)?' ...  % run-<index>
        '_phase1\.nii(\.gz)?$'],'names'); % NIfTI file extension
    if any(~cellfun(@isempty,labels))
        idx = find(~cellfun(@isempty,labels));
        for i=1:numel(idx)
            fb = spm_file(spm_file(f{idx(i)},'basename'),'basename');
            metafile = fullfile(pth,spm_file(fb,'ext','json'));
            subject.fmap(j).type = 'phase12';
            subject.fmap(j).filename = {...
                f{idx(i)},...
                strrep(f{idx(i)},'_phase1.nii','_phase2.nii')};
            subject.fmap(j).magnitude = {...
                strrep(f{idx(i)},'_phase1.nii','_magnitude1.nii'),...
                strrep(f{idx(i)},'_phase1.nii','_magnitude2.nii')};
            subject.fmap(j).ses = regexprep(labels{idx(i)}.ses,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).acq = regexprep(labels{idx(i)}.acq,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).run = regexprep(labels{idx(i)}.run,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).meta = {...
                spm_jsonread(metafile),...
                spm_jsonread(strrep(metafile,'_phase1.json','_phase2.json'))};
            j = j + 1;
        end
    end

    %-A single, real fieldmap image
    %----------------------------------------------------------------------
    labels = regexp(f,[...
        '^sub-[a-zA-Z0-9]+' ...             % sub-<participant_label>
        '(?<ses>_ses-[a-zA-Z0-9]+)?' ...    % ses-<label>
        '(?<acq>_acq-[a-zA-Z0-9]+)?' ...    % acq-<label>
        '(?<run>_run-[a-zA-Z0-9]+)?' ...    % run-<index>
        '_fieldmap\.nii(\.gz)?$'],'names'); % NIfTI file extension
    if any(~cellfun(@isempty,labels))
        idx = find(~cellfun(@isempty,labels));
        for i=1:numel(idx)
            fb = spm_file(spm_file(f{idx(i)},'basename'),'basename');
            metafile = fullfile(pth,spm_file(fb,'ext','json'));
            subject.fmap(j).type = 'fieldmap';
            subject.fmap(j).filename = f{idx(i)};
            subject.fmap(j).magnitude = strrep(f{idx(i)},'_fieldmap.nii','_magnitude.nii');
            subject.fmap(j).ses = regexprep(labels{idx(i)}.ses,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).acq = regexprep(labels{idx(i)}.acq,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).run = regexprep(labels{idx(i)}.run,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).meta = spm_jsonread(metafile);
            j = j + 1;
        end
    end

    %-Multiple phase encoded directions (topup)
    %----------------------------------------------------------------------
    labels = regexp(f,[...
        '^sub-[a-zA-Z0-9]+' ...          % sub-<participant_label>
        '(?<ses>_ses-[a-zA-Z0-9]+)?' ... % ses-<label>
        '(?<acq>_acq-[a-zA-Z0-9]+)?' ... % acq-<label>
        '_dir-(?<dir>[a-zA-Z0-9]+)?' ... % dir-<index>
        '(?<run>_run-[a-zA-Z0-9]+)?' ... % run-<index>
        '_epi\.nii(\.gz)?$'],'names');   % NIfTI file extension
    if any(~cellfun(@isempty,labels))
        idx = find(~cellfun(@isempty,labels));
        for i=1:numel(idx)
            fb = spm_file(spm_file(f{idx(i)},'basename'),'basename');
            metafile = fullfile(pth,spm_file(fb,'ext','json'));
            subject.fmap(j).type = 'epi';
            subject.fmap(j).filename = f{idx(i)};
            subject.fmap(j).ses = regexprep(labels{idx(i)}.ses,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).acq = regexprep(labels{idx(i)}.acq,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).dir = labels{idx(i)}.dir;
            subject.fmap(j).run = regexprep(labels{idx(i)}.run,'^_[a-zA-Z0-9]+-','');
            subject.fmap(j).meta = spm_jsonread(metafile);
            j = j + 1;
        end
    end
end

%--------------------------------------------------------------------------
%-MEG data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'meg');
if exist(pth,'dir')
    
    %-MEG data file
    %----------------------------------------------------------------------
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_meg\\..*[^json]$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','run','proc', 'meta'});
        subject.meg = [subject.meg p];
        subject.meg(end).meta = struct(); % ?
        
    end
    
    %-MEG events file
    %----------------------------------------------------------------------
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_events\\.tsv$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','run','proc', 'meta'});
        subject.meg = [subject.meg p];
        subject.meg(end).meta = spm_load(fullfile(pth,f{i})); % ?
        
    end
        
    %-Channel description table
    %----------------------------------------------------------------------
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_channels\\.tsv$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','run','proc', 'meta'});
        subject.meg = [subject.meg p];
        subject.meg(end).meta = spm_load(fullfile(pth,f{i})); % ?
        
    end

    %-Session-specific file
    %----------------------------------------------------------------------
    f = spm_select('List',pth,...
        sprintf('^%s(_ses-[a-zA-Z0-9]+)?.*_(photo\\.jpg|fid\\.json|fidinfo\\.txt|headshape\\..*)$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        p = parse_filename(f{i}, {'sub','ses','task','run','proc', 'meta'});
        subject.meg = [subject.meg p];
        subject.meg(end).meta = struct(); % ?
        
    end

end

%--------------------------------------------------------------------------
%-Behavioral experiments data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'beh');
if exist(pth,'dir')
    f = spm_select('FPList',pth,...
        sprintf('^%s.*_(events\\.tsv|beh\\.json|physio\\.tsv\\.gz|stim\\.tsv\\.gz)$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        %-Event timing, metadata, physiological and other continuous
        % recordings
        %------------------------------------------------------------------
        p = parse_filename(f{i}, {'sub','ses','task'});
        subject.beh = [subject.beh p];
        
    end
end

%--------------------------------------------------------------------------
%-Diffusion imaging data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'dwi');
if exist(pth,'dir')
    f = spm_select('FPList',pth,...
        sprintf('^%s.*_([a-zA-Z0-9]+){1}\\.nii(\\.gz)?$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)

        %-Diffusion imaging file
        %------------------------------------------------------------------
        p = parse_filename(f{i}, {'sub','ses','acq','run', 'bval','bvec'});
        subject.dwi = [subject.dwi p];

        %-bval file
        %------------------------------------------------------------------
        bvalfile = get_metadata(f{i},'^.*%s\\.bval$');
        if isfield(bvalfile,'filename')
            subject.dwi(end).bval = spm_load(bvalfile.filename); % ?
        end

        %-bvec file
        %------------------------------------------------------------------
        bvecfile = get_metadata(f{i},'^.*%s\\.bvec$');
        if isfield(bvalfile,'filename')
            subject.dwi(end).bvec = spm_load(bvecfile.filename); % ?
        end
        
    end
end


%--------------------------------------------------------------------------
%-Positron Emission Tomography imaging data
%--------------------------------------------------------------------------
pth = fullfile(subject.path,'pet');
if exist(pth,'dir')
    f = spm_select('List',pth,...
        sprintf('^%s.*_task-.*_pet\\.nii(\\.gz)?$',subject.name));
    if isempty(f), f = {}; else f = cellstr(f); end
    for i=1:numel(f)
        
        %-PET imaging file
        %------------------------------------------------------------------
        p = parse_filename(f{i}, {'sub','ses','task','acq','rec','run'});
        subject.pet = [subject.pet p];
        
    end
end


%==========================================================================
%-Perform a BIDS query
%==========================================================================
function result = BIDS_query(BIDS,query,varargin)
opts = parse_query(varargin);
switch query
%   case 'subjects'
%       result = regexprep(unique({BIDS.subjects.name}),'^[a-zA-Z0-9]+-','');
    case 'sessions'
        result = unique({BIDS.subjects.session});
        result = regexprep(result,'^[a-zA-Z0-9]+-','');
    case 'modalities'
        hasmod = arrayfun(@(y) structfun(@(x) isstruct(x) & ~isempty(x),y),...
            BIDS.subjects,'UniformOutput',false);
        hasmod = any([hasmod{:}],2);
        mods   = fieldnames(BIDS.subjects)';
        result = mods(hasmod);
    case {'subjects', 'tasks', 'runs', 'types', 'data', 'metadata'}
        %-Initialise output variable
        result = {};
        %-Filter according to subjects
        if any(ismember(opts(:,1),'sub'))
            subs = opts{ismember(opts(:,1),'sub'),2};
            opts(ismember(opts(:,1),'sub'),:) = [];
        else
            subs = unique({BIDS.subjects.name});
            subs = regexprep(subs,'^[a-zA-Z0-9]+-','');
        end
        %-Filter according to modality
        if any(ismember(opts(:,1),'modality'))
            mods = opts{ismember(opts(:,1),'modality'),2};
            opts(ismember(opts(:,1),'modality'),:) = [];
        else
            mods = BIDS_query(BIDS,'modalities');
        end
        %-Get optional target option for metadata query
        if strcmp(query,'metadata') && any(ismember(opts(:,1),'target'))
            target = opts{ismember(opts(:,1),'target'),2};
            opts(ismember(opts(:,1),'target'),:) = [];
            if iscellstr(target)
                target = substruct('.',target{1});
            end
        else
            target = [];
        end
        %-Perform query
        for i=1:numel(BIDS.subjects)                    
            if ~ismember(BIDS.subjects(i).name(5:end),subs), continue; end
            for j=1:numel(mods)
                d = BIDS.subjects(i).(mods{j});
                for k=1:numel(d)
                    sts = true;
                    for l=1:size(opts,1)
                        if ~isfield(d(k),opts{l,1}) || ~ismember(d(k).(opts{l,1}),opts{l,2})
                            sts = false;
                        end
                    end
                    switch query
                        case 'subjects'
                            if sts
                                result{end+1} = BIDS.subjects(i).name;
                            end
                        case 'data'
                            if sts && isfield(d(k),'filename')
                                result{end+1} = fullfile(BIDS.subjects(i).path,mods{j},d(k).filename);
                            end
                        case 'metadata'
                            if sts && isfield(d(k),'filename')
                                f = fullfile(BIDS.subjects(i).path,mods{j},d(k).filename);
                                result{end+1} = get_metadata(f);
                                if ~isempty(target)
                                    try
                                        result{end} = subsref(result{end},target);
                                    catch
                                        warning('Non-existent field for metadata.');
                                        result{end} = [];
                                    end
                                end
                            end
%                             if sts && isfield(d(k),'meta')
%                                 result{end+1} = d(k).meta;
%                             end
                        case 'runs'
                            if sts && isfield(d(k),'run')
                                result{end+1} = d(k).run;
                            end
                        case 'tasks'
                            if sts && isfield(d(k),'task')
                                result{end+1} = d(k).task;
                            end
                        case 'types'
                            if sts && isfield(d(k),'type')
                                result{end+1} = d(k).type;
                            end
                    end
                end
            end
        end
        %-Postprocessing output variable
        switch query
            case 'subjects'
                result = unique(result);
                result = regexprep(result,'^[a-zA-Z0-9]+-','');
            case 'data'
                result = result';
            case 'metadata'
                if numel(result) == 1
                    result = result{1};
                end
            case {'tasks','runs','types'}
                result = unique(result);
                result(cellfun('isempty',result)) = [];
        end
    otherwise
        error('Unable to perform BIDS query.');
end


%==========================================================================
%-Parse BIDS query
%==========================================================================
function query = parse_query(query)
if numel(query) == 1 && isstruct(query{1})
    query = [fieldnames(query{1}), struct2cell(query{1})];
else
    if mod(numel(query),2)
        error('Invalid input syntax.');
    end
    query = reshape(query,2,[])';
end
for i=1:size(query,1)
    if ischar(query{i,2})
        query{i,2} = cellstr(query{i,2});
    end
    for j=1:numel(query{i,2})
        if iscellstr(query{i,2})
            query{i,2}{j} = regexprep(query{i,2}{j},sprintf('^%s-',query{i,1}),'');
        end
    end
end


%==========================================================================
%-Parse filename
%==========================================================================
function p = parse_filename(filename,fields)
filename = spm_file(filename,'filename');
[parts, dummy] = regexp(filename,'(?:_)+','split','match');
p.filename = filename;
[p.type, p.ext] = strtok(parts{end},'.');
for i=1:numel(parts)-1
    [d, dummy] = regexp(parts{i},'(?:\-)+','split','match');
    p.(d{1}) = d{2};
end
if nargin == 2
    for i=1:numel(fields)
        if ~isfield(p,fields{i})
            p.(fields{i}) = '';
        end
    end
    try
        p = orderfields(p,['filename','ext','type',fields]);
    catch
        warning('Ignoring file "%s" not matching template.',filename);
        p = struct([]);
    end
end


%==========================================================================
%-Get metadata
%==========================================================================
function meta = get_metadata(filename, pattern)
if nargin == 1, pattern = '^.*_%s\\.json$'; end
pth = fileparts(filename);
p = parse_filename(filename);

meta = struct();

if isfield(p,'ses') && ~isempty(p.ses)
    N = 4; % there is a session level in the hierarchy
else
    N = 3;
end
    
for n=1:N
    metafile = spm_select('FPList',pth, sprintf(pattern,p.type));
    if isempty(metafile), metafile = {}; else metafile = cellstr(metafile); end
    for i=1:numel(metafile)
        p2 = parse_filename(metafile{i});
        fn = setdiff(fieldnames(p2),{'filename','ext','type'});
        ismeta = true;
        for j=1:numel(fn)
            if ~isfield(p,fn{j}) || ~strcmp(p.(fn{j}),p2.(fn{j}))
                ismeta = false;
                break;
            end
        end
        if ismeta
            if strcmp(p2.ext,'.json')
                meta = update_metadata(meta,spm_jsonread(metafile{i}));
            else
                meta.filename = metafile{i};
            end
        end
    end
    pth = fullfile(pth,'..');
end


%==========================================================================
%-Inheritance principle
%==========================================================================
function s1 = update_metadata(s1,s2)
fn = fieldnames(s2);
for i=1:numel(fn)
    if ~isfield(s1,fn{i})
        s1.(fn{i}) = s2.(fn{i});
    end
end