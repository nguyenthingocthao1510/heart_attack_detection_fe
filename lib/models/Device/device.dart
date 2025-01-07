import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  final List<Map<String, dynamic>> device;
  final int total;

  Device({
    required this.device,
    required this.total,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@JsonSerializable()
class UnassignedPatient {
  final List<Map<String, dynamic>> unassignedPatient;

  UnassignedPatient({
    required this.unassignedPatient,
  });

  factory UnassignedPatient.fromJson(Map<String, dynamic> json) => _$UnassignedPatientFromJson(json);
  Map<String, dynamic> toJson() => _$UnassignedPatientToJson(this);
}