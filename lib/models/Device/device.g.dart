// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      device: (json['device'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'device': instance.device,
      'total': instance.total,
    };

UnassignedPatient _$UnassignedPatientFromJson(Map<String, dynamic> json) =>
    UnassignedPatient(
      unassigned_patient: (json['unassigned_patient'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$UnassignedPatientToJson(UnassignedPatient instance) =>
    <String, dynamic>{
      'unassigned_patient': instance.unassigned_patient,
    };

AssignDevice _$AssignDeviceFromJson(Map<String, dynamic> json) => AssignDevice(
      patient_id: (json['patient_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignDeviceToJson(AssignDevice instance) =>
    <String, dynamic>{
      'patient_id': instance.patient_id,
    };
