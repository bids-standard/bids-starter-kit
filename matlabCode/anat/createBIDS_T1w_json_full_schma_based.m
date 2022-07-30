% Similar to "createBIDS_T1w_json_full.m"
% but relies on the BIDS schema to get a more updated version
% of the list of metadata

% This is work in progress but should become most useful when the BIDS
% shcema is updated to include what are the required fields a given suffix

%%
clear;

this_dir = fileparts(mfilename('fullpath'));

root_dir = fullfile(this_dir, '..', filesep, '..');

project = 'templates';

sub_label = '01';
ses_label = '01';
run_label = '01';

% The OPTIONAL acq-<label> key/value pair corresponds to a custom label
% the user MAY use to distinguish a different set of parameters used for
% acquiring the same modality.
acq_label = 'SchemaBased';

name_spec.modality = 'anat';
name_spec.suffix = 'T1w';
name_spec.ext = '.json';

name_spec.entities = struct('sub', sub_label, ...
                            'ses', ses_label, ...
                            'acq', acq_label, ...
                            'run', run_label);

% using the 'use_schema', true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
anat_json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

% Make sure the directory exists
bids.util.mkdir(fileparts(anat_json_name));

%%
% Assign the fields in the Matlab structure that can be saved as a json.
% all REQUIRED /RECOMMENDED /OPTIONAL metadata fields for Magnetic Resonance Imaging data

fprintf(1, '\n');

anat_json = struct();

schema = bids.Schema;

mri_fields = fieldnames(schema.content.rules.sidecars.mri);

for i = 1:numel(mri_fields)

    this_field = schema.content.rules.sidecars.mri.(mri_fields{i});

    mri_subfields = fieldnames(this_field.fields);

    for j = 1:numel(mri_subfields)

        this_subfield = this_field.fields.(mri_subfields{j});

        if ischar(this_subfield) && strcmp(this_subfield, 'recommended')
            fprintf(1, '%s\n', mri_subfields{j});
            this_field.fields;
            anat_json.(mri_subfields{j}) = ' ';
        end

    end

end

%% Write JSON
% bids.util.jsonencode(anat_json_name, anat_json);

fprintf(1, '\n');
