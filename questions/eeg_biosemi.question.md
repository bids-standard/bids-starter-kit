---
title: "EEG: How to specify EEGReference and EEGGround for Biosemi referencing scheme?"
---

Reference and ground electrodes for EEG data can usually be specified
using the `EEGReference` and `EEGGround` fields
in the modality specific sidecar file `_eeg.json`.
Both fields accept a string value such as `"Placed on Cz"`.

However, some manufacturers use special referencing schemes
such as the combination of a "Common Mode Sense" (CMS) and a "Driven Right Leg" (DRL) electrode.
This is the case for Biosemi, as further documented on
[their website](https://www.biosemi.com/faq/cms&drl.htm).

For a formatted example on how to deal with this in the BIDS context,
please see this
[template](https://github.com/bids-standard/bids-starter-kit/blob/main/templates/sub-01/ses-01/eeg/sub-01_ses-01_task-ReferenceExample_eeg.json).
