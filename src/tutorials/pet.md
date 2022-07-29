# PET data conversion

## History

The PET modality is an addition to BIDS with its introduction via BEP 009. 
If you're interested in seeing exactly what and how something gets added to BIDS
see the pull request for BEP009
[here](https://github.com/bids-standard/bids-specification/pull/633). 
The results of that extension proposal can be read
[here](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/09-positron-emission-tomography.html#positron-emission-tomography)
in the BIDS standard.

## PET image data file formats

Before we start to convert data we need to quickly mention 
that PET image data files come of the scanner in various different formats: 
some scanners provide DICOM files (.dcm) 
and others use proprietary formats for example ECAT format (.v). 
In order to facilitate easy testing of data conversion across different PET file formats 
the [OpenNeuroPET project][OpenNeuroPET project] has compiled a bunch of phantom data 
from different scanner types and is distributing two examples
[here](https://drive.google.com/file/d/10S0H7HAnMmxHNpZLlifR14ykIuiXcBAD/view?usp=sharing).

You can download them for testing purposes either manually 
or in the terminal by typing:

```{code-block} bash
gdown https://drive.google.com/file/d/10S0H7HAnMmxHNpZLlifR14ykIuiXcBAD/view?usp=sharing --fuzzy
```

You may need to install the python package [`gdown`](https://github.com/wkentaro/gdown)
for this to work:

```{code-block} bash
pip install gdown
```

And then unzipping the downloaded file:

```{code-block} bash
unzip OpenNeuroPET-Demo_raw.zip
```

You can now look at the file tree:

```{code-block}
tree OpenNeuroPET-Demo_raw.

OpenNeuroPET-Demo_raw
│   .bidsignore
│   .DS_Store
│   dataset_description.json
│   README
│
├───code
│       .python_conversions.sh.swp
│       matlab_conversions.m
│       python_conversions.sh
│       README.md
│
├───source
│   │   .DS_Store
│   │
│   ├───SiemensBiographPETMR-NRU
│   │       X-CAL_7.PT.Kalibrering_xca.30003.1.2022.04.26.15.04.22.218.14689529.dcm
│   │       X-CAL_7.PT.Kalibrering_xca.30003.10.2022.04.26.15.04.22.218.14689628.dcm
│   │       X-CAL_7.PT.Kalibrering_xca.30003.100.2022.04.26.15.04.22.218.14690618.dcm
│   │       X-CAL_7.PT.Kalibrering_xca.30003.101.2022.04.26.15.04.22.218.14690629.dcm
│   │       ....
│   │
│   └───SiemensHRRT-NRU
│           XCal-Hrrt-2022.04.21.15.43.05_EM_3D.json
│           XCal-Hrrt-2022.04.21.15.43.05_EM_3D.v
│
├───sub-SiemensBiographNRU
│   └───pet
│           sub-SiemensBiographNRU_pet.json
│           sub-SiemensBiographNRU_pet.nii.gz
│
└───sub-SiemensHRRT
    └───pet
            sub-SiemensHRRT_pet.json
            sub-SiemensHRRT_pet.nii.gz
```

Now you have an example dataset where you have source data 
(both for ECAT and DICOM PET image format) 
and the PET BIDS data sets constructed for it.

Also if you have access to another PET image file format, 
or data from a scanner not tested, 
please reach out to [OpenNeuroPET project][OpenNeuroPET project] 
in order to add a phantom scan in your format.

## Conversion

The [OpenNeuroPET project][OpenNeuroPET project] has tried to develop tools 
for facilitating easy data conversion for PET. 
The main tool used for this is [PET2BIDS][PET2BIDS] 
freely available on the [OpenNeuroPET GitHub repository](https://github.com/openneuropet) 
along with other resources like altlases or pipelines. 

It is available for both Python and MATLAB. 
Eventually, [PET2BIDS][PET2BIDS] will also be wrapped inside other BIDS conversion tools 
such as [BIDScoin](https://github.com/Donders-Institute/bidscoin) or
[ezBIDS](https://brainlife.io/ezbids/), 
but this is work in progress at the moment.

Besides using [PET2BIDS][PET2BIDS] there is always the possibility to manually convert a data set 
to PET BIDS and an example will be shown below. 
In any case, for DICOM data format, one relies on
[dcm2niix](https://www.nitrc.org/plugins/mwiki/index.php/dcm2nii:MainPage).

Below we will show two ways of converting your PET data to BIDS:

1. using [PET2BIDS][PET2BIDS] and
2. manually.

### 1) Conversion of PET data using PET2BIDS

Detailed documentation for PET2BIDS can be found
[here](https://pet2bids.readthedocs.io/en/latest/index.html#) or on the
[Github repo](https://github.com/openneuropet/PET2BIDS/blob/main/README.md).

#### get dcm2niix

Download [dcm2niix](https://www.nitrc.org/plugins/mwiki/index.php/dcm2nii:MainPage), 
and for Mac and Linux users you can add it to your path, 
for instance it would could downloaded and unzipped into `/bin`.

```{code-block} bash
export PATH="/home/$USER/bin:$PATH"
```

#### For Python

Open your terminal, either regular or anaconda terminal and type.

```{code-block} bash
pip install pypet2bids
```

Now you already have the converter installed and can go ahead 
and convert your first dataset!

In this example, we are converting an image in DICOM format. 
It should be noted that `pypet2bids` contains several different tools 
and is itself a part of the larger PET library `PET2BIDS`, 
the specific tool we will be using for the following DICOM conversion is `dcm2niix4pet`.

You just need to point `dcm2niix4pet` to:

-   the folder where your data resides, `dcmfolder`, and
-   the folder where you want to output the PET BIDS formatted dataset, `mynewfolder`.

```{code-block} bash
dcm2niix4pet dcmfolder -d mynewfolder
```

```{note}
`dcm2niix4pet` will do its best to extract as much information 
about radiological and blood data from the DICOM files in the `dcmfolder`. 
However, `dcm2niix4pet` can't find information if it isn't there, 
hence it will often be up to you the user 
to provide some missing information at the time of conversion.
```

Additional information can be provided via the command line 
with the `--kwargs` argument in the form of key=pair values. 
For an idea of what this looks like see below:

```{code-block} bash
dcm2niix4pet /OpenNeuroPET-Demo_raw/source/SiemensBiographPETMR-NRU \
            -d mynewfolder \
            --kwargs    TimeZero=ScanStart \
                        Manufacturer=Siemens \
                        ManufacturersModelName=Biograph \
                        InstitutionName="Rigshospitalet, NRU, DK" \
                        BodyPart=Phantom \
                        Units=Bq/mL \
                        TracerName=none \
                        TracerRadionuclide=F18 \
                        InjectedRadioactivity=81.24 \
                        SpecificRadioactivity=13019.23 \
                        ModeOfAdministration=infusion \
                        FrameTimesStart=0 \
                        AcquisitionMode="list mode" \
                        ImageDecayCorrected=true \
                        ImageDecayCorrectionTime=0 \
                        AttenuationCorrection=MR-corrected \
                        FrameDuration=300 \
                        FrameTimesStart=0
```

Now you have a dataset in PET BIDS format. 
You will probably have gotten some warnings relating to the `.json` sidecar file. 
Carefully look at them, since they will help you to catch inconsistencies 
and missing required fields that you need to add 
in order for the dataset to pass the BIDS validator as well (see below how that's done). 
You can always edit the `.json` file, by opening it in a text editor and manually fixing errors. 
Alternatively, adjust the meta structure you created above to correct the errors.

#### For MATLAB

Download/Clone the [PET2BIDS][PET2BIDS] GitHub repository. 
Windows users must, in addition, indicate the full path of where is the `dcm2niix.exe` in
[dcm2niix4pet.m](https://github.com/openneuropet/PET2BIDS/blob/main/matlab/dcm2niix4pet.m#L42).

Then, just follow the
[MATLAB README](https://github.com/openneuropet/PET2BIDS/blob/main/matlab/Readme.md).
In the following it is just described how to convert DICOM files. 
It's very similar and described in the
[MATLAB README](https://github.com/openneuropet/PET2BIDS/blob/main/matlab/Readme.md)
how to handle ECAT files.

The entire PET2BIDS repository or only the MATLAB subfolder (your choice) should be in your MATLAB path.

Defaults parameters can be set in `(scannername).txt` files to generate metadata easily 
(meaning to avoid passing all arguments in although this is also possible). 
You can find templates of such parameter file under
[`/template_txt`](https://github.com/openneuropet/PET2BIDS/tree/main/matlab/template_txt):

-   SiemensHRRTparameters.txt,
-   SiemensBiographparameters.txt,
-   GEAdvanceparameters.txt,
-   PhilipsVereosparameters.txt.

Now in order to convert a PET dataset on disk to PET BIDS, 
one creates a structure containing all the meta information (here passing on all arguments)
and then point the function to the folder where your data resides `dcmfolder`
and the folder where you want to output the PET BIDS formatted dataset `mynewfolder`:

```{code-block} matlab
meta = get_pet_metadata('Scanner', 'SiemensBiograph', ...
                        'TimeZero', 'ScanStart', ...
                        'TracerName', 'CB36', ...
                        'TracerRadionuclide', 'C11', ...
                        'ModeOfAdministration',  'infusion', ...
                        'SpecificRadioactivity', 605.3220, ...
                        'InjectedMass', 1.5934, ...
                        'MolarActivity', 107.66, ...
                        'InstitutionName', 'Rigshospitalet, NRU, DK', ...
                        'AcquisitionMode', 'list mode', ...
                        'ImageDecayCorrected', 'true', ...
                        'ImageDecayCorrectionTime', 0, ...
                        'ReconMethodName', 'OP-OSEM', ...
                        'ReconMethodParameterLabels', {'subsets', 'iterations'}, ...
                        'ReconMethodParameterUnits', {'none', 'none'}, ...
                        'ReconMethodParameterValues', [21 3], ...
                        'ReconFilterType', 'XYZGAUSSIAN', ...
                        'ReconFilterSize', 2, ...
                        'AttenuationCorrection', 'CT-based attenuation correction');

dcm2niix4pet(dcmfolder, meta, 'o', mynewfolder);
```

```{eval-rst}
.. note::

    ``get_pet_metadata`` can be called in a much simpler way 
    if you have a ``\*parameters.txt`` seating on disk next to this function. 
    The call would then looks like:

    .. code-block:: matlab

        % your SiemensBiographparameters.txt file is stored next to get_pet_metadata.m
        meta = get_pet_metadata('Scanner', 'SiemensBiograph', ...
                                'TimeZero', 'ScanStart', ...
                                'TracerName', 'CB36', ...
                                'TracerRadionuclide', 'C11', ...
                                'ModeOfAdministration', 'infusion', ...
                                'SpecificRadioactivity', 605.3220, ...
                                'InjectedMass', 1.5934, ...
                                'MolarActivity', 107.66);

        dcm2niix4pet(dcmfolder, meta, 'o', mynewfolder);
```

Now you have a dataset in PET BIDS format. 
You will probably have gotten some warnings relating to the `.json` sidecar file. 
Carefully look at them, since they will help you to catch inconsistencies 
and missing required fields that you need to add 
in order for the dataset to pass the BIDS validator as well (see below how that's done). 

You can always edit the `.json` file, by opening it in a text editor and manually fixing errors. 

Alternatively, adjust the meta structure you created above to correct the errors.

### 2) Manual conversion of PET data to PET BIDS

As stated above PET files come of the scanner in various formats. 
In the following manual data conversion is shown for an ECAT (.v) 
as well as a DICOM (.dcm) PET image dataset.

#### PET image data in ECAT format

Here is the structure of our starting dataset:

```{code-block} bash
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

By the end of this document our starting dataset will be fully BIDS compliant
and similar to the dataset seen
[here](https://github.com/bids-standard/bids-examples/tree/master/pet001).

#### Setting the layout

This starter kit provides several template/example files 
that can be a great starting place to help get set up for the conversion process. 
PET specific text data files can be viewed at
[this location](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/pet).
and easily collected via this
[link](https://github.com/bids-standard/bids-starter-kit/archive/refs/heads/main.zip)
or be cloned and extracted via git at the command line via:

```{code-block} bash
git clone git@github.com:bids-standard/bids-starter-kit.git
```

The [`templates/`](https://github.com/bids-standard/bids-starter-kit/tree/main/templates/sub-01/ses-01/pet) folder in `bids-starter-kit/` contains a single subject 
and examples of every BIDS modality text and `.json` file for that subject.
Additionally, there exists a `Short` and a `Full` example for each text/json file. 
The `Short` files contain only the required BIDS fields for each modality
and the `Full` example files contain _every_ field included within the BIDS standard.

```{code-block} bash
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

For the purposes of this exercise we will only be focusing on obtaining the minimum required fields, 
thus we collect and copy the following to our own BIDS folder.

```{code-block} bash
# create the new BIDS folder
mkdir -p /NewBidsDataSet/sub-01/ses-01/pet
cp -r /path/to/bids-starter-kit/templates/sub-01/ses-01/pet/* /NewBidsDataSet/sub-01/pet/
```

Oops, we forgot to include our dataset specific files. 
Let's make it easy on ourselves and include the templates for those too.

```{code-block} bash
cp /path/to/bids-starter-kit/templates/* /NewBidsDataSet/
```

Our skeleton of a data set should now look like this:

```{code-block} bash
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

```{code-block} bash
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

That certainly looks less daunting, now let's change the filenames of the templates 
so that they make more sense for our data set (by removing `ShortExample` from each filename).

```{note}
If you have multiple PET image files you can distinguish between them
by creating a session folder with a unique name
and then applying the `ses-<label>` label to each file therein.
If there's a single pet scan you may omit the additional folder
and corresponding label(s) from the filename.
For more information on labeling see [this link](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/09-positron-emission-tomography.html#pet-recording-data).
```

```{code-block} bash
# for those of you in bash land
machine:Projects user$ cd NewBidsDataSet/sub-01/ses-01/pet
machine:pet user$ for i in *ShortExample*; do mv "$i" "`echo $i | sed 's/ShortExample//'`"; done

# Since we "don't" know if there are multiple PET image files 
# we will omit the task label for our PET .json file for now.
machine:pet user$ mv sub-01_ses-01_task-_pet.json sub-01-ses-01_pet.json
```

After you've renamed your files your directory should look something like:

```{code-block} bash
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

Ok great, but where do the imaging files go? 
And what format should they be in?
And there's at least 2 `.v` pet files shouldn't there be multiple sessions?

Well yes, yes, and yes. but before we add more sessions/directories 
we're going to make sure we have images to place in them.

#### Collecting and installing TPCCLIB

Since our raw imaging files are in ECAT format, 
we'll be using the `ecat2nii` tool it the Turku PET Centre C library (`TPCCLIIB`)
as it's very handy at converting PET ECAT images into the more BIDS friendly nifti format. 
If you're imaging files are in `.IMG` you can use \*\*<\insert converter>\*\* 
or if they're in DICOM `dcm2niix` is an excellent tool to transform `.dcm` files into `.nii`.

Before we proceed we will need to collect and install the `ecat2nii` tool from the `TPCCLIIB` a container, 
or a VM if you want to continue following along.

If you're on a non-posix based OS, we suggest you use WSL (windows subsystem for linux).

1. Visit <https://gitlab.utu.fi/vesoik/tpcclib>
2. Download tpcclib via your download link of choice, ours is
   [here](https://gitlab.utu.fi/vesoik/tpcclib/-/archive/master/tpcclib-master.zip)
3. Once downloaded extract and place `ecat2nii` in an appropriate place

If you're using bash/posix step 3 will resemble something like the following:

```{code-block} bash
machine:Downloads user$ unzip tpcclib-master.zip
machine:Downloads user$ mv tpcclib-master /some/directory/you/are/fond/of/ # could be /usr/bin if you so choose
```

Now you can choose to add `tpcclib` to your path or not, in bash land we do the following:

```{code-block} bash
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

Congrats, you've installed `ecat2nii`, you're one step closer to bidsifying your dataset

Now, let's convert one of our PET ECAT images 
and move it to its final destination with `ecat2nii` that we just installed.

```{code-block} bash
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

Before we get too carried away, lets use populate our `*_pet.json` files 
with the relevant information from our ECAT and dataset.

This writer used a python tool specifically created to parse ECAT's 
for header and subheader info [ecatdump](https://github.com/bendhouseart/ecatdump).
All it does is use Python libraries Nibabel and Argparse 
to collect and spit out the header information from an ECAT file.

You can use and install it via pip and use it on your command line like below:

```{code-block} bash
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

```{code-block} python
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

Using your wits, the available tools, and data you should be able 
to produce a sidecar file like the following for your nifti image. 
Repeat this process for each image file/nifti you're including 
while reusing the filename for each image 
and while substituting the extention to `.json` instead of `.nii`.

```{code-block} json
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

Alright, now we're getting somewhere, let's rename these niftis 
so that it's easier to distinguish between them 
and so that they're both BIDS compliant.

```{code-block} bash
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

```{code-block} bash
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

That looks better, now that we've got our nifti's sorted 
let's do something about filling out our `*_blood.tsv` files and our `*_blood.json` files.

<!-- TODO grab that image and add to the repo -->

Here's are the contents of `sub01_7_PLASMA.txt`:
![sub01_7_PLASMA.txt screenshot of excell](https://i.imgur.com/xBgDZcI.png)

Since our plasma data is available we need to indicate as such 
in our `*_blood.json` files so we do so now:

```{code-block} json
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

Additionally, we can open our `*_blood.tsv` 
and add the plasma series of data to it from our base text file:

<!-- TODO grab that image and add to the repo -->

![screenshot of unconverted sub-01_ses-testscan_recording-Manual_blood.tsv](https://i.imgur.com/VdFqh6H.png)

Whoops, these numbers aren't in SI units, so we quickly convert time 
from minutes to seconds and Microcurie to Becquerel to conform to the spec.

```{note}
If you're wondering what method was used to determine what units these unlabeled columns were in 
we can only tell you that prior knowledge, access to the associated publishing, 
or experience/domain knowledge coupled with a bit of guesswork 
are required to make that determination. 
One of the aims of adding PET to BIDS is to help to avoid confusion at this level of the process 
and instead allow researchers to reserve that confusion 
for use at some other point during the research process.
```

After a bit of conversion and the inclusion of the metabolite parent fraction
(which if present is
[recommended](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/09-positron-emission-tomography.html#blood-recording-data)
to be included):

<!-- TODO grab that image and add to the repo -->

![screenshot of converted and minimally complete manual_blood.tsv](https://i.imgur.com/nWXcFsw.png)

Now just repeat this process for each required field in the `*_blood.json` file
and/or for each recommended field 
that you wish to include from your non-BIDS dataset into this bidsified one. 
The final results of our efforts leads us to having this final `*blood_.json`:

```{code-block} json
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

#### Last Pass

If you're thinking that we failed to document or include our T1 image 
from the start you would be correct. 

There are many resources documenting that process
[here](https://bids-standard.github.io/bids-starter-kit/tutorials/mri.html).

Once you've handled converting your MR images into BIDS 
your directory should look like the following:

```{code-block} bash

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

## Validating your converted PET BIDS data set

### Installing the validator

The above structure is a valid BIDS dataset, 
however the bids-validator is a much more accurate and trustworthy method 
for making that determination. 
Follow the instructions [here](https://github.com/bids-standard/bids-validator) 
to collect and install the validator.

### Validating your new dataset

Using the validator installed above in the previous step point it at your data
and check to see if your conversion was successful:

```{code-block} bash
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

Good enough! But, in all seriousness the error messages and output 
from the bids-validator are **invaluable** during the conversion process. 
The error messages will guide you to the correct format; do not fear them. 
Running the validator during the conversion process will help to increase your familiarity
with the specification and ensure that your data is properly formatted.

## Tools and resources for PET conversion

Some useful tools and resources that have been used in this document are as
follows:

-   [BIDS Validator](https://github.com/bids-standard/bids-validator), which
    fully supports PET
-   [PET2BIDS][PET2BIDS] is a MATLAB and Python utility 
    for converting your data to PET BIDS format

-   [TPCCLIIB](https://gitlab.utu.fi/vesoik/tpcclib) is a command line library
    containing (among many others) PET tools such as `ecat2nii` 
    that will be used below to convert the imaging data from a PET dataset into nifti format.
    The Turku PET Centre site can be found [here](https://turkupetcentre.fi/)
    for additional information on anything PET.
-   a [BIDS PET Template](https://github.com/bids-standard/bids-starter-kit/tree/main/templates)
    from this starter kit to initially populate 
    and translate text/tabulature/csv blood data
    into BIDS PET compliant `.tsv` and `.json` files.
-   [dcm2niix](https://github.com/rordenlab/dcm2niix) can be used 
    if your raw pet data happens to be in a DICOM format. 
    Additionally this opens up the use of tools 
    such as [dcmdump](https://support.dcmtk.org/docs/dcmdump.html) 
    from the [dcmtk](https://support.dcmtk.org/docs/) to help in your conversion.

## Final thoughts

As of now, PET is still quite new to the BIDS standard, 
but at this very moment there are people working on stream-lining data collection 
and conversion to help move PET into this standard. 

If you're reading this you've just become one of those people. 
Feel free to reach out to the [OpenNeuroPET project][OpenNeuroPET project]


<!-- links -->

[OpenNeuroPET project]: https://openneuropet.github.io/
[PET2BIDS]: https://github.com/openneuropet/PET2BIDS
