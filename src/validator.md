# BIDS validation

The [BIDS Validator](https://github.com/bids-standard/bids-validator) is a tool
that checks if a dataset is compliant with the BIDS standard. The validator is
available for use within several different environments to best suit individual
user preferences and use cases, those versions are:

-   A web browser based version
-   Command line version
-   Docker based version
-   A python library installable via pip

Instructions to install and use these versions can be found within the
[quickstart guide](https://github.com/bids-standard/bids-validator)
at the BIDS Validator repository.

**Data Privacy and Confidentiality**

Please note that the web app is entirely browser(not server) based. As such,
there is no file uploading as part of the validation.

## Browser Version

1. The BIDS Validator can be found at
   <http://bids-standard.github.io/bids-validator/>. It requires that you use
   the Chrome or Firefox browser, since those are the only ones in which you can
   select a whole folder rather than individual files.

<!-- TODO grab that image and add to the repo -->

![home](https://i.imgur.com/YD38eTE.png)

2. You can then choose the **folder** that you wish to validate

### Types of Feedback

#### Error

This response indicates that your dataset is not BIDS compliant. Try following
the suggestions listed to make the appropriate corrections

<!-- TODO grab that image and add to the repo -->

![Error](https://i.imgur.com/PEz9hbd.png)

#### Warning

This response indicates that your dataset is BIDS compliant, but there are some
non-critical problems (such as optional fields missing, or differences between
participants)

<!-- TODO grab that image and add to the repo -->

![Warning](https://i.imgur.com/Gqwc1q9.png)

#### Success

This response indicates that your folder contains a valid BIDS Dataset!

<!-- TODO grab that image and add to the repo -->

![Valid](https://i.imgur.com/DPFVXOR.png)

## Command Line Version

### Verifying a BIDS compliant data set

After
[installation with npm](https://github.com/bids-standard/bids-validator)
using the CLI is trivial. Locate a bids data set similar to the one below:

```bash
user@host:~/bids-examples$ tree sub001/
sub001/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README
└── sub-01
    ├── ses-baseline
    │   ├── anat
    │   │   ├── sub-01_ses-baseline_T1w.json
    │   │   └── sub-01_ses-baseline_T1w.nii.gz
    │   └── pet
    │       ├── sub-01_ses-baseline_pet.json
    │       └── sub-01_ses-baseline_pet.nii.gz
    └── ses-intervention
        ├── anat
        │   ├── sub-01_ses-intervention_T1w.json
        │   └── sub-01_ses-intervention_T1w.nii.gz
        └── pet
            ├── sub-01_ses-intervention_task-eyes_events.json
            ├── sub-01_ses-intervention_task-eyes_events.tsv
            ├── sub-01_ses-intervention_task-eyes_pet.json
            └── sub-01_ses-intervention_task-eyes_pet.nii.gz
```

Now simply point the bids validator at the folder path of the subject(s) in
question:

```bash
user@host:~/bids-examples$ bids-validator sub001
```

### Types of Feedback

#### Error

As is the case w/ the browser or any version of the validator follow the `[ERR]`
messages and correct until bids-validator returns 0 errors after running.

```bash
user@host:~/bids-examples$ bids-validator sub001
bids-validator@1.7.1

 1: [ERR] Invalid JSON file. The file is not formatted according the schema. (code: 55 - JSON_SCHEMA_VALIDATION_ERROR)
  ./sub-01/ses-baseline/pet/sub-01_ses-baseline_pet.json
   Evidence:  should have property InjectedRadioactivityUnits when property InjectedRadioactivity is present
  ./sub-01/ses-baseline/pet/sub-01_ses-baseline_pet.json
   Evidence:  should have required property 'InjectedMassUnits'
  ...
                ...
  ... and 3 more files having this issue (Use --verbose to see them all).

 Please visit https://neurostars.org/search?q=JSON_SCHEMA_VALIDATION_ERROR for existing conversations about this issue.


        Summary:                Available Tasks:        Available Modalities:
        14 Files, 5.72MB                                T1w
        1 - Subject                                     pet
        2 - Sessions                                    events


 If you have any questions, please post on https://neurostars.org/tags/bids.
```

#### Warning

As stated with the browser version above, one may elect to ignore warnings, but
the information provided via the validator should help to pinpoint where and how
to resolve some of these warnings. When in doubt consult the
[BIDS Spec](https://bids-specification.readthedocs.io/en/stable/)

```bash
user@host:~/bids-examples$ bids-validator sub001/
bids-validator@1.7.1

1: [WARN] Tabular file contains custom columns not described in a data dictionary (code: 82 - CUSTOM_COLUMN_WITHOUT_DESCRIPTION)
  ./sub-01/func/sub-01_task-balloonanalogrisktask_run-01_events.tsv
                ...
                ...
... and 38 more files having this issue (Use --verbose to see them all).

 Please visit https://neurostars.org/search?q=CUSTOM_COLUMN_WITHOUT_DESCRIPTION for existing conversations about this issue.


        Summary:                   Available Tasks:                Available Modalities:
        134 Files, 411.53KB        balloon analog risk task        T1w
        16 - Subjects                                              inplaneT2
        1 - Session                                                bold
                                                                   events


 If you have any questions, please post on https://neurostars.org/tags/bids.
```

#### Success

Pass go and collect 200 dollars, the data set in question passes validation.

```bash
user@host:~/bids-examples$ bids-validator sub001
bids-validator@1.7.1

This dataset appears to be BIDS compatible.

        Summary:                  Available Tasks:        Available Modalities:
        12 Files, 218.75KB                                T1w
        1 - Subject                                       pet
        1 - Session                                       blood


 If you have any questions, please post on https://neurostars.org/tags/bids
```
