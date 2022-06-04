# README

The README is usually the starting point for researchers using your data
and serves as a guidepost for users of your data. A clear and informative
README makes your data much more usable.

In general you can include information in the README that is not captured by some other
files in the BIDS dataset (dataset_description.json, events.tsv, ...).

It can also be useful to also include information that might already be
present in another file of the dataset but might be important for users to be aware of
before preprocessing or analysing the data.

If the README gets too long you have the possibility to create a `/doc` folder
and add it to the `.bidsignore` file to make sure it is ignored by the BIDS validator.

More info here: https://neurostars.org/t/where-in-a-bids-dataset-should-i-put-notes-about-individual-mri-acqusitions/17315/3

## Details related to access to the data

- [ ] Data user agreement

If the dataset requires a data user agreement, link to the relevant information.

- [ ] Contact person

Indicate the name and contact details (email and ORCID) of the person responsible for additional information.

- [ ] Practical information to access the data

If there is any special information related to access rights or
how to download the data make sure to include it.
For example, if the dataset was curated using datalad,
make sure to include the relevant section from the datalad handbook:
http://handbook.datalad.org/en/latest/basics/101-180-FAQ.html#how-can-i-help-others-get-started-with-a-shared-dataset

## Overview

- [ ] Project name (if relevant)

- [ ] Year(s) that the project ran

If no `scans.tsv` is included, this could at least cover when the data acquisition
starter and ended. Local time of day is particularly relevant to subject state.

- [ ] Brief overview of the tasks in the experiment

A paragraph giving an overview of the experiment. This should include the
goals or purpose and a discussion about how the experiment tries to achieve
these goals.

- [ ] Description of the contents of the dataset

An easy thing to add is the output of the bids-validator that describes what type of
data and the number of subject one can expect to find in the dataset.

- [ ] Independent variables

A brief discussion of condition variables (sometimes called contrasts
or independent variables) that were varied across the experiment.

- [ ] Dependent variables

A brief discussion of the response variables (sometimes called the
dependent variables) that were measured and or calculated to assess
the effects of varying the condition variables. This might also include
questionnaires administered to assess behavioral aspects of the experiment.

- [ ] Control variables

A brief discussion of the control variables --- that is what aspects
were explicitly controlled in this experiment. The control variables might
include subject pool, environmental conditions, set up, or other things
that were explicitly controlled.

- [ ] Quality assessment of the data

Provide a short summary of the quality of the data ideally with descriptive statistics if relevant
and with a link to more comprehensive description (like with MRIQC) if possible.

## Methods

### Subjects

A brief sentence about the subject pool in this experiment.

Remember that `Control` or `Patient` status should be defined in the `participants.tsv`
using a group column.

- [ ] Information about the recruitment procedure
- [ ] Subject inclusion criteria (if relevant)
- [ ] Subject exclusion criteria (if relevant)

### Apparatus

A summary of the equipment and environment setup for the
experiment. For example, was the experiment performed in a shielded room
with the subject seated in a fixed position.

### Initial setup

A summary of what setup was performed when a subject arrived.

### Task organization

How the tasks were organized for a session.
This is particularly important because BIDS datasets usually have task data
separated into different files.)

- [ ] Was task order counter-balanced?
- [ ] What other activities were interspersed between tasks?

- [ ] In what order were the tasks and other activities performed?

### Task details

As much detail as possible about the task and the events that were recorded.

### Additional data acquired

A brief indication of data other than the
imaging data that was acquired as part of this experiment. In addition
to data from other modalities and behavioral data, this might include
questionnaires and surveys, swabs, and clinical information. Indicate
the availability of this data.

This is especially relevant if the data are not included in a `phenotype` folder.
https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#phenotypic-and-assessment-data

### Experimental location

This should include any additional information regarding the
the geographical location and facility that cannot be included
in the relevant json files.

### Missing data

Mention something if some participants are missing some aspects of the data.
This can take the form of a processing log and/or abnormalities about the dataset.

Some examples:

- A brain lesion or defect only present in one participant
- Some experimental conditions missing on a given run for a participant because
  of some technical issue.
- Any noticeable feature of the data for certain participants
- Differences (even slight) in protocol for certain participants.

### Notes

Any additional information or pointers to information that
might be helpful to users of the dataset. Include qualitative information
related to how the data acquisition went.
