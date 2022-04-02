# PET data conversion

## History

The PET modality is one of the newest additions to the BIDS standard with its
introduction via BEP 009. If you're interested in seeing exactly what and how
something gets added to BIDS see the pull request for
[BEP 009 here](https://github.com/bids-standard/bids-specification/pull/633).
The results of that extension proposal can be read
[here](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/09-positron-emission-tomography.html#positron-emission-tomography)
in the bids standard.

## Conversion

Presently, PET does not have the same level of support when it comes to
conversion from raw data into BIDS format like MR imaging. Much of the work in
converting from a raw PET dataset into a bids PET dataset will be incumbent on
the user. Some useful tools and resources that will be used in this document are
as follows:

-   [BIDS Validator](https://github.com/bids-standard/bids-validator), which
    fully supports PET

-   [TPCCLIIB](https://gitlab.utu.fi/vesoik/tpcclib) is a command line library
    containing (among many others) PET tools such as `ecat2nii` that will be
    used below to convert the imaging data from a PET dataset into nifti format.
    The Turku PET Centre site can be found [here](https://turkupetcentre.fi/)
    for additional information on anything PET.
-   a
    [BIDS PET Template](https://github.com/bids-standard/bids-starter-kit/tree/main/templates)
    from this starter kit to initially populate and translate
    text/tabulature/csv blood data into BIDS PET compliant `.tsv` and `.json`
    files.
-   [dcm2niix](https://github.com/rordenlab/dcm2niix) can be used if your raw
    pet data happens to be in a dicom format. Additionally this opens up the use
    of tools such as [dcmdump](https://support.dcmtk.org/docs/dcmdump.html) from
    the [dcmtk](https://support.dcmtk.org/docs/) to help in your conversion.

### What we're starting with

Here is the structure of our starting dataset:

```bash
OldNotBidsPETDataSet/
├── MR_image
│   ├── 24310.cropped.hdr
│   ├── 24310.cropped.img
│   └── 24310_rois.mat
├── retest_scan_sub01
│   ├── sub01_8__PLASMA.txt
│   └── sub01_8_anon.v
└── test_scan_sub01
    ├── sub01_7_PLASMA.txt
    └── sub01_7_anon.v

3 directories, 7 files
```

By the end of this document our starting dataset will be fully bids compliant
and similar to the dataset seen
[here](https://github.com/bids-standard/bids-examples/tree/master/pet001).

### Setting the layout

This starter kit provides several template/example files that can be a great
starting place to help get set up for the conversion process. PET specific text
data files can be viewed at
[this location](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/pet).
And easily collected via this
[link](https://github.com/bids-standard/bids-starter-kit/archive/refs/heads/main.zip)
or be cloned and extracted via git at the command line via:

```bash
git clone git@github.com:bids-standard/bids-starter-kit.git
```

The `templates/` folder in `bids-starter-kit/` contains a single subject and
examples of every BIDS modality text and `.json` file for that subject.
Additionally, there exists a `Short` and a `Full` example for each text/json
file. The `Short` files contain only the required BIDS fields for each modality
and the `Full` example files contain _every_ field included within the BIDS
standard.

```bash
templates/
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
├── phenotype
│   ├── EpilepsyClassification.tsv
│   └── EpilepsyClassification2017.json
└── sub-01
    └── ses-01
        ├── anat
        │   ├── sub-01_ses-01_acq-FullExample_run-01_T1w.json
        │   └── sub-01_ses-01_acq-ShortExample_run-01_T1w.json
        ├── eeg
        │   ├── sub-01_ses-01_task-FilterExample_eeg.json
        │   ├── sub-01_ses-01_task-FullExample_eeg.json
        │   ├── sub-01_ses-01_task-MinimalExample_eeg.json
        │   └── sub-01_ses-01_task-ReferenceExample_eeg.json
        ├── fmap
        │   ├── sub-01_ses-01_task-Case1_run-01_phasediff.json
        │   ├── sub-01_ses-01_task-Case2_run-01_phase1.json
        │   ├── sub-01_ses-01_task-Case2_run-01_phase2.json
        │   ├── sub-01_ses-01_task-Case3_run-01_fieldmap.json
        │   └── sub-01_ses-01_task-Case4_dir-LR_run-01_epi.json
        ├── func
        │   ├── sub-01_ses-01_task-FullExample_run-01_bold.json
        │   ├── sub-01_ses-01_task-FullExample_run-01_events.json
        │   ├── sub-01_ses-01_task-FullExample_run-01_events.tsv
        │   └── sub-01_ses-01_task-ShortExample_run-01_bold.json
        ├── ieeg
        │   ├── sub-01_ses-01_coordsystem.json
        │   ├── sub-01_ses-01_electrodes.tsv
        │   ├── sub-01_ses-01_task-LongExample_run-01_channels.tsv
        │   └── sub-01_ses-01_task-LongExample_run-01_ieeg.json
        ├── meg
        │   ├── sub-01_task-FullExample_acq-CTF_run-1_proc-sss_meg.json
        │   └── sub-01_task-ShortExample_acq-CTF_run-1_proc-sss_meg.json
        └── pet
            ├── sub-01_ses-01_recording-AutosamplerShortExample_blood.json
            ├── sub-01_ses-01_recording-AutosamplerShortExample_blood.tsv
            ├── sub-01_ses-01_recording-ManualFullExample_blood.json
            ├── sub-01_ses-01_recording-ManualFullExample_blood.tsv
            ├── sub-01_ses-01_recording-ManualShortExample_blood.json
            ├── sub-01_ses-01_recording-ManualShortExample_blood.tsv
            ├── sub-01_ses-01_task-FullExample_pet.json
            └── sub-01_ses-01_task-ShortExample_pet.json

10 directories, 35 files
machine:bids-starter-kit user$
```

For the purposes of this exercise we will only be focusing on obtaining the
minimum required fields, thus we collect and copy the following to our own BIDS
folder.

```bash
# create the new bids folder
mkdir -p /NewBidsDataSet/sub-01/ses-01/pet
cp -r /path/to/bids-starter-kit/templates/sub-01/ses-01/pet/* /NewBidsDataSet/sub-01/pet/
```

Oops, we forgot to include our dataset specific files. Let's make it easy on
ourselves and include the templates for those too.

```bash
cp /path/to/bids-starter-kit/templates/* /NewBidsDataSet/
```

Our skeleton of a data set should now look like this:

```bash
machine: Projects user$ tree NewBidsDataSet/
NewBidsDataSet/
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    └── ses-01
        └── pet
            ├── sub-01_ses-01_recording-AutosamplerShortExample_blood.json
            ├── sub-01_ses-01_recording-AutosamplerShortExample_blood.tsv
            ├── sub-01_ses-01_recording-ManualFullExample_blood.json
            ├── sub-01_ses-01_recording-ManualFullExample_blood.tsv
            ├── sub-01_ses-01_recording-ManualShortExample_blood.json
            ├── sub-01_ses-01_recording-ManualShortExample_blood.tsv
            ├── sub-01_ses-01_task-FullExample_pet.json
            └── sub-01_ses-01_task-ShortExample_pet.json

3 directories, 12 files
machine:Projects user$
```

Now let's do the bare minimum and focus only on the short files:

```bash
machine:Projects user$ rm -rf NewBidsDataSet/sub-01/ses-01/pet/*Full*
machine:Projects user$ tree NewBidsDataSet
NewBidsDataSet/
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    └── ses-01
        └── pet
            ├── sub-01_ses-01_recording-AutosamplerShortExample_blood.json
            ├── sub-01_ses-01_recording-AutosamplerShortExample_blood.tsv
            ├── sub-01_ses-01_recording-ManualShortExample_blood.json
            ├── sub-01_ses-01_recording-ManualShortExample_blood.tsv
            └── sub-01_ses-01_task-ShortExample_pet.json

3 directories, 9 files
machine:Projects user$
```

That certainly looks less daunting, now let's change the filenames of the
templates so that they make more sense for our data set (aka remove ShortExample
from each filename).

**Note:** if you have multiple PET image files you can distinguish between them
by creating a session folder with a unique name and then applying the
`ses-<label>` label to each file therein. If there's a single pet scan you may
omit the additional folder and corresponding label(s) from the filename. For
more information on labeling see
[this link](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/09-positron-emission-tomography.html#pet-recording-data).

```bash
# for those of you in bash land
machine:Projects user$ cd NewBidsDataSet/sub-01/ses-01/pet
machine:pet user$ for i in *ShortExample*; do mv "$i" "`echo $i | sed 's/ShortExample//'`"; done
# Since we "don't" know if there are multiple PET image files we will omit the task label for our PET .json
# file for now.
machine:pet user$ mv sub-01_ses-01_task-_pet.json sub-01-ses-01_pet.json
```

After you've renamed your files your directory should look something like:

```bash
machine:Projects user$ tree NewBidsDataSet/
NewBidsDataSet/
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    └── ses-01
        └── pet
            ├── sub-01_ses-01_pet.json
            ├── sub-01_ses-01_recording-Autosampler_blood.json
            ├── sub-01_ses-01_recording-Autosampler_blood.tsv
            ├── sub-01_ses-01_recording-Manual_blood.json
            └── sub-01_ses-01_recording-Manual_blood.tsv

3 directories, 9 files
machine:Projects user$
```

Ok great, but where do the imaging files go? And what format should they be in?
And there's at least 2 `.v` pet files shouldn't there be multiple sessions?

Well yes, yes, and yes. but before we add more sessions/directories we're going
to make sure we have images to place in them.

### Collecting and installing TPCCLIB

Since our raw imaging files are in ECAT format, we'll be using the ecat2nii tool
it the TPCCLIIB as it's very handy at converting PET ECAT images into the more
bids friendly nifti format. If you're imaging files are in `.IMG` you can use
\*\*<\insert converter>\*\* or if they're in dicom dcm2niix is an excellent tool
to transform `.dcm` files into `.nii`

Before we proceed we will need to collect and install the ecat2nii tool from the
TPCCLIIB (if you're on a non-posix based OS, I suggest you use WSL (windows
subsystem for linux), a container, or a VM if you want to continue following
along.

1. Visit <https://gitlab.utu.fi/vesoik/tpcclib>
2. Download tpcclib via your download link of choice, ours is
   [here](https://gitlab.utu.fi/vesoik/tpcclib/-/archive/master/tpcclib-master.zip)
3. Once downloaded extract and place ecat2nii in an appropriate place

If you're using bash/posix step 3 will resemble something like the following:

```bash
machine:Downloads user$ unzip tpcclib-master.zip
machine:Dowloads user$ mv tpcclib-master /some/directory/you/are/fond/of/ # could be /usr/bin if you so choose
```

Now you can choose to add `tpcclib` to your path or not, in bash land we do the
following:

```bash
machine:Downloads user$ echo "export PATH=$PATH:/some/directory/you/are/fond/of/tpcclib-master" >> ~/.bashrc
# reload bash shell and verify that library is available
machine:Downloads user$ source ~/.bashrc
machine:Downloads user$ ecat2nii
  ecat2nii - tpcclib 0.7.6 (c) 2020 by Turku PET Centre

  Converts PET images from ECAT 6.3 or 7 to NIfTI-1 format.
  Conversion can also be done using ImageConverter (.NET application).

  Image byte order is determined by the computer where the program is run.
  NIfTI image format does not contain information on the frame times.
  Frame times can be retrieved from SIF file, which can be created optionally.
  SIF can also be created later using other software.

  Usage: ecat2nii [Options] ecatfile(s)

  Options:
   -O=<output path>
       Data directory for NIfTI files, if other than the current working path.
   -dual
       Save the image in dual file format (the header and voxel data in
       separate files *.hdr and *.img); single file format (*.nii)
       is the default.
   -sif
       SIF is saved with NIfTI; note that existing SIF will be overwritten.
   -h, --help
       Display usage information on standard output and exit.
   -v, --version
       Display version and compile information on standard output and exit.
   -d[n], --debug[=n], --verbose[=n]
       Set the level (n) of debugging messages and listings.
   -q, --quiet
       Suppress displaying normal results on standard output.
   -s, --silent
       Suppress displaying anything except errors.

  Example:
    ecat2nii *.v

  See also: nii2ecat, nii_lhdr, ecat2ana, eframe, img2flat

  Keywords: image, format conversion, ECAT, NIfTI

  This program comes with ABSOLUTELY NO WARRANTY.
  This is free software, and you are welcome to redistribute it under
  GNU General Public License. Source codes are available in
  https://gitlab.utu.fi/vesoik/tpcclib.git
```

Congrats, you've installed ecat2nii, you're one step closer to bidsifying your
dataset

Now, let's convert one of our PET ecat images and move it to its final
destination with ecat2nii that we just installed.

```bash
# first create nifti's from the ecat images
machine:OldNotBidsPETDataSet user$ ecat2nii retest_scan_sub01/sub01_8_anon.v
retest_scan_sub01/sub01_8_anon.v :
  processing retest_scan_sub01/sub01_8_anon.v
  45 frame(s) processed.
machine:OldNotBidsPETDataSet user$ ecat2nii test_scan_sub01/sub01_7_anon.v
test_scan_sub01/sub01_7_anon.v :
  processing test_scan_sub01/sub01_7_anon.v
  45 frame(s) processed.
# great success! let's see what we got
machine:OldNotBidsPETDataSet user$ tree
.
├── MR_image
│   ├── 24310.cropped.hdr
│   ├── 24310.cropped.img
│   └── 24310_rois.mat
├── retest_scan_sub01
│   ├── sub01_8_PLASMA.txt
│   └── sub01_8_anon.v
├── sub01_7_anon.nii
├── sub01_8_anon.nii
└── test_scan_sub01
    ├── sub01_7_PLASMA.txt
    └── sub01_7_anon.v

3 directories, 9 files
# not where we want those nifti's so let's move them
machine:OldNotBidsPETDataSet user$ mv *.nii ../NewBidsDataSet/sub-01/
machine:NewBidsDataSet user$ tree
.
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    └── test_scan_sub01/sub01_7_anon.nii
    └── test_scan_sub01/sub01_8_anon.nii
    └── ses-01
        └── pet
            ├── sub-01_ses-01_pet.json
            ├── sub-01_ses-01_recording-Autosampler_blood.json
            ├── sub-01_ses-01_recording-Autosampler_blood.tsv
            ├── sub-01_ses-01_recording-Manual_blood.json
            ├── sub-01_ses-01_recording-Manual_blood.tsv

3 directories, 11 files
```

Before we get too carried away, lets use populate our `*_pet.json` files with
the relevant information from our ecat and dataset.

This writer used a python tool specifically created to parse Ecat's for header
and subheader info [ecatdump](https://github.com/bendhouseart/ecatdump), all it
does is use Python libraries Nibabel and Argparse to collect and spit out the
header information from an Ecat file. If you prefer to use Matlab or create your
own tool/reader I would direct you to the converter
[here](https://github.com/openneuropet/BIDS-converter) as an excellent resource.

You can use and install it via pip and use it on your command line like below:

```bash
pip install ecatdump
# use the --json argument to extract all metadata contained in the ecat including subheaders
ecatdump  anon_sub01_8.v --json > sub01_8_anon.headerdata
# using it without the --json argument will produce this output
ecat dump anon_sub01_8.v
magic_number: MATRIX72v
original_filename: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
sw_version: 72
system_type: 962
file_type: 7
serial_number: hrplus
scan_start_time: 1111111111111
isotope_name: C-11
isotope_halflife: 1223.0
radiopharmaceutical: C-11 Flumazenil
gantry_tilt: 0.0
gantry_rotation: 0.0
bed_elevation: 82.6520004272461
intrinsic_tilt: 0.0
wobble_speed: 0
transm_source_type: 2
distance_scanned: 15.520000457763672
transaxial_fov: 58.29999923706055
angular_compression: 1
coin_samp_mode: 0
axial_samp_mode: 0
ecat_calibration_factor: 9698905.0
calibration_unitS: 1
calibration_units_type: 1
compression_code: 0
study_type: XXXXXXXXXXXX
patient_id: 0000000000000000
patient_name: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
patient_sex: F
patient_dexterity: U
patient_age: 0.0
patient_height: 0.0
patient_weight: 0.0
patient_birth_date: 0
physician_name:
operator_name:
study_description: C-11 Dynamic-1
acquisition_type: 4
patient_orientation: 3
facility_name: ECAT
num_planes: 63
num_frames: 20
num_gates: 1
num_bed_pos: 0
init_bed_position: 50.617000579833984
bed_position: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
plane_separation: 0.24250000715255737
lwr_sctr_thres: 0
lwr_true_thres: 350
upr_true_thres: 650
user_process_code:
acquisition_mode: 0
bin_size: 0.22499999403953552
branching_fraction: 1.0
dose_start_time: 111111111111
dosage: 0.0
well_counter_corr_factor: 1.0
data_units:
septa_state: 1
fill:
```

Using nibabel directly also works great:

<!--
machine:retest_scan_anon_sub01_8 user$ python3
Python 3.7.3 (default, Mar 27 2019, 09:23:15)
[Clang 10.0.1 (clang-1001.0.46.3)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
-->

```python
>>> import nibabel
>>> ecat_file = nibabel.ecat.load('anon_sub01_8_43e5_1b831_de2_anon.v')
>>> print(ecat_file.get_header())
__main__:1: DeprecationWarning: get_header method is deprecated.
Please use the ``img.header`` property instead.

* deprecated from version: 2.1
* Will raise <class 'nibabel.deprecator.ExpiredDeprecationError'> as of version: 4.0
<class 'nibabel.ecat.EcatHeader'> object, endian='>'
magic_number              : b'MATRIX72v'
original_filename         : b'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
sw_version                : 72
system_type               : 962
file_type                 : 7
serial_number             : b'hrplus'
scan_start_time           : 1111111111
isotope_name              : b'C-11'
isotope_halflife          : 1223.0
radiopharmaceutical       : b'C-11 Flumazenil'
gantry_tilt               : 0.0
gantry_rotation           : 0.0
bed_elevation             : 82.652
intrinsic_tilt            : 0.0
wobble_speed              : 0
transm_source_type        : 2
distance_scanned          : 15.52
transaxial_fov            : 58.3
angular_compression       : 1
coin_samp_mode            : 0
axial_samp_mode           : 0
ecat_calibration_factor   : 9698905.0
calibration_unitS         : 1
calibration_units_type    : 1
compression_code          : 0
study_type                : b'XXXXXXXXXXXX'
patient_id                : b'0000000000000000'
patient_name              : b'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
patient_sex               : b'F'
patient_dexterity         : b'U'
patient_age               : 0.0
patient_height            : 0.0
patient_weight            : 0.0
patient_birth_date        : 0
physician_name            : b''
operator_name             : b''
study_description         : b'C-11 Dynamic-1'
acquisition_type          : 4
patient_orientation       : 3
facility_name             : b'ECAT'
num_planes                : 63
num_frames                : 20
num_gates                 : 1
num_bed_pos               : 0
init_bed_position         : 50.617
bed_position              : [0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]
plane_separation          : 0.2425
lwr_sctr_thres            : 0
lwr_true_thres            : 350
upr_true_thres            : 650
user_process_code         : b''
acquisition_mode          : 0
bin_size                  : 0.225
branching_fraction        : 1.0
dose_start_time           : 1111111111111
dosage                    : 0.0
well_counter_corr_factor  : 1.0
data_units                : b''
septa_state               : 1
fill                      : b''
```

Using your wits, the available tools, and data you should be able to produce a
sidecar file like the following for your nifti image. Repeat this process for
each image file/nifti you're including while reusing the filename for each image
and while substituting the extention to `.json` instead of `.nii`.

```json
{
    "Manufacturer": "Siemens",
    "ManufacturersModelName": "HR+",
    "Units": "Bq/mL",
    "BodyPart": "Brain",
    "TracerName": "DASB",
    "TracerRadionuclide": "C11",
    "TracerMolecularWeight": 282.39,
    "TracerMolecularWeightUnits": "g/mol",
    "InjectedRadioactivity": 629.74,
    "InjectedRadioactivityUnits": "MBq",
    "MolarActivity": 55.5,
    "MolarActivityUnits": "MBq/nmol",
    "SpecificRadioactivity": 196.53670455752683,
    "SpecificRadioactivityUnits": "MBq/ug",
    "Purity": 99,
    "ModeOfAdministration": "bolus",
    "InjectedMass": 3.2041852,
    "InjectedMassUnits": "ug",
    "AcquisitionMode": "list mode",
    "ImageDecayCorrected": true,
    "ImageDecayCorrectionTime": 0,
    "TimeZero": "17:28:40",
    "ScanStart": 0,
    "InjectionStart": 0,
    "FrameDuration": [
        20, 20, 20, 60, 60, 60, 120, 120, 120, 300, 300.066, 600, 600, 600, 600,
        600, 600, 600, 600, 600, 600
    ],
    "FrameTimesStart": [
        0, 20, 40, 60, 120, 180, 240, 360, 480, 600, 900, 1200.066, 1800.066,
        2400.066, 3000.066, 3600.066, 4200.066, 4800.066, 5400.066, 6000.066,
        6600.066
    ],
    "ReconMethodParameterLabels": [
        "lower_threshold",
        "upper_threshold",
        "recon_zoom"
    ],
    "ReconMethodParameterUnits": ["keV", "keV", "none"],
    "ReconMethodParameterValues": [350, 650, 3],
    "ScaleFactor": [
        8.548972374455843e-8, 1.7544691388593492e-7, 1.3221580275057931e-7,
        1.2703590357432404e-7, 1.1155360368775291e-7, 2.2050951997698576e-7,
        2.184752503353593e-7, 1.7056818535365892e-7, 1.6606901453997125e-7,
        1.5532630470715958e-7, 2.19175134930083e-7, 2.0248222654117853e-7,
        2.277063231304055e-7, 2.425933018912474e-7, 2.3802238047210267e-7,
        2.514642005735368e-7, 2.802861729378492e-7, 2.797820570776821e-7,
        3.5299004252919985e-7, 4.6313422785715375e-7, 4.904185857412813e-7
    ],
    "ScatterFraction": [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ],
    "DecayCorrectionFactor": [
        1.0056782960891724, 1.0171427726745605, 1.0287377834320068,
        1.0522810220718384, 1.0886797904968262, 1.1263376474380493,
        1.1851094961166382, 1.2685142755508423, 1.3577889204025269,
        1.5278561115264893, 1.811025857925415, 2.328737735748291,
        3.271937131881714, 4.597157001495361, 6.459125518798828,
        9.075239181518555, 12.750947952270508, 17.915414810180664,
        25.1716251373291, 35.36678695678711, 49.69125747680664
    ],
    "PromptRate": [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ],
    "RandomRate": [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ],
    "SinglesRate": [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ],
    "ReconMethodName": "Vendor",
    "ReconFilterType": ["Shepp 0.5", "All-pass 0.4"],
    "ReconFilterSize": [2.5, 2],
    "AttenuationCorrection": "transmission scan"
}
```

Alright, now we're getting somewhere, let's rename these nifti's so that it's
easier to distinguish between them and so that they're both bids compliant.

```bash
# first lets divide the scans into their own sessions
machine:NewBidsDataSet user$ mv sub-01/ses-01/ sub-01/ses-testscan/
# and make a second session folder for the rescan
machine:NewBidsDataSet user$ cp -r sub-01/ses-testscan/ sub-01/ses-retestscan/
machine:NewBidsDataSet user$ mv sub-01/sub01_7_anon.nii sub-01/ses-testscan/pet/sub-01_ses-testscan_pet.nii
machine:NewBidsDataSet user$ mv sub-01/sub01_8_anon.nii sub-01/ses-retestscan/pet/sub-01_ses-retestscan_pet.nii
# some additional bash later and ......
machine:NewBidsDataSet user$ tree
.
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    ├── ses-retestscan
    │   └── pet
    │       ├── sub-01_ses-retestscan_pet.json
    │       ├── sub-01_ses-retestscan_recording-Autosampler_blood.json
    │       ├── sub-01_ses-retestscan_recording-Autosampler_blood.tsv
    │       ├── sub-01_ses-retestscan_recording-Manual_blood.json
    │       ├── sub-01_ses-retestscan_recording-Manual_blood.tsv
    │       └── sub-01_ses-retestscan_pet.nii
    └── ses-testscan
        └── pet
            ├── sub-01_ses-testscan_pet.json
            ├── sub-01_ses-testscan_recording-Autosampler_blood.json
            ├── sub-01_ses-testscan_recording-Autosampler_blood.tsv
            ├── sub-01_ses-testscan_recording-Manual_blood.json
            ├── sub-01_ses-testscan_recording-Manual_blood.tsv
            └── sub-01_ses-testscan_pet.nii

5 directories, 16 files

```

That looks better, but we need to do something about our tabular/text data.
Since we're only dealing with manual blood samples we can omit the autosampler
files from our data structure.

```bash
machine:NewBidsDataSet user$ rm -rf sub-01/ses-retestscan/pet/*Auto*
machine:NewBidsDataSet user$ rm -rf sub-01/ses-testscan/pet/*Auto*
machine:NewBidsDataSet user$ tree
.
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    ├── ses-retestscan
    │   └── pet
    │       ├── sub-01_ses-retestscan_pet.json
    │       ├── sub-01_ses-retestscan_recording-Manual_blood.json
    │       ├── sub-01_ses-retestscan_recording-Manual_blood.tsv
    │       └── sub-01_ses-retestscan_pet.nii
    └── ses-testscan
        └── pet
            ├── sub-01_ses-testscan_pet.json
            ├── sub-01_ses-testscan_recording-Manual_blood.json
            ├── sub-01_ses-testscan_recording-Manual_blood.tsv
            └── sub-01_ses-testscan_run-testscan_pet.nii

```

That looks better, now that we've got our nifti's sorted let's do something
about filling out our `*_blood.tsv` files and our `*_blood.json` files.

<!-- TODO grab that image and add to the repo -->

Here's are the contents of `sub01_7_PLASMA.txt`:
![sub01_7_PLASMA.txt screenshot of excell](https://i.imgur.com/xBgDZcI.png)

Since our plasma data is available we need to indicate as such in our
`*_blood.json` files so we do so now:

```json
{
    "PlasmaAvail": "true",
    "MetaboliteAvail": "true",
    "WholeBloodAvail": "false",
    "DispersionCorrected": "false",
    "MetaboliteMethod": "HPLC",
    "MetaboliteRecoveryCorrectionApplied": "false",
    "time": {
        "Description": "Time in relation to time zero defined by the _pet.json",
        "Units": "s"
    },
    "plasma_radioactivity": {
        "Description": "Radioactivity in plasma samples",
        "Units": "Bq/mL"
    }
    "metabolite_parent_fraction": {
        "Description": "Parent fraction of the radiotracer.",
        "Units": "unitless"
    }
}
```

Additionally, we can open our `*_blood.tsv` and add the plasma series of data to
it from our base text file:

<!-- TODO grab that image and add to the repo -->

![screenshot of unconverted sub-01_ses-testscan_recording-Manual_blood.tsv](https://i.imgur.com/VdFqh6H.png)

Whoops, these numbers aren't in SI units, so we quickly convert time from
minutes to seconds and Microcurie to Becquerel to conform to the spec. Note: if
you're wondering what method was used to determine what units these unlabeled
columns were in I can only tell you that prior knowledge, access to the
associated publishing, or experience/domain knowledge coupled with a bit of
guesswork are required to make that determination. One of the aims of adding PET
to BIDS is to help to avoid confusion at this level of the process and instead
allow researchers to reserve that confusion for use at some other point during
the research process.

After a bit of conversion and the inclusion of the metabolite parent fraction
(which if present is
[recommended](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/09-positron-emission-tomography.html#blood-recording-data)
to be included):

<!-- TODO grab that image and add to the repo -->

![screenshot of converted and minimally complete manual_blood.tsv](https://i.imgur.com/nWXcFsw.png)

Now just repeat this process for each required field in the `*_blood.json` file
and/or for each recommended field that you wish to include from your non-bids
dataset into this bidsified one. The final results of our efforts leads us to
having this final `*blood_.json`:

```json
{
    "PlasmaAvail": true,
    "PlasmaFreeFraction": 15.062331,
    "PlasmaFreeFractionMethod": "Ultrafiltration",
    "WholeBloodAvail": false,
    "DispersionCorrected": false,
    "MetaboliteAvail": true,
    "MetaboliteMethod": "HPLC",
    "MetaboliteRecoveryCorrectionApplied": false,
    "time": {
        "Description": "Time in relation to time zero defined by the _pet.json",
        "Units": "s"
    },
    "plasma_radioactivity": {
        "Description": "Radioactivity in plasma samples",
        "Units": "Bq/mL"
    },
    "metabolite_parent_fraction": {
        "Description": "Parent fraction of the radiotracer",
        "Units": "arbitrary"
    }
}
```

### Last Pass

If you're thinking that we failed to document or include our T1 image from the
start you would be correct. There are many resources documenting that process
see:

_TODO_ add resources here

Once you've handled converting your MR images into bids your directory should
look like the following:

```bash

machine:NewBidsDataSet user$ tree
.
├── README
├── dataset_description.json
├── participants.json
├── participants.tsv
└── sub-01
    ├── ses-retestscan
    │   └── pet
    │       ├── sub-01_ses-retestscan_pet.json
    │       ├── sub-01_ses-retestscan_recording-Manual_blood.json
    │       ├── sub-01_ses-retestscan_recording-Manual_blood.tsv
    │       └── sub-01_ses-retestscan_pet.nii
    └── ses-testscan
        ├── anat
        │   ├── sub-01_ses-testscan_T1w.json
        │   └── sub-01_ses-testscan_T1w.nii
        └── pet
            ├── sub-01_ses-testscan_pet.json
            ├── sub-01_ses-testscan_recording-Manual_blood.json
            ├── sub-01_ses-testscan_recording-Manual_blood.tsv
            └── sub-01_ses-testscan_pet.nii
```

### Last Steps

#### Installing the validator

The above structure is a valid bids dataset, however the bids-validator is a
much more accurate and trustworthy method for making that determination. Follow
the instructions
[here](https://github.com/bids-standard/bids-validator) to collect
and install the validator.

#### Validating your new dataset

Using the validator installed above in the previous step point it at your data
and check to see if your conversion was successful:

```bash
machine:Projects user$ bids-validator NewBidsDataSet/
bids-validator@1.7.2

 1: [ERR] Invalid JSON file. The file is not formatted according the schema. (code: 55 - JSON_SCHEMA_VALIDATION_ERROR)
  ./dataset_description.json
   Evidence: .DatasetType should be equal to one of the allowed values
  ./dataset_description.json
   Evidence: .EthicsApprovals should be array

 Please visit https://neurostars.org/search?q=DATASET_DESCRIPTION_JSON_MISSING for existing conversations about this issue.


        Summary:               Available Tasks:        Available Modalities:
        13 Files, 4.55GB                               pet
        1 - Subject                                    blood
        2 - Sessions                                   anat


 If you have any questions, please post on https://neurostars.org/tags/bids.
```

Good enough! But, in all seriousness the error messages and output from the
bids-validator are **invaluable** during the conversion process. The error
messages will guide you to the correct format; do not fear them. Running the
validator during the conversion process will help to increase your familiarity
with the specification and ensure that your data is properly formatted.

## Final thoughts

If this seems like a daunting and tedious process to you, then you are correct
in your observation. PET is new to the bids standard, but at this very moment
there are people working on stream-lining data collection and conversion to help
move PET into this standard. Heck, if you're reading this you've just become one
of those people.
