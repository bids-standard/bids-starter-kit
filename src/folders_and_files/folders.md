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

-   `func `
-   `dwi`
-   `fmap`
-   `anat`
-   `meg`
-   `eeg`
-   `ieeg`
-   `beh`
-   `pet`
-   `micr`

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
