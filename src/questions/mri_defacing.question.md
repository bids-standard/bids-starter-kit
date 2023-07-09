---
title: "MRI: What defacing tools can I use?"
---

If you want to share your BIDS data set, chances are that you will have to anonymize it
and therefore prevent identification of the participants from their anatomical scans.
You will need to de-identification (or deface) the anatomical images.
There are several options to do that

-   If you already have a valid BIDS data set you can simply use the
    [BIDSonym BIDS app](https://github.com/PeerHerholz/BIDSonym) on it. To do
    that it relies on several tools that you can also use before you have
    finalized your BIDS data set
    -   [Pydeface](https://github.com/poldracklab/pydeface)
    -   [MRI deface](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_deface)
    -   [Quickshear](https://github.com/nipy/quickshear)

Otherwise you can also use:

-   [Fieldtrip](http://www.fieldtriptoolbox.org/faq/how_can_i_anonymize_an_anatomical_mri/)
    under matlab can do it.
-   SPM8 and SPM12: when in the batch editor go to:
    `SPM menu --> Util --> Deface`
