"""
WARNING:
This script was created in October 2018 when the specification
for MP2RAGE files was not fully finalized. Please double check with
latest version of the specs to make sure this is accurate.

This script will create the JSON files required for an MP2RAGE file.
To function it requires a BIDS data set with properly named image files:
The script will go through all the folders of a BIDS data set and will create
the JSON files in every folder where it finds a file ending
with '_inv-1_part-mag_MPRAGE.nii.gz'.

Created by RG 2018-10-03
"""
import glob
import json
import os
from collections import OrderedDict

start_dir = ""  # insert here path to your BIDS data set

# DEFINE CONTENT OF JSON FILES

# defining the content of the JSON file for the
# first inversion image (sub-*_inv-1_MPRAGE.json)
data_inv_1 = OrderedDict([("InversionTime", "900"), ("FlipAngle", "5")])  # ms

# defining the content of the JSON file for the
# second inversion image (sub-*_inv-2_MPRAGE.json)
data_inv_2 = OrderedDict([("InversionTime", "2750"), ("FlipAngle", "3")])  # ms

# defining the content of the JSON files for the
# T1w (sub-*_T1w.json) and the T1map (sub-*_T1map.json)
data_T1 = OrderedDict(
    [
        ("EstimationMethod", "Marques et al., 2013"),
    ]
)

# defining the content of the main JSON file (sub-*_MPRAGE.json)
data_MP2RAGE = OrderedDict(
    [
        ("MagneticFieldStrength", ""),
        ("ExcitationRepetitionTime", ""),
        ("InversionRepetitionTime", ""),
        ("NumberShots", ""),
        ("Manufacturer", ""),
        ("ManufacturersModelName", ""),
        ("DeviceSerialNumber", ""),
        ("SoftwareVersions", ""),
        ("StationName", ""),
        ("InstitutionName", ""),
        ("InstitutionAddress", ""),
        ("InstitutionalDepartmentName", ""),
        ("ReceiveCoilName", ""),
        ("ReceiveCoilActiveElements", ""),
        ("GradientSetType", ""),
        ("MRTransmitCoilSequence", ""),
        ("MatrixCoilMode", ""),
        ("CoilCombinationMethod", ""),
        ("NonlinearGradientCorrection", ""),
        ("WaterFatShift", ""),
        ("EchoTrainLength", ""),
        ("DwellTime", ""),
        ("MultibandAccelerationFactor", ""),
        ("AnatomicalLandmarkCoordinates", ""),
        ("MRAcquisitionType", ""),
        ("ScanningSequence", ""),
        ("SequenceVariant", ""),
        ("ScanOptions", ""),
        ("SequenceName", ""),
        ("PulseSequenceType", "MP2RAGE"),
        ("PulseSequenceDetails", ""),
        ("ParallelReductionFactorInPlane", ""),
        ("ParallelAcquisitionTechnique", ""),
        ("PartialFourier", ""),
        ("PartialFourierDirection", ""),
        ("EffectiveEchoSpacing", ""),
        ("TotalReadoutTime", ""),
        ("PhaseEncodingDirection", ""),
        ("EchoTime1", ""),  # sec
        ("EchoTime2", ""),  # sec
        ("SliceThickness", ""),  # mm
    ]
)

# WRITE THEM
indent = 4

# list all subjects and  create iterator with full path for subjects folder
file_ls = glob.glob(
    os.path.join(start_dir, "sub*", "**", "*_inv-1_part-mag_MPRAGE.nii.gz"),
    recursive=True,
)

for f in file_ls:
    # creates the json files in the folder where the magnitude image
    # of the first inversion is found
    path, fname = os.path.split(f)

    #  define filename, excluding last three key-value pairs
    sid = "_".join(fname.split("_")[:-3])

    # adding content to JSON files for the T1w and T1map
    # as its content is subject dependent
    inv1_mag = os.path.join("anat", f"{sid}_inv1_part-mag_MPRAGE.nii.gz")
    inv1_phs = os.path.join("anat", f"{sid}_inv1_part-phase_MPRAGE.nii.gz")
    inv2_mag = os.path.join("anat", f"{sid}_inv2_part-mag_MPRAGE.nii.gz")
    inv2_phs = os.path.join("anat", f"{sid}_inv2_part-phase_MPRAGE.nii.gz")

    data_T1["BasedOn"] = f"{inv1_mag}, {inv1_phs}, {inv2_mag}, {inv2_phs}, "

    # define json files for all image types
    json_names = [
        "{}_inv-1_MPRAGE.json",
        "{}_inv-2_MPRAGE.json",
        "{}_MPRAGE.json",
        "{}_T1map.json",
        "{}_T1w.json",
    ]
    data_types = [data_inv_1, data_inv_2, data_MP2RAGE, data_T1, data_T1]
    out_files = zip(json_names, data_types)

    for out_file in out_files:
        json_name, data_type = out_file[0], out_file[1]
        with open(os.path.join(path, json_name.format(sid)), "w") as ff:
            json.dump(data_type, ff, sort_keys=False, indent=indent)
