# Using BIDS with Python

The BIDS format has several tools in the Python ecosystem. These are broadly
split into two groups: one for converting and storing data in the BIDS format,
and another for analyzing and manipulating pre-existing BIDS datasets.

## Converting your data to BIDS

* [mne-bids](https://github.com/mne-tools/mne-bids) is a collection
  of tools for converting magnetoencephalography (MEG) data into BIDS format, as well as some
  helper functions for creating the folders and metadata needed for a BIDS
  dataset. Check out their [online documentation](http://mne-tools.github.io/mne-bids/)
  and the [examples gallery](https://mne-tools.github.io/mne-bids/auto_examples/index.html)
  to learn how to use this package.
* In addition, this repository contains some helper scripts to facilitate creating your
  BIDS dataset. See the `.py` files in this folder for the most up-to-date set of scripts.

## Analyzing your BIDS datasets

* [pybids](https://github.com/INCF/pybids) is a tool for quickly parsing / searching
  the components of a BIDS dataset. It also contains functionality for running analyses
  on your data.
