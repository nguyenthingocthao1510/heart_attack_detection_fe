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
      unassignedPatient: (json['unassignedPatient'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$UnassignedPatientToJson(UnassignedPatient instance) =>
    <String, dynamic>{
      'unassignedPatient': instance.unassignedPatient,
    };
