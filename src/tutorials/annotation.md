# Annotating a BIDS dataset

## What is annotation?

Annotation refers to metadata that is directly associated with  data.
Without adequate annotation, your valuable shared data may be of limited
use to other researchers and to you in the future.

While the BIDS requirements for annotation are limited,
BIDS supports a framework for inserting comprehensive
data annotation at several levels in the dataset.
This tutorial provides a step-by-step process for data annotation in the BIDS framework.

Annotations in BIDS can be done at several levels including the dataset, subjects, sessions, scans and events.

## Required BIDS annotation files

### Dataset sourcing (`dataset_description.json`)

`dataset_description.json` is a top-level file that gives details about the
source of the dataset, funding, and citation information.
This file does not provide any actual description of the data.

> You can fill in this blank [dataset description template](https://raw.githubusercontent.com/bids-standard/bids-starter-kit/main/templates/dataset_description.json) or use it as a guide.

### Dataset description (`README`)
`README` file is a top-level text file that gives the actual overview of the dataset.
A comprehensive `README` is essential for users of your data.

> You can edit the [README template](https://raw.githubusercontent.com/bids-standard/bids-starter-kit/main/templates/README.MD) with the vital information needed for others to analyze your dataset.

## Subject annotations
Annotations at the subject level can be done in the `participants.tsv` file,
which is a top-level tab-separated value file that provides
subject information such as age, sex, and handedness.
Each subject in the dataset should have a row in `participants.tsv`.

Each type of metadata is provided in a column in this file,
and the nature of the column data is described in the top-level
`participants.json` file.

Other subject information such as diagnosis or group may be provided
in the `participants.tsv` and its corresponding `participants.json` files.
Any such information makes your data more valuable to users.

> You can edit the [participants.tsv template](https://raw.githubusercontent.com/bids-standard/bids-starter-kit/main/templates/participants.tsv) and the corresponding
[participants.json template](https://raw.githubusercontent.com/bids-standard/bids-starter-kit/main/templates/participants.json)
to provide this information.

If the dataset includes multiple sets of participant level measurements see the BIDS guidelines
for adding [phenotypic and assessment data](https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#phenotypic-and-assessment-data).

## Session annotations

At the session level, the optional `sessions.tsv` and `sessions.json` files can be used to add
annotations that apply to an entire session.

## Scans/run annotations

At the scans or run level, the optional `scans.tsv` and `scans.json` files can be used to add
annotations that apply to an entire run.

## Event annotations

### Why is event annotation necessary?
Events provide the crucial linkage between what happens in the experiment
and the data itself.
Without the information provided by the dataset events,
many types of datasets cannot be analyzed.

Beyond marking experimental stimuli, participant responses, instructions,
and feedback, events can also mark the initiation and termination of tasks and experimental conditions.

### BIDS event infrastructure

Events in BIDS are marked by providing `events.tsv` files associated with data recordings.
These tab-separated files have rows corresponding to the individual event markers and
columns corresponding to information about the corresponding event.

#### BIDS minimum requirements
BIDS requires that `events.tsv` files have an `onset` column marking the
time of the time that the event occurred in seconds relative to the start
of the correspondingly named data recording file.
The `events.tsv` files must also have a `duration` column indicating
the duration of the event in seconds.
At the present time, many datasets model events as instantaneous
and use `n/a` in the duration column.

Usually, `events.tsv` files have additional columns containing
information about the events. Optional columns include `sample`,
`trial_type`, `response_time`, `value`, and `HED`.

The `events.tsv` files **may** contain an arbitrary number of additional columns.
All the optional columns are dataset-specific,
and without additional documentation will be meaningless to dataset users.

BIDS **allows**, but **does not require** documentation about the meanings
of the `events.tsv` file columns in similarly-named
`events.json` files referred to as JSON sidecars.

#### Text descriptions of events
The BIDS JSON sidecar format accommodates text descriptions of the meanings
and contents of event file columns in the
`Description` and `Levels` keys.

At a minimum, good text descriptions of the event file columns is needed in order
for users to correctly use the data.

#### Machine actionable annotation with HED

The difficulty with just providing text descriptions of the
event file columns and their contents is that users will usually
be required to write custom code to use your data.

BIDS supports [Hierarchical Event Descriptors (HED)](https://hed-examples.readthedocs.io/en/latest/index.html),
which is an infrastructure and a controlled vocabulary that allows you to
annotate your events in manner that can be used directly by tools.

**Remember:** most users will not be able to work with your dataset
without having meaningful information about the dataset events.

#### Additional information
See [Task events](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/05-task-events.html) and
[Appendix III: Hierarchical Event Descriptors](https://bids-specification.readthedocs.io/en/stable/99-appendices/03-hed.html)
in the [BIDS specification](https://bids-specification.readthedocs.io/en/stable/)
for an overview of events before getting started with your own annotation.

The next section provides an overview of the event annotation process
and links to helpful guides and tutorials with the details.

### The event annotation process

The goal of event annotation is to provide the information about events
needed for effective and correct analysis of the data.

Ideally most of this information should be in a single `events.json` sidecar
file located in the root directory of your dataset
where it is easy to find and update.

An overview of how event annotation works in BIDS as well as tutorials
about using available online tools to facilitate annotation can be found in the
[BIDS annotation quickstart](https://hed-examples.readthedocs.io/en/latest/BidsAnnotationQuickstart.html).

There are several online tools available at
[https://hedtools.ucsd.edu/hed](https://hedtools.ucsd.edu/hed)
to help you during this process:

1. You can extract a ready-to-fill-in JSON sidecar template
from a representative `events.tsv` file in your BIDS dataset.
A step-by-step tutorial for doing this can be found in the
[Create a JSON template tutorial](https://hed-examples.readthedocs.io/en/latest/BidsAnnotationQuickstart.html#create-a-json-template).

2. Once you have a template, you can start editing the template directory,
or you can convert the template to a spreadsheet and edit your
annotations in Excel or other tool.
Instructions for doing this are available in the
[Spreadsheet templates tutorial](https://hed-examples.readthedocs.io/en/latest/BidsAnnotationQuickstart.html#spreadsheet-templates).

This process and templates make it convenient to provide basic
descriptions as well as HED tags for your dataset events.

A [HED annotation quickstart](https://hed-examples.readthedocs.io/en/latest/HedAnnotationQuickstart.html)
outlines a step-by-step process for selecting HED tags during the annotation process.
