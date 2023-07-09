---
title: "General: Is your data type not covered in the current BIDS specification?"
---

BIDS extensions proposals [(BEPs)](https://bids.neuroimaging.io/get_involved.html#extending-the-bids-specification)
aim to extend the BIDS specification to new data types.
A list of extensions proposals can be found [on the main BIDS webpage](https://bids.neuroimaging.io/)
under [Get Involved](https://bids.neuroimaging.io/get_involved.html#extending-the-bids-specification).
Guidelines for contributing to these extensions or starting your own can be found
in the [BIDS Extension Proposals Guide](https://bids-extensions.readthedocs.io/en/latest/).

If only part of your data is covered under BIDS, an option to allow additional files
currently not covered in BIDS to pass the validator is
the [.bidsignore](https://github.com/bids-standard/bids-validator/blob/master/bids-validator/README.md) file,
which works just like [.gitignore](https://git-scm.com/docs/gitignore).
It allows you to list all the files (or directories, with wildcards) that are not
BIDS compliant and should be ignored by the validator. Of course you should
still try to adhere to upcoming BEPs and the general BIDS philosophy for file
names and metadata where possible, but this gives a little extra flexibility.
