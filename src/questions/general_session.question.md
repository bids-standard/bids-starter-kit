---
title: "General: I had to split the testing of one of my participants across 2 days, should I use 2 different session folders to organize the data of that participant?"
reference:
---

(faq_session)=

No. The `session` level in the BIDS folder hierarchy can be used to group data
that go "logically" together: this means that you can put in the same `session` folder
data that were acquired on different days,
but that are "linked" to one another in a way that make sense to how you want to organize your data.

If you want to keep track of what data was acquired when you can use the
[`scans.tsv` files](https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#scans-file).

For some examples, see this
[issue in the bids-starter kit](https://github.com/bids-standard/bids-starter-kit/issues/193).

If you deal with EEG data, you may want to read this
[comment in another issue](https://github.com/bids-standard/bids-starter-kit/issues/265#issuecomment-1082240834)
as well before considering combining recordings acquired on different occasions
within the same `session` folder.
