function files_out = bids_spreadsheet2participants(varargin)
    %
    % routine to takes an spreadsheet file (for example: excel) as input and export as participants.tsv
    % and participants.json
    %
    % FORMAT files_out = bids_spreadsheet2participants(file_in,'ignore','field1','field2',...)
    %
    % INPUTS if empty user is prompted:
    %
    %   - 'file_in' is the excel file, with at least the 3 BIDS mandatory fields in the 1st sheet:
    %       - participant_id,
    %       - age,
    %       - gender
    %
    %     A second sheet can be used to specify variables for the json file column format:
    %       - variable name (same as sheet 1),
    %       - description,
    %       - values (optional)
    %
    %   - 'ignore' is the key to ignore specific fields (columns) in the excel file
    %     for example: 'ignore', 'variableX', 'variableY'
    %
    %   - 'export_dir' is the directory to save output files
    %
    % OUTPUT:
    %
    %   - 'files_out' is a cell array with:
    %       - files_out{1} the full name of the particpiants.tsv
    %       - files_out{2} the full name of the particpiants.json
    %
    % EXAMPLE:
    %
    %   files_out = bids_spreadsheet2participants('D:\icpsr_subset.xlsx','ignore','EEGtesttime')
    %
    % the spreadsheet must have:
    %   worksheet 1 with data, each column has a variable name and values
    %       -- note missing values MUST be n/a or nill
    %   worksheet 2 is optional with columns variables, Description, Levels, Units to describe worksheet 1
    %   variables similar to
    % https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#participants-file
    %       -- note the order of 'Levels' names should match the order of apparition in the data
    %          to have an exact match
    %
    % Requires matlab 2018a or above
    %
    % Cyril Pernet - March 2021
    % ---------------------------------

    if verLessThan('matlab', '9.4')
        error('This function requires matlab 2018a or above.');
    end

    files_out = cell(2, 1);
    % check library
    if ~exist('jsonwrite.m', 'file')
        if exist(fullfile(fileparts(which('bids_spreadsheet2participants.m')), 'JSONio'), 'dir')
            addpath(fullfile(fileparts(which('bids_spreadsheet2participants.m')), 'JSONio'));
        else
            error(['JSONio library needed, available with EEGLAB bids-matlab-tools or', ...
                   'at https://github.com/gllmflndn/JSONio']);
        end
    end

    %% deal with input file
    if nargin == 0
        [filename, pathname] = uigetfile({'*.xlsx;*.ods;*.xls'}, 'Pick an spreadsheet file');
        if isequal(filename, 0) || isequal(pathname, 0)
            disp('Selection cancelled');
            return
        else
            filein = fullfile(pathname, filename);
            disp(['file selected: ', filein]);
        end
    else
        filein = varargin{1};
        if ~exist(filein, 'file')
            error('%s not found', filein);
        end
    end

    % detect what's inside the selected file
    sheet1_opts = detectImportOptions(filein, 'Sheet', 1);
    try
        sheet2_opts = detectImportOptions(filein, 'PreserveVariableNames', true, 'Sheet', 2);
    catch one_sheet
        fprintf('import only variables: %s\n', one_sheet.message);
        sheet2_opts = [];
    end

    %% quickly check other arguments are valid
    if nargin > 1
        if ~any(contains(varargin, {'ignore', 'export'}, 'IgnoreCase', true))
            error('key input arguments in are missing ''ignore'' and/or ''export_dir''');
        else
            if any(contains(varargin, 'export', 'IgnoreCase', true))
                export_dir = varargin{find(contains(varargin, 'export', 'IgnoreCase', true)) + 1};
            end

            if any(contains(varargin, 'ignore', 'IgnoreCase', true))
                if any(contains(varargin, 'export', 'IgnoreCase', true))
                    if find(contains(varargin, 'ignore', 'IgnoreCase', true)) < ...
                      find(contains(varargin, 'export', 'IgnoreCase', true))
                        ignore_var = find(contains(varargin, 'ignore', 'IgnoreCase', true)) + ...
                          1:find(contains(varargin, 'export', 'IgnoreCase', true)) - 1;
                    else
                        ignore_var = find(contains(varargin, 'ignore', 'IgnoreCase', true)) + 1:nargin;
                    end
                else
                    ignore_var = find(contains(varargin, 'ignore', 'IgnoreCase', true)) + 1:nargin;
                end
            end
        end
    end

    %% create particpiants.tsv
    Data = readtable(filein, sheet1_opts);

    % 1st check mandatory/recommended fields are presents
    participant_idvar = any(strcmpi(Data.Properties.VariableNames, 'participant_id'));
    idvar = any(strcmpi(Data.Properties.VariableNames, 'id'));
    if idvar == 0 && participant_idvar == 0
        error('no participant ID variable detected, invalid file');
    elseif idvar == 1 && participant_idvar == 0
        disp('ID variable detected, the BIDS value exported will be participant_id ');
        Data.Properties.VariableNames(strcmpi(Data.Properties.VariableNames, 'id')) = {'participant_id'};
    end

    if length(unique(Data.participant_id)) ~= length(Data.participant_id)
        [~, idx] = unique(Data.participant_id);
        non_unique = setdiff(1:length(Data.participant_id), idx);
        non_unique = cell2mat(Data.participant_id(non_unique));
        for id = 1:size(non_unique, 1)
            warning('some IDs are duplicate: %s', non_unique(id, :));
        end
        error('non unique IDS are not permitted');
    end

    if any(strcmp(Data.Properties.VariableNames, 'Sex'))
        Data.Properties.VariableNames(strcmpi(Data.Properties.VariableNames, 'Sex')) = {'sex'};
    end
    sexvar = any(strcmpi(Data.Properties.VariableNames, 'sex'));
    gendervar = any(strcmpi(Data.Properties.VariableNames, 'gender'));
    if gendervar == 1 && sexvar == 0
        disp('gender variable detected - the recommended optional field is ''sex'' but ok using gender');
    end

    if any(strcmp(Data.Properties.VariableNames, 'Age'))
        Data.Properties.VariableNames(strcmpi(Data.Properties.VariableNames, 'Age')) = {'age'};
    end
    if ~any(strcmpi(Data.Properties.VariableNames, 'age'))
        disp('age variable is missing - this is only an optional field still exporting');
    else
        if ~isnumeric(Data.age)
            for v = 1:length(Data.age)
                Data.age{v} = str2double(Data.age{v});
            end
            Data.age = cell2mat(Data.age); % ensure age treated as number
        end
    end

    % 2nd check if any of those variable should be removed - and feedback if
    % some input variable names were not found
    if nargin > 1
        if any(contains(varargin, 'ignore', 'IgnoreCase', true))
            for var = ignore_var
                if any(contains(Data.Properties.VariableNames, varargin{var}, 'IgnoreCase', true))
                    Data = removevars(Data, varargin{var});
                else
                    fprintf('''%s'' input variable to ignore not recognized - skipping it\n', varargin{var});
                end
            end
        else
            warning('ignore argument not recognized - skipping any options');
        end
    end

    % last check variable values (also useful for metadata)
    if any(~contains(Data.participant_id, 'sub-'))
        disp('participant_id should include ''sub-'', adding it to current IDs');
        for sub = 1:length(Data.participant_id)
            if ~contains(Data.participant_id{sub}, 'sub-')
                Data.participant_id{sub} = ['sub-' Data.participant_id{sub}];
            end
        end
    end

    value_types = varfun(@class, Data, 'OutputFormat', 'cell');
    for v = length(value_types):-1:1
        values{v} = unique(Data.(Data.Properties.VariableNames{v}));
    end

    export_data = convert_NAN_to_na(Data);

    if ~exist('export_dir', 'var')
        export_dir = uigetdir(fileparts(filein), 'Select directory to save exported files');
        if export_dir == 0
            export_dir = fileparts(filein);
        end
    end
    try
        writetable(export_data, [export_dir filesep 'participants.tsv'], 'FileType', 'text', 'Delimiter', '\t');
        files_out{1} = fullfile(export_dir, 'participants.tsv');
        fprintf('participants.tsv file saved in %s\n', export_dir);
        clear export_data;
    catch tsv_error
        files_out{2} = 'particpants.tsv file not created';
        error('participants.tsv not saved %s\n', tsv_error.mewsage);
    end

    %% create participants.json
    if ~isempty(sheet2_opts)
        GivenMetaData = readtable(filein, sheet2_opts);

        if any(contains(GivenMetaData.Properties.VariableNames, 'Variable'))
            GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, 'Variable')) = ...
              {'variables'};
        elseif any(contains(GivenMetaData.Properties.VariableNames, 'variable'))
            GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, 'variable')) = ...
              {'variables'};
        end

        if ~any(strcmpi('variables', GivenMetaData.Properties.VariableNames))
            warning('metadata sheet provided but ''variables name'' not found - using worksheet 1');
        else
            % given variables present check description
            if ~any(contains(GivenMetaData.Properties.VariableNames, 'description', 'IgnoreCase', true))
                warning('metadata sheet provided but ''description of variables'' not found - using worksheet 1');
            else
                matched_var = cellfun(@(x) find(strcmpi(x, Data.Properties.VariableNames)), GivenMetaData.variables, ...
                                      'UniformOutput', false);
                matched_var(cellfun(@(x) isempty(x), matched_var')) = {0}; % mark empty as 0
                try
                    matched_var = cell2mat(matched_var); % works if unique, ie one value per cell
                    if any(contains(GivenMetaData.Properties.VariableNames, 'description'))
                        GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, ...
                                                                       'description')) = ...
                          {'Description'};
                    end
                catch matched_var_err
                    warning(['variable names between worksheets likely not unique,', ...
                             ' skipping provided metadata \n%s\n'], ...
                            matched_var_err.message); %#ok<MEXCEP>
                end
            end

            % given variables present check levels
            if ~any(contains(GivenMetaData.Properties.VariableNames, 'level', 'IgnoreCase', true))
                warning('metadata sheet provided but ''levels'' not found - using worksheet 1');
            else
                if any(contains(GivenMetaData.Properties.VariableNames, 'level'))
                    GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, ...
                                                                   'level')) = ...
                      {'Levels'};
                elseif any(contains(GivenMetaData.Properties.VariableNames, 'levels'))
                    GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, ...
                                                                   'levels')) = ...
                      {'Levels'};
                end
            end

            % given variables present check unit
            if ~any(contains(GivenMetaData.Properties.VariableNames, 'unit', 'IgnoreCase', true))
                warning('metadata sheet provided but ''Units'' of variables not found');
            else
                if any(contains(GivenMetaData.Properties.VariableNames, 'unit'))
                    GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, ...
                                                                   'unit')) = ...
                      {'Units'};
                elseif any(contains(GivenMetaData.Properties.VariableNames, 'units'))
                    GivenMetaData.Properties.VariableNames(strcmpi(GivenMetaData.Properties.VariableNames, ...
                                                                   'units')) = ...
                      {'Units'};
                end
            end
        end
    else
        matched_var = zeros(length(Data.Properties.VariableNames), 1);
    end

    % prepare json variables from worksheet 1
    % 'values' are the unique values read on the data
    % 'value_types' gives an indication if we want to use Level or Unit
    % we can complement with GivenMetaData.Description, GivenMetaData.Levels and GivenMetaData.Units
    % using 'matched_var' for instance: variables names match between worksheet

    json = struct;
    for var = 1:length(Data.Properties.VariableNames)
        if ~strcmpi(Data.Properties.VariableNames{var}, 'participant_id')
            % add description
            if ismember(var, matched_var)
                if any(contains(GivenMetaData.Properties.VariableNames, 'Description'))
                    if ~isempty(GivenMetaData.Description{matched_var == var})
                        json.(Data.Properties.VariableNames{var}).Description = ...
                          GivenMetaData.Description{matched_var == var};
                    else
                        json.(Data.Properties.VariableNames{var}).Description = [];
                    end
                end
            else
                json.(Data.Properties.VariableNames{var}).Description = [];
            end

            % add Levels and Units
            if strcmpi(value_types{var}, 'cell') % likely Levels
                if ismember(var, matched_var) && any(contains(GivenMetaData.Properties.VariableNames, 'Levels'))
                    if ~isempty(GivenMetaData.Levels{matched_var == var})
                        tmp = lower(GivenMetaData.Levels{matched_var == var});
                        tmp = regexprep(tmp, '\t', ';'); % in case tab is used
                        tmp(isspace(tmp)) = []; % deblank as well
                        separators = sort([strfind(tmp, ';') strfind(tmp, ',') length(tmp)]);
                        index1 = 1;
                        index2 = separators(1) - 1;
                        for l = 1:length(separators)
                            Levels{l} = tmp(index1:index2);
                            if l < length(separators)
                                index1 = separators(l) + 1;
                                index2 = separators(l + 1);
                            end
                        end

                        tmp = values{var};
                        tmp(strcmpi(tmp, 'n/a')) = [];
                        tmp(strcmpi(tmp, 'nill')) = [];
                        if length(tmp) ~= length(Levels)
                            warning('Levels of ''%s'' between data and metadata don''t match', ...
                                    Data.Properties.VariableNames{var});
                            % only write fields
                            for v = 1:length(tmp)
                                json.(Data.Properties.VariableNames{var}).Levels.(tmp{v}) = [];
                            end
                        else
                            % store levels
                            for v = 1:length(tmp)
                                json.(Data.Properties.VariableNames{var}).Levels.(tmp{v}) = Levels{v};
                            end
                        end
                    else
                        json.(Data.Properties.VariableNames{var}).Levels = [];
                    end
                else % no metadata
                    json.(Data.Properties.VariableNames{var}).Levels = values{var};
                end
            else % likely units
                if ismember(var, matched_var) && any(contains(GivenMetaData.Properties.VariableNames, 'Units'))
                    if ~isempty(GivenMetaData.Levels{var})
                        json.(Data.Properties.VariableNames{var}).Units = ...
                          lower(GivenMetaData.Units{matched_var == var});
                    else
                        json.(Data.Properties.VariableNames{var}).Units = [];
                    end
                else % no metadata
                    json.(Data.Properties.VariableNames{var}).Units = [];
                end
            end
        end
    end

    try
        jsonwrite([export_dir filesep 'participants.json'], json, struct('indent', ' '));
        files_out{2} = fullfile(export_dir, 'participants.json');
        fprintf('participants.json file saved in %s\n', export_dir);
        warndlg(sprintf('json file created, do check it ! \n it is almost certain it needs editing'), ...
                'BIDS spec', 'modal');
    catch json_err
        files_out{2} = 'particpants.json file not created';
        error('participants.json not saved %s\n', json_err.mewsage);
    end

end

function export_data = convert_NAN_to_na(data)

    % make sure to export NaN as n/a
    export_data = data;

    for v = 1:length(export_data.Properties.VariableNames)

        if strcmp(class(export_data.(cell2mat(export_data.Properties.VariableNames(v)))), 'double')

            export_data.(cell2mat(export_data.Properties.VariableNames(v))) = ...
              num2cell(export_data.(cell2mat(export_data.Properties.VariableNames(v))));

            for n = 1:size(export_data.(cell2mat(export_data.Properties.VariableNames(v))), 1)
                if isnan(export_data.(cell2mat(export_data.Properties.VariableNames(v))){n})
                    export_data.(cell2mat(export_data.Properties.VariableNames(v))){n} = 'n/a';
                end
            end

        end

    end

end
