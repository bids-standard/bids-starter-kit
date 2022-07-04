# Filenames

BIDS has a standardized way of naming files that tries to implement the
following principles:

-   Do not include white spaces in file names
    -   They make scripting harder.
-   Use only letters, numbers, hyphens, and underscores.
    -   Some operating systems cannot handle special characters.
-   Do not rely on letter case (`UPPERCASE` and `lowercase`)
    -   For some operating systems `a` is the same as `A`.
-   Use separators and case in a systematic and meaningful way.
    -   [`thisIsCamelCase`](https://en.wikipedia.org/wiki/Camel_case)
    -   [`this_is_snake_case`](https://en.wikipedia.org/wiki/Snake_case)

Source:
[Datalad RDM course](https://psychoinformatics-de.github.io/rdm-course/02-structuring-data/index.html)

## Filename template

<!--
    check the css file src/_static/myfile.css
    to modify the color related to the different "var" below
 -->

<h3 style="padding: 40px; text-align:center; width: 100%; border-style: solid">
    <span style="color: var(--key)">key1</span>
    <span style="color: black">-</span>
    <span style="color: var(--label)">value1</span>
    <span style="color: var(--underscore)">_</span>
    <span style="color: var(--key)">key2</span>
    <span style="color: black">-</span>
    <span style="color: var(--label)">value2</span>
    <span style="color: var(--underscore)">_</span>
    <span style="color: var(--suffix)">suffix</span>
    <span style="color: var(--ext)">.extension</span>
</h3>

<p>
    <ul>
        <li><span style="color: var(--suffix)">Suffixes</span> are preceded by an <span style="color: var(--underscore)">underscore</span></li>
        <li>Entities are composed of <span style="color: var(--key)">key</span><span style="color: black">-</span><span style="color: var(--label)">value</span> pairs separated by <span style="color: var(--underscore)">underscores</span></li>
        <li>There is a limited set of <span style="color: var(--suffix)">suffixes</span> for each data type (anat, func, eeg, …)</li>
        <li>For a given <span style="color: var(--suffix)">suffix</span>, some entities are <b>required</b> and some others are <b>[optional]</b>.</li>
        <li><span style="color: var(--key)">Keys</span>, <span style="color: var(--label)">value</span> and <span style="color: var(--suffix)">suffixes</span> can only contain letters and/or numbers.</li>
        <li>Entity <span style="color: var(--key)">key</span><span style="color: black">-</span><span style="color: var(--label)">value</span> pairs have a specific order in which they must appear in filename.</li>
        <li>Some entities <span style="color: var(--key)">key</span><span style="color: black">-</span><span style="color: var(--label)">value</span> can only be used for
derivative data.</li>
    </ul>
<p>

## Modalities

<!--
Next, we'll populate the first subject's folder with datatype folders. We'll have
one per data modality. We'll include a number of different modalities to
describe their associated metadata below, though most likely you won't have all
of these for a single subject (if you do, please make sure to open-source your
data ;-) ).

**NOTE** all `run-` and `echo-` labels must only contain integers

Here's a list of these folders:
-->

### MRI

#### `anat`: Anatomical MRI data

`myProject/sub-01/ses-01/anat/`

    -   Data:
        -   `sub-<>[_ses-<>]_T1w.nii.gz`
    -   Metadata:
        -   `sub-<>[_ses-<>]_T1w.json`

#### `func`: Functional MRI data

`myProject/sub-01/ses-01/func/`

    -   Data:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_bold.nii.gz`
    -   Metadata:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_bold.json`
    -   Events:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_events.tsv`

#### `fmap`: Fieldmap MRI data

`myProject/sub-01/ses-01/fmap/`

    -   Data:
        -   `sub-<>_ses-<>_acq-<>_run-<>_phasediff.nii.gz`
        -   `sub-<>_ses-<>_acq-<>_run-<>_magnitude1.nii.gz`
    -   Metadata:
        -   `sub-<>_ses-<>_acq-<>_run-<>_phasediff.json`

#### `dwi`: Diffusion Weighted Imaging data

`myProject/sub-01/ses-01/dwi/`

    -   Data:
        -   `sub-<>_ses-<>_acq-<>_run-<>_dwi.nii.gz`
        -   `sub-<>_ses-<>_acq-<>_run-<>_dwi.bval`
        -   `sub-<>_ses-<>_acq-<>_run-<>_dwi.bvec`
    -   Metadata:
        -   `sub-<>_ses-<>_acq-<>_run-<>_dwi.json`

<!-- TODO perf -->

### EEG / MEG / iEEG

<!-- TODO EEG -->

#### `meg`: MEG data

`myProject/sub-01/ses-01/meg/`

    -   Data:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_proc-<>_meg.extension`
    -   Metadata:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_proc-<>_meg.json`
    -   Channel information:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_proc-<>_channels.tsv`
    -   Events:
        -   `sub-<>_ses-<>_task-<>_acq-<>_run-<>_proc-<>_events.tsv`
    -   Sensor positions:
        -   `sub-<>_ses-<>_acq-<>_photo.jpg`
        -   `sub-<>_ses-<>_acq-<>_fid.json`
        -   `sub-<>_ses-<>_acq-<>_fidinfo.txt`
        -   `sub-<>_ses-<>_acq-<>_headshape.extension`

#### `ieeg`: Intracranial EEG data

`myProject/sub-01/ses-01/ieeg/`

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

### PET

#### `pet`: Positron Emission Tomography data

`myProject/sub-01/pet/`

    -   Data:
        -   `sub-<>_ses-<>_pet.json`
        -   `sub-<>_ses-<>_pet.nii.gz`
        -   `sub-<>_ses-<>_recording-<>_blood.json`
        -   `sub-<>_ses-<>_recording-<>_blood.tsv`

<!-- TODO Microscopy -->
