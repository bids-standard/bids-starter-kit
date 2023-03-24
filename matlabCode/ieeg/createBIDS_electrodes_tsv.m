%% Template Matlab script to create an BIDS compatible electrodes.tsv file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
%
% DHermes, 2017
% modified Giulio Castegnaro 201811

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

name_spec.modality = 'ieeg';
name_spec.suffix = 'electrodes';
name_spec.ext = '.tsv';
name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
electrodes_tsv_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%% make a participants table and save

% to get the definition of each column,
% you can use the bids.Schema class from bids matlab
% For example
schema = bids.Schema;
def = schema.get_definition('size');
fprintf(def.description);

%% required columns
tsv.name = {'n/a'};
tsv.x = 0;
tsv.y = 0;
tsv.z = 0;
tsv.size = 0;

%% recommended columns
tsv.material = {'n/a'};
tsv.manufacturer = {'n/a'};
tsv.group = {'n/a'};
tsv.hemisphere = {'n/a'};

%% optional columns
tsv.type = {'n/a'};
tsv.impedance = nan;

%% write
bids.util.tsvwrite(electrodes_tsv_name, tsv);
