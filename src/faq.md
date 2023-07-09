## General questions

## MRI specific questions

### What defacing tools can I use?

If you want to share your BIDS data set, chances are that you will have to
anonymize it and therefore prevent identification of the participants from their
anatomical scans. You will need to de-identification (or deface) the anatomical
images. There are several options to do that

-   If you already have a valid BIDS data set you can simply use the
    [BIDSonym BIDS app](https://github.com/PeerHerholz/BIDSonym) on it. To do
    that it relies on several tools that you can also use before you have
    finalized your BIDS data set
    -   [Pydeface](https://github.com/poldracklab/pydeface)
    -   [MRI deface](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_deface)
    -   [Quickshear](https://github.com/nipy/quickshear)

Otherwise you can also use:

-   [Fieldtrip](http://www.fieldtriptoolbox.org/faq/how_can_i_anonymize_an_anatomical_mri/)
    under matlab can do it.
-   SPM8 and SPM12: when in the batch editor go to --> SPM menu --> Util -->
    De-face

## EEG specific questions

### How to format Hardware and Software filter fields in a .json?

In the modality specific sidecar file `_eeg.json`, we can specify the software
and hardware filters that were applied during the collection or processing of
the data. Generally, there are two accepted formats for that:

1. a string containing `"n/a"`, to show that no filter was used or the
   information on the filter is not available.
2. a json object containing one object per filter. This filter-specific object
   contains key-value pairs to describe filter parameters. As per BIDS, all
   frequencies SHOULD be in Hz. For example a single hardware filter could be
   specified as:

```json
"HardwareFilters": {"HighpassFilter": {"CutoffFrequency": 0.1}}
```

For a formatted example on how to deal with this in the BIDS context, please see
this
[template](https://github.com/bids-standard/bids-starter-kit/blob/main/templates/sub-01/ses-01/eeg/sub-01_ses-01_task-FilterExample_eeg.json).

### How to specify EEGReference and EEGGround for Biosemi referencing scheme?

Reference and ground electrodes for EEG data can usually be specified using the
`EEGReference` and `EEGGround` fields in the modality specific sidecar file
`_eeg.json`. Both fields accept a string value such as `"Placed on Cz"`.

However, some manufacturers use special referencing schemes such as the
combination of a "Common Mode Sense" (CMS) and a "Driven Right Leg" (DRL)
electrode. This is the case for Biosemi, as further documented on
[their website](https://www.biosemi.com/faq/cms&drl.htm).

For a formatted example on how to deal with this in the BIDS context, please see
this
[template](https://github.com/bids-standard/bids-starter-kit/blob/main/templates/sub-01/ses-01/eeg/sub-01_ses-01_task-ReferenceExample_eeg.json).

### How to specify units in microVolt?

BIDS requires physical units to be specified according to the SI unit symbol and
possibly prefix symbol (for example: mV, μV for milliVolt and microVolt). In
Matlab use `native2unicode(181,'latin1')` to get the correct symbol for micro.

## BIDS and NWB

### Are BIDS and NWB compatible?

Yes, BIDS and NWB are compatible.

### How to combine BIDS and NWB?

An NWB data file is an allowed format in the iEEG-BIDS data structure. This
means that one subject (AAA) with a session (BBB) can have a BIDS folder with
raw iEEG data in NWB format:

```
/sub-AAA/ses-BBB/ieeg/sub-AAA_ses-BBB_task-rest_ieeg.nwb
```

The same subject can have another session (CCC) with raw fMRI data in BIDS:

```
/sub-AAA/ses-CCC/func/sub-AAA_ses-CCC_task-rest_bold.nii.gz
```

## Phenotypes

### How to store subject phenotypes?

In the phenotype folder, according to the details provided for
[phenotypes](https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#phenotypic-and-assessment-data):
`bids-root/phenotype`

### Is there a standard for epilepsy phenotypes?

Yes, open this
[epilepsyClassification2017](https://github.com/bids-standard/bids-starter-kit/blob/main/interactiveTreeVisualization/epilepsyClassification2017/tree.html)
and follow the examples in the
[phenotype templates](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/phenotype).
