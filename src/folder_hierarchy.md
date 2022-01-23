# BIDS folders

The BIDS format is essentially a way to structure your data / metadata within a
hierarchy of folders. This makes it easy to browse from a computer, as well as
to automatically parse a BIDS folder with a program. The BIDS structure makes
minimal assumptions about the tools needed to interact with the data that's
inside.

These are the three main types of files you'll find in a BIDS dataset:

1. `.json` files that contain `key: value` metadata
2. `.tsv` files that contain tables of metadata
3. Raw data files (for example: `.jpg` files for images or `.nii.gz` files for
   fMRI data.)

These three types of files are organized into a hierarchy of folders that have
specific naming conventions. The rest of this page describes how these folders
are structured.

## Overview

There are four main levels of the folder hierarchy, these are:

```
project/
└── subject
    └── session
        └── datatype
```

With the exception of the top-level `project` folder, all sub-folders have a
specific structure to their name (described below). Here's an example of how
this hierarchy looks:

```
myProject/
└── sub-01
    └── ses-01
        └── anat
```

Here is the folder name structure of each level:

## project

Can have any name, this should be descriptive for the dataset contained in the
folder.

## subject

Structure: `sub-<participant label>`

One folder per subject in this dataset. Labels should be unique for each
subject.

## session

Structure: `ses-<session label>`

Represents a recording session. You might have multiple sessions per subject if
you collected data from them on different days. If there is only a single
session per subject, this level of the hierarchy may be omitted.

## datatype

Represents different types of data. Must be one of:

-   func 
-   dwi
-   fmap
-   anat
-   meg
-   eeg
-   ieeg
-   beh
-   pet

The name for the datatype depends on the recording modality.

## BIDS folder example

Below is the folder hierarchy for one of the
[BIDS example datasets](https://github.com/INCF/BIDS-examples). It has multiple
subjects of data, and includes metadata files (`.tsv` and `.json`) both between-
and within-subjects.

Note that it has one session per subject, so this level is omitted.

```
ds001
├── dataset_description.json
├── participants.tsv
├── sub-01
│   ├── anat
│   │   ├── sub-01_inplaneT2.nii.gz
│   │   └── sub-01_T1w.nii.gz
│   └── func
│       ├── sub-01_task-balloonanalogrisktask_run-01_bold.nii.gz
│       ├── sub-01_task-balloonanalogrisktask_run-01_events.tsv
│       ├── sub-01_task-balloonanalogrisktask_run-02_bold.nii.gz
│       ├── sub-01_task-balloonanalogrisktask_run-02_events.tsv
│       ├── sub-01_task-balloonanalogrisktask_run-03_bold.nii.gz
│       └── sub-01_task-balloonanalogrisktask_run-03_events.tsv
├── sub-02
│   ├── anat
│   │   ├── sub-02_inplaneT2.nii.gz
│   │   └── sub-02_T1w.nii.gz
│   └── func
│       ├── sub-02_task-balloonanalogrisktask_run-01_bold.nii.gz
│       ├── sub-02_task-balloonanalogrisktask_run-01_events.tsv
│       ├── sub-02_task-balloonanalogrisktask_run-02_bold.nii.gz
│       ├── sub-02_task-balloonanalogrisktask_run-02_events.tsv
│       ├── sub-02_task-balloonanalogrisktask_run-03_bold.nii.gz
│       └── sub-02_task-balloonanalogrisktask_run-03_events.tsv
...
...
└── task-balloonanalogrisktask_bold.json
```

## Creating a BIDS folder hierarchy

Next we'll step through a sample process one might follow when creating a BIDS
hierarchy for a new dataset.

### Create the folder hierarchy and top-level metadata file

First we'll create the folder hierarchy to be used in this format.

-   Create the top-level project folder (`myProject/`)
-   Create a top-level metadata files (`myProject/participants.tsv` and
    `myProject/task-mytask.json`)

### Create a subject's folder

Next we'll add the folder hierarchy for one subject:

-   Create the `<Project>/<Subject>/<Session>/` folder
    (`myProject/sub-01/ses-01/`)

### Populate the datatype folder

Next we'll populate the first subject's folder with datatype folders. We'll have
one per data modality. We'll include a number of different modalities to
describe their associated metadata below, though most likely you won't have all
of these for a single subject (if you do, please make sure to open-source your
data ;-) ).

**NOTE** all `run-` and `echo-` labels must only contain integers

Here's a list of these folders:

-   **anat**: Anatomical MRI data (`myProject/sub-01/ses-01/anat/`)
    -   Data:
        -   `sub-<>_ses-<>_T1w.nii.gz`
    -   Metadata:
        -   `sub-<>_ses-<>_T1w.json`
-   **fmri**: Functional MRI data (`myProject/sub-01/ses-01/func/`)
    -   Data:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_bold.nii.gz`
    -   Metadata:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_bold.json`
    -   Events:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_events.tsv`
-   **fmap**: Fieldmap MRI data (`myProject/sub-01/ses-01/fmap/`)
    -   Data:
        -   `sub-<>_ses-<>_acq-<>_run-<>_phasediff.nii.gz`
        -   `sub-<>_ses-<>_acq-<>_run-<>_magnitude1.nii.gz`
    -   Metadata:
        -   `sub-<>_ses-<>_acq-<>_run-<>_phasediff.json`
-   **meg**: MEG data (`myProject/sub-01/ses-01/meg/`)
    -   Data:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_proc-<>_meg.extension`
    -   Metadata:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_proc-<>_meg.json`
    -   Channel information:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<> _proc-<>_channels.tsv`
    -   Events:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<> _proc-<>_events.tsv`
    -   Sensor positions:
        -   `sub-<>_ses-<>_acq-<>_photo.jpg`
        -   `sub-<>_ses-<>_acq-<>_fid.json`
        -   `sub-<>_ses-<>_acq-<>_fidinfo.txt`
        -   `sub-<>_ses-<>_acq-<>_headshape.extension`
-   **ieeg**: intracranial EEG data (`myProject/sub-01/ses-01/ieeg/`)
    -   Data:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_ieeg.extension`
    -   Metadata:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_ieeg.json`
    -   Channel information:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_channels.tsv`
    -   Events:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_events.tsv`
    -   Electrode locations:
        -   `sub-<>_ses-<>_acq-<>_electrodes.tsv` _electrode xyz coordinates_
        -   `sub-<>_ses-<>_acq-<>_coordsystem.json` _coordinate metadata_
        -   `sub-<>_ses-<>_acq-<>_photo.jpg` _operative photo_
-   **dwi**: Diffusion Imaging Data (`myProject/sub-01/ses-01/dwi/`)
    -   Data:
        -   `sub-< >_ses-< >_acq-< >_run-< >_dwi.nii.gz`
        -   `sub-< >_ses-< >_acq-< >_run-< >_dwi.bval`
        -   `sub-< >_ses-< >_acq-< >_run-< >_dwi.bvec`
    -   Metadata:
        -   `sub-< >_ses-< >_acq-< >_run-< >_dwi.json`
-   **pet** Positron Emission Tomography Data (`myProject/sub-01/pet/`)
    -   Data:
        -   `sub-< >_ses-< >_pet.json`
        -   `sub-< >_ses-< >_pet.nii.gz`
        -   `sub-< >_ses-< >_recording-< >_blood.json`
        -   `sub-< >_ses-< >_recording-< >_blood.tsv`

## BIDS: source, rawdata, derivatives

### BIDS Derivatives

Derivatives are outputs of (pre-)processing pipelines, capturing data and
meta-data sufficient for a researcher to understand and (critically) reuse those
outputs in subsequent processing. Standardizing derivatives is motivated by use
cases where formalized machine-readable access to processed data enables higher
level processing.

A derivative dataset is a collection of derivatives, or files that have been
generated from the data. Broadly, a derivative can be considered to be
preprocessed or processed, such that the data type is unchanged or changed,
respectively, from that of the source data file(s).

BIDS Derivatives was finalized in version 1.4.0 of the BIDS specification.

### Tour of a BIDS Derivative

As with BIDS datasets, all conformant derivative datasets contain a
`dataset_description.json`. New fields include `DatasetType`, which
distinguishes `"derivative"` datasets from `"raw"`; `GeneratedBy`, a list of
processes that generated the data; `SourceDatasets`, a list of datasets used to
generate the derivative.

```YAML
{
  "Name": "FMRIPREP Outputs",
  "BIDSVersion": "1.4.0",
  "DatasetType": "derivative",
  "GeneratedBy": [
    {
      "Name": "fmriprep",
      "Version": "1.4.1",
      "Container": {
        "Type": "docker",
        "Tag": "poldracklab/fmriprep:1.4.1"
        }
    },
    {
      "Name": "Manual",
      "Description": "Re-added RepetitionTime metadata to bold.json files"
    }
  ],
  "SourceDatasets": [
    {
      "DOI": "10.18112/openneuro.ds000114.v1.0.1",
      "URL": "https://openneuro.org/datasets/ds000114/versions/1.0.1",
      "Version": "1.0.1"
    }
  ]
}
```

#### Preprocessed data

Data is considered to be _preprocessed_ if it is fundamentally similar to the
source data. Artifact removal, motion correction and resampling to a template
space are examples of preprocessing.

An example of a subject with simultaneous EEG/fMRI resting state scan, aligned
along with a T1w image to the MNI305 template:

```
pipeline1/
  sub-01/
    anat/
      sub-01_space-MNI305_T1w.nii.gz
      sub-01_space-MNI305_T1w.json
    eeg/
      sub-01_task-rest_desc-filtered_eeg.edf
      sub-01_task-rest_desc-filtered_eeg.json
    func/
      sub-01_task-rest_space-MNI305_desc-preproc_bold.nii.gz
      sub-01_task-rest_space-MNI305_desc-preproc_bold.json
```

The `space` entity indicates that a file is aligned to some reference space. For
standard templates, this is sufficient. For custom templates (for example:
individual or study-specific), additional `SpatialReference` metadata is
required in the JSON sidecar files.

The `desc` (description) entity allows for unrestricted alphanumeric labels, in
the absence of a more appropriate entity to distinguish one file from another.

#### Derivative data types

Data is considered to be _processed_ if it is fundamentally different to the
source data. Processed data may differ substantially in BIDS datatypes from the
original input data.

The initial offering of BIDS Derivatives only specifies anatomical derivatives
that are of general use: masks and segmentations.

Mask images are binary images with 1 representing the region of interest and all
other voxels containing 0. The following example shows a manually constructed
lesion mask:

```
manual_masks/
  sub-01/
    anat/
      sub-01_desc-lesion_mask.nii.gz
      sub-01_desc-lesion_mask.json
```

A mask of the functionally-defined area fusiform face area could be encoded:

```
localizer/
  sub-01/
    func/
      sub-01_task-loc_space-individual_label-FFA_mask.nii.gz
      sub-01_task-loc_space-individual_label-FFA_mask.json
```

BIDS Derivatives introduces "discrete segmentations" and "probabilisitic
segmentations".

> A _segmentation_ is a labeling of regions of an image such that each location
> (for example, a voxel or a surface vertex) is identified with a label or a
> combination of labels. Labeled regions may include anatomical structures (such
> as tissue class, Brodmann area or white matter tract), discontiguous,
> functionally-defined networks, tumors or lesions.
>
> A _discrete segmentation_ represents each region with a unique integer label.
> A _probabilistic segmentation_ represents each region as values between 0 and
> 1 (inclusive) at each location in the image, and one volume/frame per
> structure may be concatenated in a single file.

A BIDS App that calculates ROIs in BOLD space from the automated anatomical
labeling (AAL, doi:[10.1006/nimg.2001.0978]) could store discrete and
probabilistic (or partial volume) segmentations as follows:

```
tissue_segmentation/
  desc-AAL_dseg.tsv
  desc-AAL_probseg.json
  sub-01/
    func/
      sub-01_task-rest_desc-AAL_dseg.nii.gz
      sub-01_task-rest_desc-AAL_probseg.nii.gz
```

The `dseg.tsv` file is a lookup table for interpreting a discrete segmentation
and `probseg.json` contains a list identifying the labels for each consecutive
volume.

#### Unspecified data types

Derivatives can never be fully specified, as new methods can always be
developed, requiring new data representations. BIDS recognizes this and
encourages adopting "BIDS-style naming conventions":

> Additional files and folders containing raw data MAY be added as needed for
> special cases. All non-standard file entities SHOULD conform to BIDS-style
> naming conventions, including alphabetic entities and suffixes and
> alphanumeric labels/indices. Non-standard suffixes SHOULD reflect the nature
> of the data, and existing entities SHOULD be used when appropriate.

This recommendation remains in force for derivatives datasets. Additionally,
BIDS Derivatives acknowledges that it may be desirable to distribute derivatives
generated by non-compliant applications, for the sake of reproducibility and
non-duplication of effort. Therefore,

> if a BIDS dataset contains a `derivatives/` sub-directory, the contents of
> that directory may be a heterogeneous mix of BIDS Derivatives datasets and
> non-compliant derivatives.

One example of such a non-compliant derivative dataset would be FreeSurfer
reconstructions of subject surfaces:

```
bids-root/
  derivatives/
    freesurfer/
      sub-01/
         label/
         mri/
         ...
      ...
  sub-01/
    anat/
      sub-01_T1w.nii.gz
  ...
```

Note that subject directory names conform to BIDS conventions, but contents are
determined by the generating application, in this case, FreeSurfer.

### Organizing datasets and their derivatives

BIDS Derivatives datasets are intended to be interpretable and distributable
with or without the datasets used to generate them. This is necessary for
storage and bandwidth constraints, as well as to permit the distribution of
derivatives when the source data are restricted.

This independence affords flexibility in the relative organization of datasets.
The following examples show three ways to organize, relative to each other, a
raw BIDS dataset, a preprocessed derivative dataset, and an analysis that uses
both as inputs.

A collection of derivative datasets may be stored in the `derivatives/`
subdirectory of a BIDS (or BIDS Derivatives) dataset:

```
my_dataset/
  derivatives/
    preprocessed/
    analysis/
  sub-01/
  ...
```

A BIDS Derivatives dataset may contain references to its input datasets in the
`sourcedata/` subdirectory:

```
my_analysis/
  sourcedata/
    raw/
    preprocessed/
  sub-01/
  ...
```

Note that the `sourcedata/` and `derivatives/` subdirectories constitute dataset
boundaries. Any contents of these directories may be validated independently,
but their contents must not affect the interpretation of the nested or
containing datasets.

Unnested datasets are also possible. For example:

```
my_study/
  raw_data/
    sub-01/
    ...
  derivatives/
    preprocessed/
    analysis/
```
