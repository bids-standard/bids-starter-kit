# Derivatives

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

## Tour of a BIDS Derivative

As with BIDS datasets, all conformant derivative datasets contain a
`dataset_description.json`.

New fields include `DatasetType`, which distinguishes `"derivative"` datasets
from `"raw"`:

-   `GeneratedBy`, a list of processes that generated the data
-   `SourceDatasets`, a list of datasets used to generate the derivative.

```json
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

### Preprocessed data

Data is considered to be _preprocessed_ if it is fundamentally similar to the
source data. Artifact removal, motion correction and resampling to a template
space are examples of preprocessing.

An example of a subject with simultaneous EEG/fMRI resting state scan, aligned
along with a T1w image to the MNI305 template:

```bash
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

### Derivative data types

Data is considered to be _processed_ if it is fundamentally different to the
source data. Processed data may differ substantially in BIDS datatypes from the
original input data.

The initial offering of BIDS Derivatives only specifies anatomical derivatives
that are of general use: masks and segmentations.

Mask images are binary images with 1 representing the region of interest and all
other voxels containing 0. The following example shows a manually constructed
lesion mask:

```bash
manual_masks/
  sub-01/
    anat/
      sub-01_desc-lesion_mask.nii.gz
      sub-01_desc-lesion_mask.json
```

A mask of the functionally-defined area fusiform face area could be encoded:

```bash
localizer/
  sub-01/
    func/
      sub-01_task-loc_space-individual_label-FFA_mask.nii.gz
      sub-01_task-loc_space-individual_label-FFA_mask.json
```

BIDS Derivatives introduces "discrete segmentations" and "probabilistic
segmentations".

A _segmentation_ is a labeling of regions of an image such that each location
(for example, a voxel or a surface vertex) is identified with a label or a
combination of labels. Labeled regions may include anatomical structures (such
as tissue class, Brodmann area or white matter tract), discontiguous,
functionally-defined networks, tumors or lesions.

A _discrete segmentation_ represents each region with a unique integer label. A
_probabilistic segmentation_ represents each region as values between 0 and 1
(inclusive) at each location in the image, and one volume/frame per structure
may be concatenated in a single file.

A BIDS App that calculates ROIs in BOLD space from the automated anatomical
labeling (AAL, doi:[10.1006/nimg.2001.0978]) could store discrete and
probabilistic (or partial volume) segmentations as follows:

```bash
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

### Unspecified data types

Derivatives can never be fully specified, as new methods can always be
developed, requiring new data representations. BIDS recognizes this and
encourages adopting "BIDS-style naming conventions".

Additional files and folders containing raw data MAY be added as needed for
special cases. All non-standard file entities SHOULD conform to BIDS-style
naming conventions, including alphabetic entities and suffixes and alphanumeric
labels/indices. Non-standard suffixes SHOULD reflect the nature of the data, and
existing entities SHOULD be used when appropriate.

This recommendation remains in force for derivatives datasets. Additionally,
BIDS Derivatives acknowledges that it may be desirable to distribute derivatives
generated by non-compliant applications, for the sake of reproducibility and
non-duplication of effort. Therefore, if a BIDS dataset contains a
`derivatives/` sub-directory, the contents of that directory may be a
heterogeneous mix of BIDS Derivatives datasets and non-compliant derivatives.

One example of such a non-compliant derivative dataset would be FreeSurfer
reconstructions of subject surfaces:

```bash
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

```bash
my_dataset/
  derivatives/
    preprocessed/
    analysis/
  sub-01/
  ...
```

A BIDS Derivatives dataset may contain references to its input datasets in the
`sourcedata/` subdirectory:

```bash
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

```bash
my_study/
  raw_data/
    sub-01/
    ...
  derivatives/
    preprocessed/
    analysis/
```

<!-- TODO derivatives JSON -->
