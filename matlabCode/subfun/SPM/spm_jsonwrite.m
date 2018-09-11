function varargout = spm_jsonwrite(varargin)
% Serialize a JSON (JavaScript Object Notation) structure
% FORMAT spm_jsonwrite(filename,json)
% filename - JSON filename
% json     - JSON structure
%
% FORMAT S = spm_jsonwrite(json)
% json     - JSON structure
% S        - serialized JSON structure (string)
% 
% References:
%   http://www.json.org/
%__________________________________________________________________________
% Copyright (C) 2015 Wellcome Trust Centre for Neuroimaging

% Guillaume Flandin
% $Id: spm_jsonwrite.m 6610 2015-11-25 17:50:05Z guillaume $


%-Input parameters
%--------------------------------------------------------------------------
if nargin > 1
    filename = varargin{1};
    json     = varargin{2};
    root     = inputname(2);
else
    filename = '';
    json     = varargin{1};
    root     = inputname(1);
end

%-JSON serialization
%--------------------------------------------------------------------------
if ~isstruct(json) && ~iscell(json)
    if ~isempty(root)
        json = struct(root,json);
    else
        error('Invalid JSON structure.');
    end
end
S = jsonwrite_var(json);

%-Output
%--------------------------------------------------------------------------
if isempty(filename)
    varargout = { S };
else
    fid = fopen(filename,'wt');
    if fid == -1
        error('Unable to open file "%s" for writing.',filename);
    end
    fprintf(fid,'%s',S);
    fclose(fid);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S = jsonwrite_var(json,tab)
if nargin < 2, tab = 0; end
if isstruct(json)
    S = jsonwrite_struct(json,tab);
elseif iscell(json)
    S = jsonwrite_cell(json,tab);
elseif ischar(json)
    S = jsonwrite_char(json);
elseif isnumeric(json) || islogical(json)
    S = jsonwrite_numeric(json);
else
    error('Class "%s" is not supported.',class(json));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S = jsonwrite_struct(json,tab)
if numel(json) == 1
    fn = fieldnames(json);
    S = ['{' sprintf('\n')];
    for i=1:numel(fn)
        S = [S blanks((tab+1)*2) jsonwrite_char(fn{i}) ': ' ...
            jsonwrite_var(json.(fn{i}),tab+1)];
        if i ~= numel(fn), S = [S ',']; end
        S = [S sprintf('\n')];
    end
    S = [S blanks(2*tab) '}'];
else
    S = jsonwrite_cell(arrayfun(@(x) {x},json),tab);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S = jsonwrite_cell(json,tab)
S = ['[' sprintf('\n')];
for i=1:numel(json)
    S = [S blanks((tab+1)*2) jsonwrite_var(json{i},tab+1)];
    if i ~= numel(json), S = [S ',']; end
    S = [S sprintf('\n')];
end
S = [S blanks(2*tab) ']'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S = jsonwrite_char(json)
% any-Unicode-character-except-"-or-\-or-control-character
% \" \\ \/ \b \f \n \r \t \u four-hex-digits
json = regexprep(json,'[^\\]"','\\"');
S = ['"' json '"'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function S = jsonwrite_numeric(json)
if numel(json) > 1
    warning('Not supported: converting to JSON array.');
    S = jsonwrite_cell(num2cell(json),0); % consider array of array?
    return;
end
if islogical(json)
    if json, S = 'true'; else S = 'false'; end
else
    if isnan(json)
        S = 'null';
    else
        S = num2str(json);
    end
end
