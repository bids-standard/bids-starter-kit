# FAQ microscopy

<!-- taken from the original BEP google doc

https://docs.google.com/document/d/1Nlu6QVQrbOQtdtcRarsONbX5SrOubXWBvkV37LRRqrc/edit#bookmark=id.39jsd4wp2g3d

 -->

FAQ To increase readability of the document and avoid having too much open
comments, this FAQ summarizes questions and topics that have already been
answered and discussed in comments. It also covers suggestions that are not yet
included in the proposition. 7.1 Why did the proposal name change from histology
to microscopy? (Discussion in comments between Robert Oostenveld, Alberto
Lazari, Julien Cohen-Adad and Marie-Hélène Bourget)

The original example was named BIDS-histology. Histology often refers to
different microscopy techniques done ex vivo and more broadly to the study of
biological tissues. As histological samples are imaged using microscopy, and as
the current proposal aims to cover microscopy techniques done ex vivo and in
vivo, the name has been changed to Microscopy-BIDS to best represent the
different acquisition modalities used. Moreover, this seems more aligned with
other BIDS Extension Proposal for which the name is more related to the
acquisition techniques than the sample (ex: NIRS, PET, CT, etc). 7.2 PNG vs.
OME-TIFF vs. both as the file format? The original example included different
files formats (PNG, JPEG and TIFF). However, as strongly suggested by Chris
Markiewicz (effigies) on Neurostars, it would be better to settle on a single
format as “The advantage of BIDS is that by constraining what data is BIDS, the
more downstream tools can depend on it and spend more code on processing and
less on handling disparate inputs.”

The PNG format has been preferred because it uses lossless compression compared
to JPEG and is generally smaller in size than TIFF files.

Julien Cohen-Adad and Mathieu Boudreau suggested that for PNG we should:
“consider compression level (to ensure uniformity across dataset)-- maybe
something to "recommend" (not enforce)”. As a reference, compression level in
PNG files is a tradeoff between file size and resources/time needed for the
compression algorithm. In all cases, the compression is lossless. No
recommendation regarding compression level has been made at this time. (ref:
https://superuser.com/questions/845394/how-is-png-lossless-given-that-it-has-a-compression-parameter).

Ali Khan (akhanf) suggested on github and in comments to look into whole-slide
formats (ex: svs, ndpi BigTiff, see https://openslide.org/formats/) that deal
with very high resolution images and are stored in multiples resolutions pyramid
files. John Pellman (jpellman) suggested on github and Matt Budde in comments to
look into Bio-formats and OME-TIFF file format. Bioformats toolbox is a resource
widely used to read whole-slide formats, and OME-TIFF is a file structure and
metadata standard developed by Open Microscopy Environment for whole-slide
imaging.

The rationale here for choosing PNG format was to constrain the data structure
to a single file format. Moreover, BIDS as a data structure (and not a file
format), includes the metadata in a sidecar json file and not in the file. A
conversion of some sort would be necessary to extract metadata from the OME-TIFF
file into BIDS. The idea here was to enforce a single, easily readable and ready
to use format (PNG), and have third-party Apps deal with conversion from
whole-slide imaging different formats when necessary (analogously to conversion
from DICOM to Nifti in BIDS with dcm2bids, heudiconv, etc.). As for acquisition
that would not already be in OME-TIFF format, it would also require specialized
toolbox like Bio-formats for conversion, whereas PNG can easily be generated
using multiple image editing toolbox.

The current proposal includes a “run” entity in the filename to deal with
multiples images of a same sample (ex: to export multiple PNG from the highest
resolution of a pyramid files) and a “downsampling” entity to indicate the
downsampling factor in case of lower resolution being converted to PNG.

PNG Pros PNG Cons OME-TIFF Pros OME-TIFF Cons Lossless compression Small size
(smaller than TIFF) Easy to read and create with multiple image editing toolbox
No metadata in file Conversion needed with specialized toolbox in case of
pyramid files Cannot store z-stacks of 3D+ scans Standardized metadata structure
in file Allows for multi-dimensional data Cumbersome to work with because of
their size Limited support in viewers or image editing toolbox Conversion needed
with specialized toolbox for acquisition in another format

Other good points in favor of OME-TIFF (and other whole-slide formats) were made
in the comments of this section by Robert Oostenveld, Ali Khan, Satrajit Ghosh
and Yaël Balbastre. The main questions are: What is the most common format used
by vendors, managers and consumers for various 2D and 3D microscopy datasets?
Which formats are used by labs that are likely to use this BEP in the future?
How to take advantage of the existing file standard OME-TIFF in this BEP? Is
using PNG a step backward? One of our main concerns about OME-TIFF is its
accessibility, and tools for scripting software to read and write from and to
OME-TIFF. The questions are: How easily can we create and maintain over time
BidsApp that can deal with OME-TIFF files? How OME-TIFF images can be easily
included into an image processing pipeline? How easily people with datasets in
formats other than OME-TIFF can convert them to use the BEP? The section below
“Tools to convert to and from OME-TIFF” covers that question, and it appears
that the listed “Cons” are strong arguments against OME-TIFF. As suggested by
Ali Khan: “There are bids extensions that use multiple accepted formats when the
community hasn't converged to a single format” and that we could have “a single
file format for non-tiled images (which can be PNG) and a single file format for
tiled images (exact format TBD)” For those reasons, the 2020-10-20 version of
the proposal includes both PNG and OME-TIFF formats. A few tools for dealing
with OME-TIFF are listed below. The software that seems to be mainly used for
processing and converting OME-TIFF is Fiji/ImageJ with the Bioformat plugin
maintained by OME. 7.2.1 Tools to convert to and from OME-TIFF Bioformats Java
library and command-line tool:
https://docs.openmicroscopy.org/bio-formats/6.5.1/index.html Pros: from OME
Cons: java 8+ only Relevant threads and doc:
https://docs.openmicroscopy.org/bio-formats/6.5.1/users/comlinetools/
https://docs.openmicroscopy.org/ome-model/6.1.2/ome-tiff/code.html
https://forum.image.sc/t/bfconvert-not-always-creating-ome-tiff-sometimes-just-plain-tiff/42907/13
https://forum.image.sc/t/ndpi-file-how-to-convert-to-tiff-without-loosing-resolution/31619

Bioformats plugin in Fiji/ImageJ: https://imagej.net/Fiji/Downloads Pros: uses
Bioformats java library from OME, can be scripted without GUI in fiji “macro”,
java or python (jython) Cons: requires fiji desktop installation, scripting
python with python2 standard library only Relevant threads and docs:
https://imagej.net/Scripting_toolbox.html
https://gist.github.com/ctrueden/6282856
https://forum.image.sc/t/need-help-with-using-bioformats-exporter-from-python-script/6417
Bioformats plugin in python-bioformats:
https://github.com/CellProfiler/python-bioformats/ Pros: uses Bioformats java
library from OME Cons: requires java VM, project is poorly active on github but
1 recent update on PyPI, implemented for a specific projects (CellProfiler)
Relevant threads and docs: https://pypi.org/project/python-bioformats/
https://pythonhosted.org/python-bioformats/
https://docs.openmicroscopy.org/bio-formats/6.0.1/developers/python-dev.html
https://github.com/CellProfiler/python-bioformats/issues/23
https://github.com/CellProfiler/python-bioformats/issues/80

Tifffile library: https://github.com/cgohlke/tifffile Pros: python 3.7+, project
active on github and PyPI Cons: maintain by 1 person, API not stable yet Related
threads and docs: https://pypi.org/project/tifffile/

Apeer ometiff library: https://github.com/apeer-micro/apeer-ometiff-library
Pros: python 3, includes the OMEXML class from python-bioformats for great
parsing of the metadata (without the java VM) Cons: dependent on Tifffile
library (cons listed above in Tifffile library), documentation not very
detailed. Related threads and docs: https://www.apeer.com/blog/ome-tiff
https://pypi.org/project/apeer-ometiff-library
https://github.com/zeiss-microscopy/OAD/blob/master/jupyter_notebooks/Read_CZI_and_OMETIFF_and_display_widgets_and_napari/using_apeer-ometiff-library.ipynb

libvips: https://libvips.github.io/libvips/ Pros: very fast, low memory
consumption, python 3, well maintained repo Cons: limited documentation on
python package Related threads and
docs:https://libvips.github.io/libvips/API/current/

Other possibilities identified by Satrajit Ghosh in comments: “one of the most
used tools in microscopy is fiji/image-j - which supports ome-tiff directly.
then there are more recent 3D lightsheet processing tools with image
registration (with elastix) and others. and then there are things that do neuron
reconstruction. and some of it is based on manual tracing and some based on
image stacks (Vaa-3D and others).”

pyometiff: https://github.com/filippocastelli/pyometiff/ LENS, maintained by
Filippo Maria Castelli and Giacomo Mazzamuto early phase of development, any
feedback and suggestion would be gladly appreciated

MBF bioscience Microsfile+: https://www.mbfbioscience.com/microfileplus
Conversion from multiple microscopy formats to JPEG2000 or OMETIFF with metadata
Windows GUI

7.3 How to deal with different resolutions of pyramid files? (Discussion in
comments between Ilona Lipp, Kurt Schilling and Marie-Hélène Bourget) (and
modifications from discussion in April 23rd BEP031 meeting)

In the case of pyramid files with multiple resolutions (levels) for the same
acquisition converted to 2D format like PNG, the level must be included in the
filename in order to distinguish images extracted from different resolutions.
The “downsampling” entity has been added to the filename for this purpose. It is
used only when lower resolution files are converted and indicates the
downsampling factor in each dimension. For the full resolution image, the
downsampling factor is not present in the filename. The downsampling factor is
indicated “in each dimension” as it is more intuitive, and it is how the
downsampling metadata field is computed by the "OpenSlide" software. Examples of
use for different resolutions:

1. google earth approach to visualize and zoom in on specific region
2. analysis may not need high resolution, and data manipulation/storage is just
   easier and faster with smaller images
3. integrating with MRI, we typically register the resolution that is closest to
   the MR images

Following the April 13th meeting with the maintainers and the April 23rd BEP031
meeting, we removed the “downsampling” entity originally used for converting
multiple resolutions pyramid file formats where to 2D single resolution file
format. We also removed the “DownsamplingMethod” metadata field to describe the
downsampling method.

The entity was replaced by the “resolution” (res) entity already present in the
BIDS specifications for derivatives. Because BIDS have a rule that the "raw"
dataset shouldn't include derivatives that are trivial to produce, and because
the definition were compatible, lower-res files should be placed under
derivatives. In addition, the json sidecar file for the entity “res” in
derivatives has the “Resolution” field necessary to describe the res-<label>.
