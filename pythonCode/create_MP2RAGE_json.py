"""
WARNING:
This script was created in October 2018 when the specification
for MP2RAGE files was not fully finalized. Please double check with
latest version of the specs to make sure this is accurate.

This script will create the JSON files required for an MP2RAGE file.
To function it requires a BIDS data set with properly named image files:
The script will through all the folders of a BIDS data set and will create
the JSON files in every folder where it finds a file ending
with '_MPRAGE.nii.gz'.

Created by RG 2018-10-03
"""

import os
import json
from shutil import copyfile
from collections import OrderedDict

'''
DEFINE CONTENT OF JSON FILES
'''
# sub-*_inv-1_MPRAGE.json
data_inv_1 = OrderedDict()
data_inv_1['InversionTime'] = '900'  # ms
data_inv_1['FlipAngle'] = '5'

# sub-*_inv-2_MPRAGE.json
data_inv_2 = OrderedDict()
data_inv_2['InversionTime'] = '2750'  # ms
data_inv_2['FlipAngle'] = '3'

# sub-*_T1map.json
# sub-*_T1w.json
data_T1 = OrderedDict()
data_T1['EstimationMethod'] = 'Marques et al., 2013'


# sub-*_MPRAGE.json
data_MP2RAGE = OrderedDict()
data_MP2RAGE['MagneticFieldStrength'] = ''
data_MP2RAGE['ExcitationRepetitionTime'] = ''
data_MP2RAGE['InversionRepetitionTime'] = ''
data_MP2RAGE['NumberShots'] = ''
data_MP2RAGE['Manufacturer'] = ''
data_MP2RAGE['ManufacturersModelName'] = ''
data_MP2RAGE['DeviceSerialNumber'] = ''
data_MP2RAGE['SoftwareVersions'] = ''
data_MP2RAGE['StationName'] = ''
data_MP2RAGE['InstitutionName'] = ''
data_MP2RAGE['InstitutionAddress'] = ''
data_MP2RAGE['InstitutionalDepartmentName'] = ''
data_MP2RAGE['ReceiveCoilName'] = ''
data_MP2RAGE['ReceiveCoilActiveElements'] = ''
data_MP2RAGE['GradientSetType'] = ''
data_MP2RAGE['MRTransmitCoilSequence'] = ''
data_MP2RAGE['MatrixCoilMode'] = ''
data_MP2RAGE['CoilCombinationMethod'] = ''
data_MP2RAGE['NonlinearGradientCorrection'] = ''
data_MP2RAGE['WaterFatShift'] = ''
data_MP2RAGE['EchoTrainLength'] = ''
data_MP2RAGE['DwellTime'] = ''
data_MP2RAGE['MultibandAccelerationFactor'] = ''
data_MP2RAGE['AnatomicalLandmarkCoordinates'] = ''
data_MP2RAGE['MRAcquisitionType'] = ''
data_MP2RAGE['ScanningSequence'] = ''
data_MP2RAGE['SequenceVariant'] = ''
data_MP2RAGE['ScanOptions'] = ''
data_MP2RAGE['SequenceName'] = ''
data_MP2RAGE['PulseSequenceType'] = 'MP2RAGE'
data_MP2RAGE['PulseSequenceDetails'] = ''
data_MP2RAGE['ParallelReductionFactorInPlane'] = ''
data_MP2RAGE['ParallelAcquisitionTechnique'] = ''
data_MP2RAGE['PartialFourier'] = ''
data_MP2RAGE['PartialFourierDirection'] = ''
data_MP2RAGE['EffectiveEchoSpacing'] = ''
data_MP2RAGE['TotalReadoutTime'] = ''
data_MP2RAGE['PhaseEncodingDirection'] = ''
data_MP2RAGE['EchoTime1'] = ''  # sec
data_MP2RAGE['EchoTime2'] = ''  # sec
data_MP2RAGE['SliceThickness'] = ''  # mm


'''
WRITE THEM
'''
start_dir = ""  # insert here path to your BIDS data set

# list all subjects
subj_ls = next(os.walk(start_dir))[1]

for iSubj in subj_ls:
    print(iSubj)
    # list all subfolders and files for that subject
    subj_dir = os.walk(os.path.join(start_dir, iSubj))
    # go through all the files for that subject
    for path, subdirs, files in subj_dir:
        for name in files:
            # creates the json files in the folder where the the MP2RAGE file is found
            if '_MPRAGE.nii.gz' in name:
                print(os.path.join(path, name))

                json_folder = path

                # _inv-1_MPRAGE.json
                json_name = name[:12] + '_inv-1_MPRAGE.json'
                # create the file
                with open(os.path.join(json_folder, json_name), 'w') as ff:
                    json.dump(data_inv_1, ff, sort_keys=False, indent=4)

                # _inv-2_MPRAGE.json
                json_name = name[:12] + '_inv-2_MPRAGE.json'
                with open(os.path.join(json_folder, json_name), 'w') as ff:
                    json.dump(data_inv_2, ff, sort_keys=False, indent=4)

                # _MPRAGE.json
                json_name = name[:12] + '_MPRAGE.json'
                with open(os.path.join(json_folder, json_name), 'w') as ff:
                    json.dump(data_MP2RAGE, ff, sort_keys=False, indent=4)

                # sub-01_T1map.json
                # sub-01_T1w.json
                data_T1['BasedOn'] = \
                    os.path.join('anat', name[:12] + '_inv1_part-mag_MPRAGE.nii.gz') + ', ' + \
                    os.path.join('anat', name[:12] + '_inv1_part-phase_MPRAGE.nii.gz') + ', ' + \
                    os.path.join('anat', name[:12] + '_inv1_part-mag_MPRAGE.nii.gz') + ', ' + \
                    os.path.join('anat', name[:12] + '_inv1_part-phase_MPRAGE.nii.gz') + ', '

                json_name = name[:12] + '_T1map.json'
                with open(os.path.join(json_folder, json_name), 'w') as ff:
                    json.dump(data_T1, ff, sort_keys=False, indent=4)

                json_name = name[:12] + '_T1w.json'
                with open(os.path.join(json_folder, json_name), 'w') as ff:
                    json.dump(data_T1, ff, sort_keys=False, indent=4)
