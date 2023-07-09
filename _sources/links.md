# Links and resources

## Converters

If you are looking for tools to convert your data into BIDS, please see the
[list of converters on the BIDS website](https://bids.neuroimaging.io/benefits.html#converters)

## Python tools


The BIDS format has several tools in the Python ecosystem. These are broadly
split into two groups: one for converting and storing data in the BIDS format,
and another for analyzing and manipulating pre-existing BIDS datasets.

### Converting your data to BIDS

-   [mne-bids](https://github.com/mne-tools/mne-bids) is a collection of tools
    for converting magnetoencephalography (MEG) data into BIDS format, as well
    as some helper functions for creating the folders and metadata needed for a
    BIDS dataset. Check out their
    [online documentation](http://mne-tools.github.io/mne-bids/) and the
    [examples gallery](https://mne.tools/mne-bids/stable/index.html) to learn
    how to use this package.

### Analyzing your BIDS datasets

-   [pybids](https://github.com/INCF/pybids) is a tool for quickly parsing /
    searching the components of a BIDS dataset. It also contains functionality
    for running analyses on your data.

[BIDS tools](https://github.com/robertoostenveld/bids) - some command-line tools
to support a general BIDS workflow and some
[Donders](https://www.ru.nl/donders/) specific documentation

## MATLAB tools

[bids-matlab](https://github.com/bids-standard/bids-matlab) - functions that
allow you to crawl through your BIDS dataset and get info about it

FieldTrip [data2bids](https://github.com/fieldtrip/fieldtrip/blob/release/data2bids.m)
function to convert existing MEG, EEG, iEEG but also MRI datasets to BIDS. See
[here](http://www.fieldtriptoolbox.org/example/bids/) for examples.

[MATLAB code for MEG-BIDS](https://github.com/lorenzomagazzini/mat-meg-bids)

### SPM

[BIDS tools in SPM](https://en.wikibooks.org/wiki/SPM/BIDS)
