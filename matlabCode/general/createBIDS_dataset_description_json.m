%% Template Matlab script to create an BIDS compatible dataset_description.json file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017

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

project_label = 'templates';

json_label = 'dataset_description';

json_name = fullfile(root_dir, project_label, 'dataset_description.json');

%% General fields, shared with MRI BIDS and MEG BIDS:

%% Required fields:

% name of the dataset
json.Name = '';

% The version of the BIDS standard that was used
json.BIDSVersion = '1.7.0';

% The interpretation of the dataset. MUST be one of "raw" or "derivative".
% For backwards compatibility, the default value is "raw".
json.DatasetType = 'raw';

%% Recommended fields:

% what license is this dataset distributed under? The
% use of license name abbreviations is suggested for specifying a license.
% A list of common licenses with suggested abbreviations can be found in appendix III.
json.License = '';

% List of individuals who contributed to the
% creation/curation of the dataset
json.Authors = {'', '', ''};

json.Acknowledgements = ''; % who should be acknowledge in helping to collect the data

% Instructions how researchers using this
% dataset should acknowledge the original authors. This field can also be used
% to define a publication that should be cited in publications that use the
% dataset.
json.HowToAcknowledge = '';

% sources of funding (grant numbers)
json.Funding = {'', '', ''};

% List of ethics committee approvals of the research protocols and/or protocol identifiers.
json.EthicsApprovals = {''};

% a list of references to
% publication that contain information on the dataset, or links.
json.ReferencesAndLinks = {'', '', ''};

% the Document Object Identifier of the dataset
% (not the corresponding paper).
json.DatasetDOI = 'doi:';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
