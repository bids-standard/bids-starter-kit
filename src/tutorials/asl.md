# ASL data conversion

# Scaling

This paragraph discusses the specific scaling issues for GE, Philips, and
Siemens. Beware that these issues are occurring at the time of the release of
[version 1.5.0](https://bids-specification.readthedocs.io/en/v1.5.0/), and might
be resolved in the future.

## GE

GE applies an RF amplifier factor that should be multiplied by the number of
signal averages (NSA) as GE sums instead of averages them.

## Philips

Typically, Philips ASL datasets use the standard DICOM rescale tags only to
rescale data for viewing, whereas private rescale tags are used for scaling to
acquisition values needed for proper quantification.

The procedure for using both the scaling types is described previously
[**reference required**], although the authors did not mention that three DICOM
fields are typically used for this purpose - `(2005, 100e)`, `(2005, 110e)`, or
`(2005, 120e)`.

It may also occur that the RescaleSlope `(0028, 1053)` is set to `1` and
RescaleSlopeOriginal `(2005, 140a)` needs to be used instead. Note that DICOM to
NIfTI conversion software may omit the private slopes, in which cases the
private slope needs to be applied after running the conversion.

An exception is the [dcm2nii(X)](https://github.com/rordenlab/dcm2niix) software
that does take private scale slopes into account in most cases. The
[dcm2nii(X)](https://github.com/rordenlab/dcm2niix) versions released between
2018 and 2019-09-02 can correctly scale the NIfTI according to the private scale
slopes - if run with parameter `-p` - and indicates this by setting
`UsePhilipsFloatNotDisplayScaling==1` in the accompanying json file.

Two exceptions apply, [dcm2nii(X)](https://github.com/rordenlab/dcm2niix) does
not support DICOM tags `(2005, 110e)` and `(2005, 120e)` that still need to be
read and applied additionally. Furthermore, the field RealWorldValueSlope
`(0040,9225)` is sometimes provided as an alternative to RescaleSlope
`(0028,1053)`. In this case, [dcm2nii(X)](https://github.com/rordenlab/dcm2niix)
outputs a field `PhilipsRWVSlope` and sets
`UsePhilipsFloatNotDisplayScaling==1`. This is deceiving because the standard
RescaleSlope is applied instead of private-field scale slopes and this still
needs to be corrected manually.

Note that this last-mentioned behavior is corrected in the newest dcm2nii
version and general caution is recommended when dealing with Philips scale
slopes. Also, Philips has recently implemented the option to apply these scaling
factors upon export. The scaling of acquired/reconstructed ASL images may differ
between control, label, and M0 images.

## Siemens

Several implementations of Siemens ASL WIP have a scaling between ASL and M0.
This can be only modified and obtained at the scanner console and it is set to
`10` by default.

### PIXDIM

The so-called PIXDIM error appears to be specific for files with a single
repetition, more specifically the separately acquired `m0scan`. In the NIfTI
header, `dim[0]` defines the number of dimensions, `dim[i]` defines the length
of the i’th dimension, `pixdim[i]` specifies the voxel width along dimension
`i`. For images with a single repetition, where `pixdim[4]` specifies the
temporal width, the BIDS validator requires that the image is defined as 4D with
`dim[0] == 4`, even though the image has a single repetition `dim[4] == 1`.
Defining (`dim[0] == 3`) for a 44D volume with a single repetition (for
instance: a 3D image) is common and correct, however, it is considered invalid
by the validator.
