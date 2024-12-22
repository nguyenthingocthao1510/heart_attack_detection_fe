import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class DiagnosisResult {
  int? patientId;
  final int prediction;
  final int thalachh;
  final int restecg;
  final String timestamp;

  DiagnosisResult({
    this.patientId,
    required this.prediction,
    required this.thalachh,
    required this.restecg,
    required this.timestamp
});

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) => _$DiagnosisResultFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnosisResultToJson(this);
}