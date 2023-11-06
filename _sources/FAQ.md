
# Frequently Asked Questions

As this starter-kit grows it gets harder to know where to find information,
so this page is a collection of frequently asked questions.

Please add to this list!

It will always be 🚧 **in construction** 🚧
and we really encourage everyone to update it to be more useful.
If there's a question you've asked or answered more than twice
then it's an FAQ and it should be in the repository.

Ideally the questions will link to an answer elsewhere in the repository
to maximise the different ways of finding out more about BIDS.

```{note}
For questions related to the BIDS apps,
please visit [the BIDS apps website](https://bids-apps.neuroimaging.io/dev_faq/).
```

---

<!-- the section below is automatically generated.

If you want to modify the questions:
- please edit the files in the `src/questions` folder.
- run `faqtory build` from the root of the repository.

-->

## EEG: How to format Hardware and Software filter fields in a .json?

In the modality specific sidecar file `_eeg.json`, we can specify the software
and hardware filters that were applied during the collection or processing of the data.
Generally, there are two accepted formats for that:

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

## EEG: How to specify EEGReference and EEGGround for Biosemi referencing scheme?

Reference and ground electrodes for EEG data can usually be specified
using the `EEGReference` and `EEGGround` fields
in the modality specific sidecar file `_eeg.json`.
Both fields accept a string value such as `"Placed on Cz"`.

However, some manufacturers use special referencing schemes
such as the combination of a "Common Mode Sense" (CMS) and a "Driven Right Leg" (DRL) electrode.
This is the case for Biosemi, as further documented on
[their website](https://www.biosemi.com/faq/cms&drl.htm).

For a formatted example on how to deal with this in the BIDS context,
please see this
[template](https://github.com/bids-standard/bids-starter-kit/blob/main/templates/sub-01/ses-01/eeg/sub-01_ses-01_task-ReferenceExample_eeg.json).

## General: Can I combine BIDS and neurodata without border (NWB)?

BIDS and [NWB](https://www.nwb.org/) are compatible.

An NWB data file is an allowed format in the iEEG-BIDS data structure.
This means that one subject (AAA) with a session (BBB)
can have a BIDS folder with raw iEEG data in NWB format:

```
/sub-AAA/ses-BBB/ieeg/sub-AAA_ses-BBB_task-rest_ieeg.nwb
```

The same subject can have another session (CCC) with raw fMRI data in BIDS:

```
/sub-AAA/ses-CCC/func/sub-AAA_ses-CCC_task-rest_bold.nii.gz
```

## General: How can I cite BIDS?

See the specification website for the
[main publications](https://bids-specification.readthedocs.io/en/latest/01-introduction.html#citing-bids)
related to BIDS and its extensions.

BIDS references are centralized in a [zotero group](https://www.zotero.org/groups/5111637/bids).

## General: How do I convert my data to BIDS?

We strongly recommend you pick a BIDS converter to help you convert your data.

A list of converters can be found [on the BIDS website](https://bids.neuroimaging.io/benefits.html#converters)

Also look at [the list of tutorials and information about conversions](./tutorials/tutorials.md).

## General: How should I organize data for hyperscanning data?

Hyperscanning is simultaneous fMRI with multiple subjects (see this [paper](https://doi.org/10.1006/nimg.2002.1150)).

- See this [issue](https://github.com/bids-standard/bids-specification/issues/402)
  in the bids specification repository for typical hyperscanning data.

See an example below with fMRI data:

```
sub-01/
    ses-dyadic1/
        func/
            sub-01_ses-dyadic1_*
sub-02/
    ses-dyadic1/
        func/
            sub-02_ses-dyadic1_*
sub-03/
    ses-dyadic2/
        func/
            sub-03_ses-dyadic2_*
sub-04/
    ses-dyadic2/
        func/
            sub-04_ses-dyadic2_*
```

- See this [post on neurostars](https://neurostars.org/t/bids-structure-for-longitudinal-dyadic-data/26173)
  for hyperscanning longitunal data.

See an example below with fMRI data:

```
sub-S001/
    ses-1/
        func/
            sub-S001_ses-1_task-video_acq-dyad001_bold.nii.gz
    ses-2/
sub-S002/
    ses-1/
        func/
            sub-S002_ses-1_task-video_acq-dyad001_bold.nii.gz
    ses-2/
sub-S003/
    ses-1/
        func/
            sub-S003_ses-1_task-video_acq-dyad002_bold.nii.gz
    ses-2/
```


- See this [thread on the bids discussion forum](https://groups.google.com/g/bids-discussion/c/v660DuzOf3w/m/q-0PLHt5BgAJ)

## General: How to import Excel files to TSV file?

See [our sections on TSV files](./folders_and_files/metadata.md#tsv-files) for more information.

See also this bids tool to import and export a `participants.tsv` file:
[bids-matlab-tools](https://github.com/sccn/bids-matlab-tools/blob/master/bids_spreadsheet2participants.m)

## General: How to specify the micro sign in MATLAB?

BIDS requires physical units to be specified according to the SI unit symbol and
possibly prefix symbol (for example: mV, μV for milliVolt and microVolt).

The symbol used to indicate `µ` has unicode U+00B5, which is in MATLAB:

```matlab
char(181)
```

or

```matlab
native2unicode(181, 'latin1')
```

## General: I had to split the testing of one of my participants across 2 days, should I use 2 different session folders to organize the data of that participant?

(faq_session)=

No. The `session` level in the BIDS folder hierarchy can be used to group data
that go "logically" together: this means that you can put in the same `session` folder
data that were acquired on different days,
but that are "linked" to one another in a way that make sense to how you want to organize your data.

If you want to keep track of what data was acquired when you can use the
[`scans.tsv` files](https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#scans-file).

For some examples, see this
[issue in the bids-starter kit](https://github.com/bids-standard/bids-starter-kit/issues/193).

If you deal with EEG data, you may want to read this
[comment in another issue](https://github.com/bids-standard/bids-starter-kit/issues/265#issuecomment-1082240834)
as well before considering combining recordings acquired on different occasions
within the same `session` folder.

## General: Is there a machine readable version of the BIDS specification?

Yes. The BIDS specification exist as a schema.
The BIDS schema is a machine readable representation of the BIDS Standard.
It is (by and large) the BIDS Specification, but written in a declarative form.

The BIDS schema is available in two machine readable formats:

- as a set of [YAML](https://en.wikipedia.org/wiki/YAML) files in the [BIDS specification repository](https://github.com/bids-standard/bids-specification/src/schema)
- as a [single json file](https://bids-specification.readthedocs.io/en/stable/schema.json)

A light-weight introduction to the schema can be found [here](https://bids-extensions.readthedocs.io/en/latest/schema/).

A full description of the schema can be found on this [website](https://bidsschematools.readthedocs.io/en/latest/?badge=latest)
where you will also find the documentation for the python package
to interact with the schema, [bidsschematools](https://pypi.org/project/bidsschematools/).

## General: Is your data type not covered in the current BIDS specification?

BIDS extensions proposals [(BEPs)](https://bids.neuroimaging.io/get_involved.html#extending-the-bids-specification)
aim to extend the BIDS specification to new data types.
A list of extensions proposals can be found below.

Guidelines for contributing to these extensions or starting your own can be found
in the [BIDS Extension Proposals Guide](https://bids-extensions.readthedocs.io/en/latest/).

If only part of your data is covered under BIDS, an option to allow additional files
currently not covered in BIDS to pass the validator is
the [.bidsignore](https://github.com/bids-standard/bids-validator/blob/master/bids-validator/README.md) file,
which works just like [.gitignore](https://git-scm.com/docs/gitignore).
It allows you to list all the files (or directories, with wildcards)
that are not BIDS compliant and should be ignored by the validator.
Of course you should still try to adhere to upcoming BEPs
and the general BIDS philosophy for file names and metadata where possible,
but this gives a little extra flexibility.

<!-- TEMPLATE STARTS -->

### raw

- BEP004: [Susceptibility Weighted Imaging (SWI)](https://bids.neuroimaging.io/bep004)
- BEP020: [Eye Tracking including Gaze Position and Pupil Size](https://bids.neuroimaging.io/bep020)
- BEP022: [Magnetic Resonance Spectroscopy (MRS)](https://bids.neuroimaging.io/bep022)
- BEP024: [Computed Tomography scan (CT)](https://bids.neuroimaging.io/bep024)
- BEP026: [Microelectrode Recordings](https://bids.neuroimaging.io/bep026)
- BEP029: [Virtual and physical motion data](https://bids.neuroimaging.io/bep029)
- BEP032: [Animal electrophysiology](https://bids.neuroimaging.io/bep032)
- BEP033: [Advanced Diffusion Weighted Imaging (aDWI)](https://bids.neuroimaging.io/bep033)
- BEP036: [Phenotypic Data Guidelines](https://bids.neuroimaging.io/bep036)
- BEP037: [Non-Invasive Brain Stimulation (NIBS)](https://bids.neuroimaging.io/bep037)
- BEP038: [Atlases](https://bids.neuroimaging.io/bep038)
- BEP039: [Dimensionality reduction-based networks](https://bids.neuroimaging.io/bep039)
- BEP040: [Functional Ultrasound (fUS)](https://bids.neuroimaging.io/bep040)
### derivative

- BEP011: [Structural preprocessing derivatives](https://bids.neuroimaging.io/bep011)
- BEP012: [Functional preprocessing derivatives](https://bids.neuroimaging.io/bep012)
- BEP014: [Affine transformations and nonlinear field warps](https://bids.neuroimaging.io/bep014)
- BEP016: [Diffusion weighted imaging derivatives](https://bids.neuroimaging.io/bep016)
- BEP017: [Generic BIDS connectivity data schema](https://bids.neuroimaging.io/bep017)
- BEP021: [Common Electrophysiological Derivatives](https://bids.neuroimaging.io/bep021)
- BEP023: [PET Preprocessing derivatives](https://bids.neuroimaging.io/bep023)
- BEP034: [Computational modeling](https://bids.neuroimaging.io/bep034)
- BEP035: [Modular extensions for individual participant data mega-analyses with non-compliant derivatives](https://bids.neuroimaging.io/bep035)
- BEP041: [Statistical Model Derivatives](https://bids.neuroimaging.io/bep041)
### metadata

- BEP027: [BIDS Applications 2.0](https://bids.neuroimaging.io/bep027)
- BEP028: [Provenance](https://bids.neuroimaging.io/bep028)
- BEP034: [Computational modeling](https://bids.neuroimaging.io/bep034)
### file format

## General: What does [this word] mean?

We're building a glossary to de-jargonise some of the terms you need to know to
work with data in BIDS format. Check it out [here](./glossary.md).

## General: What is a `json` file?

You can find more information about `json` (and `tsv`) files in the
[Metadata-file-formats](./folders_and_files/metadata.md#json) page.

## General: What liense should I choose for my dataset?

If you want to know more about what license to choose for your dataset,
see the [turing way](https://the-turing-way.netlify.app/reproducible-research/licensing/licensing-data.html#data-licenses)
page dedicated to this topic.

If you plan to put your dataset on [openneuro](https://openneuro.org/),
you should use a CC0 or a PDDL license as explained in their [FAQ](https://openneuro.org/faq).

## MRI: What defacing tools can I use?

If you want to share your BIDS data set, chances are that you will have to anonymize it
and therefore prevent identification of the participants from their anatomical scans.
You will need to de-identification (or deface) the anatomical images.
There are several options to do that

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
-   SPM8 and SPM12: when in the batch editor go to:
    `SPM menu --> Util --> Deface`

## Phenotype: How can I store subject phenotypic data?

In the phenotype folder, according to the details provided for
[phenotypes](https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#phenotypic-and-assessment-data):

```
bids-root
    phenotype
```

Please the see work on the [BIDS extension proposal for phenotypes](https://bids.neuroimaging.io/bep036)
for more guidelines.

## Phenotype: Is there a standard for epilepsy phenotypes?

Yes, open this
[epilepsyClassification2017](https://github.com/bids-standard/bids-starter-kit/blob/main/interactiveTreeVisualization/epilepsyClassification2017/tree.html)
and follow the examples in the
[phenotype templates](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/phenotype).

<hr>

Generated by [FAQtory](https://github.com/willmcgugan/faqtory)