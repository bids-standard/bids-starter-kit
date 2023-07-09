---
title: "EEG: How to format Hardware and Software filter fields in a .json?"
---

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
