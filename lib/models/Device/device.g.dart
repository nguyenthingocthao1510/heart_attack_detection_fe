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
