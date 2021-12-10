# iEEG data conversion

Here, we briefly describe the first steps in creating an iEEG dataset in BIDS
format. The process can be summarized by the following main steps:

1. structure your files in the proper folder hierarchy
2. rename files such that they adhere to the BIDS naming specification,
3. extract the necessary metadata from your raw data and experimental notes
4. add electrode-specific information needed for localization

## Step 1: Folder structure

At the highest level, BIDS is a specification for how to structure your files in
folders, and how to name files such that one can easily infer their contents.
Thus, the first step is to create the proper folder/file hierarchies, which
looks like this:

```
project/
└── subject
    └── session
        └── acquisition
```

The top level (project) of a BIDS folder must contain a dataset_description.json
file, a README, and a CHANGES file. In addition, there are a set of sub-folders,
one per subject, that contain all data from a given subject. These must be named
according to the convention `sub-<label>`. Within these folders there is an
optional "session" folder (called `ses-<label>`) and finally a collection of
"acquisition folders" that correspond to datasets from different modalities
(such as functional imaging, EEG, and iEEG data) that corresponds to this
dataset. In our example, there is a folder called `ieeg` that stores all iEEG
data for the subject, for example:

```
iEEGProject
├── dataset_description.json
├── participants.tsv
├── README
├── CHANGES
├── sub-01
│   ├── anat
│   │   └── sub-01_T1w.nii.gz
│   └── ieeg
│       ├── sub-01_task-visualtask_run-01_ieeg.edf
│       ├── sub-01_task-visualtask_run-01_ieeg.json
│       ├── sub-01_task-visualtask_run-01_channels.tsv
│       ├── sub-01_task-visualtask_run-01_events.tsv
│       ├── sub-01_electrodes.tsv
│       └── sub-01_coordsystem.tsv
├── sub-02
│   ├── anat
│   │   └── sub-02_T1w.nii.gz
│   └── ieeg
│       ├── sub-02_task-visualtask_run-01_ieeg.edf
│       ├── sub-02_task-visualtask_run-01_ieeg.json
│       ├── sub-02_task-visualtask_run-01_channels.tsv
│       ├── sub-02_task-visualtask_run-01_events.tsv
│       ├── sub-02_electrodes.tsv
│       └── sub-02_cooordsystem.tsv
...
└── visualtask_ieeg.json
```

## Step 2. Add raw iEEG data

Once a folder hierarchy is defined, the folders can be populated with the
correct files. Here we focus on the files relevant for iEEG data. Within the
`ieeg` folder, we first copy the raw iEEG data and renamed such that they adhere
to the BIDS file naming scheme. For example:

```
sub-<subjectlabel>\_ses-<sessionlabel>\_task-<tasklabel>\_run-<runlabel>\_ieeg.<extension>
```

These data are unprocessed and can have one of several file formats (for
example: BrainVision and EDF formats are supported, NWB, EEGLab and MEF3 formats
are allowed).

## Step 3. Add iEEG amplifier metadata

BIDS datasets should specify all of the metadata needed to analyze and
understand a dataset, and these are all contained within text-based JavaScript
Object Notation (JSON, field-value) and Tab Separated Value (TSV) metadata
files. The iEEG amplifier metadata are stored for each run in a JSON file with
the same name structure as the raw data (`<raw-data-filename>_ieeg.json`) and a
TSV file with amplifier metadata (`<raw-data-filename>_channels.tsv`).

-   `<raw-data-filename>_ieeg.json`: contains the metadata that are the same for
    all the data in this run, such as the task name and description, the
    amplifier brand, and where the experiments were performed. Download a
    template in the bids-starter-kit
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/ieeg/sub-01_ses-01_task-LongExample_run-01_ieeg.json)
    or find the Matlab script to more automatically populate the required fields
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/matlabCode/ieeg/createBIDS_ieeg_json.m).
-   `<raw-data-filename>_channels.tsv`: The TSV file contains all the settings
    that differ between iEEG channels such as the units and type of channel
    (ECOG, SEEG, ECG, EMG, EOG and so on). Download a template in the
    bids-starter-kit
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/ieeg/sub-01_ses-01_task-LongExample_run-01_channels.tsv)
    or find the Matlab script to more automatically populate the required fields
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/matlabCode/ieeg/createBIDS_channels_tsv.m).

## Step 4. Add electrode-specific metadata

In iEEG recordings, each channel in the amplifier is sampled from a specific
electrode implanted in the brain. The metadata on the type of electrodes and
their coordinates is stored in a TSV file with a row for each metallic electrode
contact (`_electrodes.tsv`). The names of each electrode are used in the
amplifier metadata to specify the recorded channel and reference to link these
two files. In order to interpret the position of each electrode, the coordinate
system is defined in a JSON file (`_coordsystem.json`). The `_coordsystem.json`
file specifies a reference image file, which can be an MRI, surface rendering,
standard space (for example: MNI) or operative photo, such that electrode
positions can be displayed. In addition, any raw data collected for the purpose
of localizing electrodes is stored in a corresponding anatomy folder (called
`anat`) that lives at the same folder level as the `ieeg` folder. This can
contain files like structural volume data or electrode placement photos.

-   `_electrodes.tsv`: Download a template in the bids-starter-kit
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/ieeg/sub-01_ses-01_electrodes.tsv)
    or find the Matlab script to more automatically populate the required fields
    [here](https://github.com/bids-standard/bids-starter-kit/blob/main/matlabCode/ieeg/createBIDS_electrodes_tsv.m).
-   `_coordsystem.json`: Download a template in the bids-starter-kit
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/ieeg/sub-01_ses-01_coordsystem.json)
    or find the Matlab script to more automatically populate the required fields
    [here](https://github.com/bids-standard/bids-starter-kit/tree/main/matlabCode/ieeg/createBIDS_coordsystem_json.m).

## Step 5. Add optional metadata

There are several optional data types that can be stored in BIDS. The way in
which events, stimuli, continuous physiology data, and participant information
are stored is the same as for BIDS MRI data. These optional metadata are stored
within TSV and JSON files as well as any task-specific stimulation files (for
example: photos or sounds that were presented to the subject during the task, or
videos of the subject and experimental setup). Some examples are shown here:

```
iEEGProject
├── dataset_description.json
├── participants.tsv
├── README
├── CHANGES
├── sub-01
│   ├── stimuli
│   │   └── PresentedPhoto1.png
│   │   └── PresentedSound1.wav
│   └── ieeg
│       ├── sub-01_photo.jpg
│       ├── sub-01_task-visualtask_run-01_physio.tsv.gz
│       ├── sub-01_task-visualtask_run-01_physio.json
│       ├── sub-01_task-visualtask_run-01_stim.tsv.gz
│       ├── sub-01_task-visualtask_run-01_stim.json
...
```

## Step 6. Validate the iEEG-BIDS data

In order to verify that a dataset adheres to the BIDS specification, we need to
validate the structure, naming conventions, and information inside the dataset.
The [BIDS validator](https://github.com/bids-standard/bids-validator) is a web-
and command line-based tool that can validate whether a dataset is BIDS
compliant. As a part of the iEEG extension to the BIDS specification, this
validator has been updated to check for new conventions related to iEEG data.
