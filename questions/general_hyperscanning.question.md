---
title: "General: How should I organize data for hyperscanning data?"
---

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
