# Annotating a BIDS dataset

Annotation refers to metadata that is directly associated with  data.
Without adequate annotation, your valuable shared data may be of limited use to other researchers and to you in the future. 

While the BIDS requirements for annotation are limited, 
BIDS supports a framework for inserting comprehensive
data annotation at several levels in the dataset.
This tutorial provides a step-by-step process for data annotation in the BIDS framework.

### Required BIDS annotation files

#### Dataset sourcing (`dataset_description.json`)

> `dataset_description.json` is a top-level file that gives details about the source of the dataset, funding, and citation information.
> This file does not provide any actual description of the data.
> 
> You can fill in this blank [dataset description template](../../templates/dataset_description.json) or use it as a guide.

#### Dataset description (`README`)
> `README` file is a top-level text file that gives the actual overview of the dataset.
> A comprehensive `README` is essential for users of your data.
> 
> You can edit the [README template](../../templates/README) with the vital information needed for others to analyze your dataset.


#### Subject information (`participants.tsv` and `participants.json`)
>`participants.tsv` is a top-level tab-separated value file that provides subject information such as age, sex, and handedness.
Each subject in the dataset should have a row in `participants.tsv`.
>
> Each type of metadata is provided in a column in this file,
and the nature of the column data is described in the top-level
`participant.json` file. 
>
> Other subject information such as diagnosis or group may be provided
in the `participants.tsv` and its corresponding `participants.json` files.
Any such information makes your data more valuable to users. 
>
> You can edit the [participants.tsv template](../../templates/participants.tsv) and the corresponding 
[participants.json template](../../templates/participants.json)
to provide this information.



## Event annotation

Events provide the crucial linkage between what happens in the experiment
and the data itself. 
Without the information provided by the dataset events,
many types of datasets cannot be analyzed.
Beyond marking experimental stimuli, participant responses, instructions,
and feedback, events can also mark the initiation and termination of tasks and experimental conditions.

Events are annotated, by providing `_events.tsv` files associated with
data recordings. The tab-separated `_events.tsv` files have rows corresponding to the individual events and columns corresponding to
information about the corresponding event. BIDS `_events.tsv` files require `onset`
and `duration` columns, but users are free to include other columns.
These additional columns may be critical for identifying what each event
actually represents.

Associated with the `_events.tsv` file is a `_events.json` file that describes
the meaning of the columns in the corresponding `_events.tsv` file.

It is generally recommended that the meanings of the events file columns and their
contents should be the same for all the recordings in the dataset.
If this is the case, you can create a single `_events.json` file and place
it at the top level in the dataset.
The single  `_events.json` file approach is not only easier,
assures consistency in event annotation.

### Basic event annotation

1. Create a `_events.json` sidecar in the correct form from your `_events.tsv` using an extraction tool.
2. Fill in a descriptions of each element. 

#### Step 1: Create a `_events.json`

There are several tools available to make event annotation easier.
The **Extract sidecar tool** available online at 
[https://hedtools.ucsd.edu/hed/events](https://hedtools.ucsd.edu/hed/events)
allows you to upload an event file and produces a dummy `_events.json` file based on the
contents of the event file.
A step-by-step guide on how to use this tool is available at [not yet done link].

#### Step 2: Fill in the dummy `_events.json` file

The description of each element in this file should be clear.

### Machine-actionable annotation

The difficulty with the minimal event annotation is that the event descriptions
are useful to readers of your data, but cannot be used in computation.
BIDS supports [Hierarchical Event Descriptors (HED)](https://github.com/hed-standard)
which is an infrastructure and a controlled vocabulary that allows you to annotate
your events in manner that can be used directly by tools. 
