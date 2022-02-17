# Annotating a BIDS dataset

**Contents:** 
* [What is annotation?](#what-is-annotation)
* [Required BIDS annotation files](#required-bids-annotation-files)
  * [Dataset sourcing](#dataset-sourcing-dataset_descriptionjson)
  * [Dataset description](#dataset-description-readme)
  * [Subject information](#subject-information-participantstsv-and-participantsjson)
* [Event annotation](#event-annotation)
  * [Why is event annotation necessary?](#why-is-event-annotation-necessary)
  * [The event annotation process](#the-event-annotation-process)

### What is annotation?

Annotation refers to metadata that is directly associated with  data.
Without adequate annotation, your valuable shared data may be of limited
use to other researchers and to you in the future.

While the BIDS requirements for annotation are limited,
BIDS supports a framework for inserting comprehensive
data annotation at several levels in the dataset.
This tutorial provides a step-by-step process for data annotation in the BIDS framework.

### Required BIDS annotation files

#### Dataset sourcing (`dataset_description.json`)

`dataset_description.json` is a top-level file that gives details about the source of the dataset, funding, and citation information.
This file does not provide any actual description of the data.

> You can fill in this blank [dataset description template](../../templates/dataset_description.json) or use it as a guide.

#### Dataset description (`README`)
`README` file is a top-level text file that gives the actual overview of the dataset.
A comprehensive `README` is essential for users of your data.

> You can edit the [README template](../../templates/README) with the vital information needed for others to analyze your dataset.


#### Subject information (`participants.tsv` and `participants.json`)
`participants.tsv` is a top-level tab-separated value file that provides subject information such as age, sex, and handedness.
Each subject in the dataset should have a row in `participants.tsv`.

Each type of metadata is provided in a column in this file,
and the nature of the column data is described in the top-level
`participant.json` file. 

Other subject information such as diagnosis or group may be provided
in the `participants.tsv` and its corresponding `participants.json` files.
Any such information makes your data more valuable to users. 

> You can edit the [participants.tsv template](../../templates/participants.tsv) and the corresponding 
[participants.json template](../../templates/participants.json)
to provide this information.


### Event annotation

#### Why is event annotation necessary?
Events provide the crucial linkage between what happens in the experiment
and the data itself. 
Without the information provided by the dataset events,
many types of datasets cannot be analyzed.
Beyond marking experimental stimuli, participant responses, instructions,
and feedback, events can also mark the initiation and termination of tasks and experimental conditions.

#### BIDS minimum requirements

Events in BIDS are marked by providing `events.tsv` files associated with data recordings.
These tab-separated files have rows corresponding to the individual events and 
columns corresponding to information about the corresponding event.

BIDS requires that `events.tsv` files have an `onset` column marking the
time of the time that the event occurred in seconds relative to the start
of the correspondingly named data recording file.
The `events.tsv` files must also have a `duration` column indicating
the duration of the event in seconds.
At the present time, many datasets model events as instantaneous
and use `n\a` in the duration column.

Usually, `events.tsv` files have additional columns containing
information about the events. Optional columns include `sample`,
`trial_type`, `response_time`, `value`, and `HED`.
The `events.tsv` files may contain an arbitrary number of additional columns.
All of these optional columns are dataset-specific,
and without additional documentation will be meaningless to dataset users.

BIDS **allows**, but **does not require** documentation about the meanings
of the `events.tsv` file columns and their meanings in a similarly-named
`events.json` files referred to as JSON sidecars.

#### Text descriptions of events
The BIDS JSON sidecar format accommodates text descriptions of the meanings
and contents of various contents of various event file columns in the
`Description` and `Levels` keys.
At a minimum, good text descriptions of these is needed in order
for users to correctly use the data.

#### Machine actionable event annotation

The difficulty with just providing text descriptions of the
event file columns and their contents is that users will usually
be required to write custom code to use your data.
BIDS supports [Hierarchical Event Descriptors (HED)](https://hed-specification.readthedocs.io/en/latest/index.html)
which is an infrastructure and a controlled vocabulary that allows you to 
annotate your events in manner that can be used directly by tools.

**Remember:** most users will not be able to work with your dataset
without having meaningful information about the dataset events.

#### Additional information
(See [Task events](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/05-task-events.html) and
[Appendex III: Hierarchical Event Descriptors](https://bids-specification.readthedocs.io/en/stable/99-appendices/03-hed.html) in the 
[BIDS specification](https://bids-specification.readthedocs.io/en/stable/)
for an overview of events before getting started with your own annotation.)

#### The event annotation process

The goal of event annotation is to provide the information about events
needed for effective and correct analysis of the data.

Ideally most of this information should be in a single `events.json` sidecar
file located in the root directory of your dataset
where it is easy to find and update.

There are several online tools available at
[https://hedtools.ucsd.edu/hed](https://hedtools.ucsd.edu/hed)
to help you during this process:

1. You can extract a JSON sidecar template that is ready to fill in
from a representative `events.tsv` file in your BIDS dataset.
A step-by-step tutorial for doing this can be found in the
[Event annotation quickstart](https://hed-examples.readthedocs.io/en/latest/EventAnnotationQuickStart.html).

2. Once you have a template, you can start editing the template directory,
or you can convert the template to a spreadsheet and edit your 
annotations in Excel or other tool.
Instructions for doing this are available in the
[Spreadsheet template tutorial](https://hed-examples.readthedocs.io/en/latest/EventAnnotationQuickStart.html#spreadsheet-templates).

3. Guidance on the annotation process using HED tags is provided in
a series of [HED tagging tutorials](https://hed-examples.readthedocs.io/en/latest/BasicHEDAnnotation.html).
