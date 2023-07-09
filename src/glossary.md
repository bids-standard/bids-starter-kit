# BIDS jargon busting

<img align="right" width="35%" src="https://imgs.xkcd.com/comics/period_speech.png" alt="XKCD comic 771"/>

**_Simple definitions for any BIDS related terms_**

Make sure to also check the
[official glossary](https://bids-specification.readthedocs.io/en/latest/99-appendices/14-glossary.html)
that lists all the terms of the BIDS specification.

We know that when you're getting started with something new there are often jargon-y words
that make understanding everything that's going on kinda hard.

The point of this list is to give you a place to go
to figure out some of those terms that "everyone" seems to know.

Please add to this list! It will always be 👷 **in construction** 🚧
and we really encourage everyone to update it to be more useful.
If there's a word you don't know,
there's almost certainly someone else who doesn't know what it means either.

**If you are unsure about a term/definition that you are adding, please add it anyway and add an asterix(\*) to signal that you want it reviewed.**

## General resources

## BIDS Terms

<!-- ### 0-9 -->

### A

#### **acquisition**:

One continuous block of a scan.

### B

#### **BIDS**:

Brain Imaging Data Structure - a standardised way to organise your neuroimaging
data.

-   http://bids.neuroimaging.io

### C

#### **channel**:

The combination of the differential amplifier and the analog-to-digital converter
that results in the potential different (for EEG and iEEG)
or magnetic field or gradient (for MEG) to end up on disk.
This should not be confused with [**electrode**](#electrode).

#### **container**:

A container is a file which packages all the software
and instructions required to perform a series of tasks.

### D

#### **derivatives**:

Processed (for instance: non-raw) data.

#### **dataset**:

Collection of data that can include many subjects or sessions.

### E

#### **electrode**:

The small metal disk that is in contact with the scalp (EEG)
or directly touching the brain (iEEG).
This should not be confused with the EEG or iEGG [**channel**](#channel).

#### **extensions**:

Branches of BIDS that are for specific types of data (for instance: PET).

### F

#### **file extension**:

A file extension is the suffix following the last `.` in a filename,
for example the `.jpeg` in `dog.jpeg`.
These exist to give us instructions on how to interpret files.
File extensions that are important in BIDS are [`.json`](#JSON), `.nii`, [`.tsv`](#TSV)

### H

#### **heuristic file**:

A file that can sort your data into categories based on naming patterns

### I

#### **inheritance**:

Any metadata file (.json, .bvec, .tsv, and so on.) may be defined at any
directory level. The values from the top level are inherited by all lower levels
unless they are overridden by a file at the lower level.

### J

#### **JSON**:

A JSON file can be thought of as a form or as a list of name-value pairs.
Example:

```json
{"firstName": "John", "lastName": "Smith"}
```

-   You can find more information about `json` files
    in the [Metadata file formats](./folders_and_files/metadata.md#json-files) page.

### M

#### **metadata**:

Supporting data that describes your main data (for instance: data about data).
For example if your main data is an MRI image your metadata might be information
about the date and time of imaging, the image type, the machine serial number and so on.
An example: "Scan Date" would be metadata that describes the date at which you acquired the actual data.

### O

#### **open science**:

Scientific research and data that is free and available for everyone to benefit
from.

### P

#### **parameter**:

Generally speaking, a parameter is numerical variable
that we (scientists, computer programs, and so on)
are able to manipulate in order to change outcomes.

### R

#### **README**:

A readme is a text file.
The readme's purpose is to provide explanation
and documentation for the contents of the folder it lives in.

### S

#### **subject**:

A person / animal / object participating in a study.

#### **session**:

An uninterrupted period that a subject is in a specific lab.
This often corresponds to a lab visit.
See also this
[definition](https://bids-specification.readthedocs.io/en/stable/02-common-principles.html#definitions).

#### **sequence**:

A combination of settings on the MR scanner that determine the way the MR data is acquired.
This includes the TE, TR, FOV, in-plane resolution, slice spacing, and so on.

#### **sidecar** (as in json sidecar):

A json file associated to a nii file
(usually by having the same name preceding the [file extension](#f)).
Together these make up an acquisition;
the nii file contains the image and the json contains various [metadata](#m).

#### **sourcedata**:

Raw data (or metadata) in its original format prior to conversion to BIDS,
for example: images in DICOM format,
EEG data in a proprietary format or presentation log files.

### T

#### **tsv**:

TSV stands for **t**ab **s**eparated **v**alues.
A .tsv file contains a table (like a simple excel spreadsheet) containing text.
Table values are separated by tabs.

-   You can find more information about `TSV` files
    in the [Metadata file formats](./folders_and_files/metadata.md#tsv-files) page.

### U

#### **URI**:

Stands for **U**niform **R**esource **I**dentifier.
It is a very general term to describe the "address" of an "object" on the web.
A type of URI many of us are familiar with is an URL (Uniform Resource Locator)
that points to a webpage, an image...
Another very common type is a DOI (Digital Object Identifiers)
that can be used to point to a scientific article,
a data or code archive (for example on Zenodo, figshare...)
