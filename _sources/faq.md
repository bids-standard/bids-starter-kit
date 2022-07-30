# Frequently Asked Questions

As this starter-kit grows it gets harder to know where to find information, so this
page is a collection of frequently asked questions.

Please add to this list! It will always be :construction: **in construction**
:construction: and we really encourage everyone to update it to be more useful.
If there's a question you've asked or answered more than twice then it's an FAQ
and it should be in the repository.

Ideally the questions will link to an answer elsewhere in the repository to
maximise the different ways of finding out more about BIDS.

```{note}
For questions related to the BIDS apps, 
please visit [the BIDS apps website](https://bids-apps.neuroimaging.io/dev_faq/).
```

## General questions

### What is a `json` file?

You can find more information about `json` (and `tsv`) files in the
[Metadata-file-formats](./folders_and_files/metadata.md) page.

### What does [this word] mean?

We're building a glossary to de-jargonise some of the terms you need to know to
work with data in BIDS format. Check it out [here](./glossary.md).

### How to specify the micro sign in Matlab?

The symbol used to indicate `µ` has unicode U+00B5, which is in Matlab
char(181).

### Is your data type not covered in the current BIDS specification?

BIDS extensions proposals
[(BEPs)](https://bids.neuroimaging.io/get_involved.html#extending-the-bids-specification)
aim to extend the BIDS specification to new data types. A list of extensions
proposals can be found [on the main BIDS webpage](https://bids.neuroimaging.io/)
under
[Get Involved](https://bids.neuroimaging.io/get_involved.html#extending-the-bids-specification).
Guidelines for contributing to these extensions or starting your own can be
found in the
[BIDS Extension Proposals Guide](https://docs.google.com/document/d/1pWmEEY-1-WuwBPNy5tDAxVJYQ9Een4hZJM06tQZg8X4/edit).

If only part of your data is covered under BIDS, an option to allow additional
files currently not covered in BIDS to pass the validator is the
[.bidsignore](https://github.com/bids-standard/bids-validator/blob/master/bids-validator/README.md) file,
which works just like [.gitignore](https://git-scm.com/docs/gitignore). It
allows you to list all the files (or directories, with wildcards) that are not
BIDS compliant and should be ignored by the validator. Of course you should
still try to adhere to upcoming BEPs and the general BIDS philosophy for file
names and metadata where possible, but this gives a little extra flexibility.

### How do I convert my data to BIDS?

We strongly recommend you pick a BIDS converter to help you convert your data.

A list of converters can be found [on the BIDS website](https://bids.neuroimaging.io/benefits.html#converters)

### How to import Excel files?

See these bids tools to import and export a participants.tsv file:
[bids-matlab-tools](https://github.com/sccn/bids-matlab-tools/blob/master/bids_spreadsheet2participants.m)

(faq_session)=
### I had to split the testing of one of my participants across 2 days, should I use 2 different session folders to organize the data of that participant?

No. The `session` level in the BIDS folder hierarchy can be used to group data
that go "logically" together: this means that you can put in the same `session`
folder data that were acquired on different days, but that are "linked" to one
another in a way that make sense to how you want to organize your data.

If you want to keep track of what data was acquired when you can use the
[`scans.tsv` files](https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#scans-file).

For some examples, see this
[issue in the bids-starter kit](https://github.com/bids-standard/bids-starter-kit/issues/193).

If you deal with EEG data, you may want to read this
[comment in another issue](https://github.com/bids-standard/bids-starter-kit/issues/265#issuecomment-1082240834)
as well before considering combining within the same `session` folder
recordings acquired on different occasions.
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
-   SPM8 and SPM12: when in the batch editor fo to --> SPM menu --> Util -->
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
