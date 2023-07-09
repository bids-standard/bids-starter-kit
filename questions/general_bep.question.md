---
title: "General: Is your data type not covered in the current BIDS specification?"
---

BIDS extensions proposals [(BEPs)](https://bids.neuroimaging.io/get_involved.html#extending-the-bids-specification)
aim to extend the BIDS specification to new data types.
A list of extensions proposals can be found below.

Guidelines for contributing to these extensions or starting your own can be found
in the [BIDS Extension Proposals Guide](https://bids-extensions.readthedocs.io/en/latest/).

If only part of your data is covered under BIDS, an option to allow additional files
currently not covered in BIDS to pass the validator is
the [.bidsignore](https://github.com/bids-standard/bids-validator/blob/master/bids-validator/README.md) file,
which works just like [.gitignore](https://git-scm.com/docs/gitignore).
It allows you to list all the files (or directories, with wildcards)
that are not BIDS compliant and should be ignored by the validator.
Of course you should still try to adhere to upcoming BEPs
and the general BIDS philosophy for file names and metadata where possible,
but this gives a little extra flexibility.

<!-- TEMPLATE STARTS -->

### raw

- BEP004: [Susceptibility Weighted Imaging (SWI)](https://bids.neuroimaging.io/bep004)
- BEP020: [Eye Tracking including Gaze Position and Pupil Size](https://bids.neuroimaging.io/bep020)
- BEP022: [Magnetic Resonance Spectroscopy (MRS)](https://bids.neuroimaging.io/bep022)
- BEP024: [Computed Tomography scan (CT)](https://bids.neuroimaging.io/bep024)
- BEP025: [Medical Imaging Data structure (MIDS)](https://bids.neuroimaging.io/bep025)
- BEP026: [Microelectrode Recordings](https://bids.neuroimaging.io/bep026)
- BEP029: [Virtual and physical motion data](https://bids.neuroimaging.io/bep029)
- BEP032: [Animal electrophysiology](https://bids.neuroimaging.io/bep032)
- BEP033: [Advanced Diffusion Weighted Imaging (aDWI)](https://bids.neuroimaging.io/bep033)
- BEP036: [Phenotypic Data Guidelines](https://bids.neuroimaging.io/bep036)
- BEP037: [Non-Invasive Brain Stimulation (NIBS)](https://bids.neuroimaging.io/bep037)
- BEP038: [Atlases](https://bids.neuroimaging.io/bep038)
- BEP039: [Dimensionality reduction-based networks](https://bids.neuroimaging.io/bep039)
- BEP040: [Functional Ultrasound (fUS)](https://bids.neuroimaging.io/bep040)
### derivative

- BEP011: [Structural preprocessing derivatives](https://bids.neuroimaging.io/bep011)
- BEP012: [Functional preprocessing derivatives](https://bids.neuroimaging.io/bep012)
- BEP014: [Affine transformations and nonlinear field warps](https://bids.neuroimaging.io/bep014)
- BEP016: [Diffusion weighted imaging derivatives](https://bids.neuroimaging.io/bep016)
- BEP017: [Generic BIDS connectivity data schema](https://bids.neuroimaging.io/bep017)
- BEP021: [Common Electrophysiological Derivatives](https://bids.neuroimaging.io/bep021)
- BEP023: [PET Preprocessing derivatives](https://bids.neuroimaging.io/bep023)
- BEP034: [Computational modeling](https://bids.neuroimaging.io/bep034)
- BEP035: [Modular extensions for individual participant data mega-analyses with non-compliant derivatives](https://bids.neuroimaging.io/bep035)
### metadata

- BEP019: [DICOM Metadata](https://bids.neuroimaging.io/bep019)
- BEP027: [BIDS Applications 2.0](https://bids.neuroimaging.io/bep027)
- BEP028: [Provenance](https://bids.neuroimaging.io/bep028)
- BEP034: [Computational modeling](https://bids.neuroimaging.io/bep034)
### file format

- BEP002: [BIDS Models Specification](https://bids.neuroimaging.io/bep002)
