import json
from collections import OrderedDict

data = OrderedDict()
data['Manufacturer'] = ' '
data['ManufacturersModelName'] = ' '
data['MagneticFieldStrength'] = ' '
data['DeviceSerialNumber'] = ' '
data['StationName'] = ' '
data['SoftwareVersions'] = ' '
data['HardcopyDeviceSoftwareVersion'] = ' '
data['ReceiveCoilName'] = ' '
data['ReceiveCoilActiveElements'] = ' '
data['GradientSetType'] = ' '
data['MRTransmitCoilSequence'] = ' '
data['MatrixCoilMode'] = ' '
data['CoilCombinationMethod'] = ' '
data['PulseSequenceType'] = ' '
data['ScanningSequence'] = ' '
data['SequenceVariant'] = ' '
data['ScanOptions'] = ' '
data['SequenceName'] = ' '
data['PulseSequenceDetails'] = ' '
data['NonlinearGradientCorrection'] = ' '
data['NumberShots'] = ' '
data['ParallelReductionFactorInPlane'] = ' '
data['ParallelAcquisitionTechnique'] = ' '
data['PartialFourier'] = ' '
data['PartialFourierDirection'] = ' '
data['PhaseEncodingDirection'] = ' '
data['EffectiveEchoSpacing'] = ' '
data['TotalReadoutTime'] = ' '
data['WaterFatShift'] = ' '
data['EchoTrainLength'] = ' '
data['EchoTime'] = ' '
data['InversionTime'] = ' '
data['SliceTiming'] = ' '
data['SliceEncodingDirection'] = ' '
data['DwellTime'] = ' '
data['FlipAngle'] = ' '
data['MultibandAccelerationFactor'] = ' '
data['AnatomicalLandmarkCoordinates'] = ' '
data['InstitutionName'] = ' '
data['InstitutionAddress'] = ' '
data['InstitutionalDepartmentName'] = ' '
data['ContrastBolusIngredient'] = ' '

root_dir = '../templates/sub-01/'
project_label = 'ses-01/anat/sub-01_ses-01_acq-FullExample_run-01_T1w.json'
dataset_json_folder = root_dir+project_label
dataset_json_name = dataset_json_folder

with open(dataset_json_name, 'w') as ff:
                json.dump(data, ff, sort_keys=False, indent=4)
