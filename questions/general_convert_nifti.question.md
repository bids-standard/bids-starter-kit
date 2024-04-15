---
title: "General: I only have nifti files and no dicom. Can I still create a BIDS dataset?"
---

In theory yes, but it is possible that you will be missing some metadata that is required by the BIDS specification.

A couple of BIDS converters can work with nifti files:

- bidscoin
- bidsme
- explore asl
- data2bids

See the list of converters [here](https://bids.neuroimaging.io/benefits.html#mri-and-pet-converters).

**However**...

- They may not work with the datatype you have
  (for example not sure that explore ASL can deal with `func` data).
- Many of them still expect that you have a json side car for each nifti
  (BIDSme for example - from the top of my head).
- They may expect a certain input structure to work efficiently,
  so we may have to move files around.

<!-- Not played with it but, from the README, data2bids sounds pretty flexible
but may require you to play with python and json files for configuration.

https://github.com/SIMEXP/Data2Bids -->

### Regarding the "missing" JSON files

Depending on the datatype you are dealing with this can be more of less annoying.

2 examples:

For the most typical `anat` files,
they don't have any REQUIRED metadata,
so you could have just the data files without any accompanying JSON.
If you get into more exotic anat files (like for quantitative MRI)
then this may become a problem.

For `func` files you only need `TaskName` and `RepetitionTime`
and the former you can decide what it is and the latter should be in the Nifti header.
So you should be OKish there too.

Obviously you will be missing some metadata that would be required
for some type of preprocessing (like slice timing info).

### Tips

- If you have the PDF with the details of acquisition sequence or a method section
  from a paper with that data, you could "recover" some extra metadata.
- SPM dicom import tool usually leaves a couple of metadata in a description field of the nifti header.
  That can be a problem for data anonymisation but may help you in your case if this is the tool that was used.
  See an example [here](https://github.com/PeerHerholz/BIDSonym/issues/41#issue-768636869)
- If you have to script tings manually rather than using a converter,
  remember to use pybids [path construction tools](https://bids-standard.github.io/pybids/examples/pybids_tutorial.html#path-construction) or the [bids matlab equivalent](https://github.com/bids-standard/bids-matlab/blob/master/examples/03_BIDS-Matlab_filenames_and_metadata.ipynb) to make your life easier when constructing bids valid filenames.
