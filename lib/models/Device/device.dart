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
  final List<Map<String, dynamic>> unassigned_patient;

  UnassignedPatient({
    required this.unassigned_patient,
  });

  factory UnassignedPatient.fromJson(Map<String, dynamic> json) => _$UnassignedPatientFromJson(json);
  Map<String, dynamic> toJson() => _$UnassignedPatientToJson(this);
}

@JsonSerializable()
class AssignDevice {
  int? patient_id;

  AssignDevice({
    required this.patient_id,
  });

  factory AssignDevice.fromJson(Map<String, dynamic> json) => _$AssignDeviceFromJson(json);
  Map<String, dynamic> toJson() => _$AssignDeviceToJson(this);
}