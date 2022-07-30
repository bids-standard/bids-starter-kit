%% Template Matlab script to create an BIDS compatible _bold.json file
% This example lists all required and optional fields.
% When adding additional metadata please use CamelCase
% Use version of DICOM ontology terms whenever possible.
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

project = 'templates';

sub_label = '01';
ses_label = '01';
sample_label = '01';
chunk_label = '01';
stain_label = '03';
acq_label = 'Full';

name_spec.modality = 'micr';
name_spec.suffix = 'SEM';
name_spec.ext = '.json';
name_spec.entities = struct('sub', sub_label, ...
                            'sample', sample_label, ...
                            'stain', stain_label, ...
                            'acq', acq_label, ...
                            'ses', ses_label, ...
                            'chunk', chunk_label);

% using the 'use_schema'; true
% ensures that the entities will be in the correct order
bids_file = bids.File(name_spec, 'use_schema', true);

% Contrust the fullpath version of the filename
json_name = fullfile(root_dir, project, bids_file.bids_path, bids_file.filename);

%% Adding metadata
% to get the definition of each metadata,
% you can use the bids.Schema class from bids matlab

% For example
schema = bids.Schema;
def = schema.get_definition('Manufacturer');
fprintf(def.description);

% Device Hardware
json.Manufacturer = 'RECOMMENDED';
json.ManufacturersModelName = 'RECOMMENDED';
json.DeviceSerialNumber = 'RECOMMENDED';
json.StationName = 'RECOMMENDED';
json.SoftwareVersions = 'RECOMMENDED';
json.InstitutionName = 'RECOMMENDED';
json.InstitutionAddress = 'RECOMMENDED';
json.InstitutionalDepartmentName = 'RECOMMENDED';

% Image Acquisition
json.PixelSize = 'REQUIRED';
json.PixelSizeUnits = 'REQUIRED';
json.Immersion = 'OPTIONAL';
json.NumericalAperture = 'OPTIONAL';
json.Magnification = 'OPTIONAL';
json.ImageAcquisitionProtocol = 'OPTIONAL';
json.OtherAcquisitionParameters = 'OPTIONAL';

% Sample
json.BodyPart = 'RECOMMENDED';
json.BodyPartDetails = 'RECOMMENDED';
json.SampleEnvironment = 'RECOMMENDED';
json.SampleStaining = 'RECOMMENDED';
json.SamplePrimaryAntibody = 'RECOMMENDED';
json.SampleSecondaryAntibody = 'RECOMMENDED';
json.BodyPartDetailsOntology = 'OPTIONAL';
json.SampleEmbedding = 'OPTIONAL';
json.SampleFixation = 'OPTIONAL';
json.SliceThickness = 'OPTIONAL';
json.TissueDeformationScaling = 'OPTIONAL';
json.SampleExtractionProtocol = 'OPTIONAL';
json.SampleExtractionInstitution = 'OPTIONAL';

% Chunk
json.ChunkTransformationMatrix = 'RECOMMENDED if <chunk-index> is used in filenames';
json.ChunkTransformationMatrixAxis = 'REQUIRED if ChunkTransformationMatrix is present';

%% Write JSON
% Make sure the directory exists
bids.util.mkdir(fileparts(json_name));
bids.util.jsonencode(json_name, json);
