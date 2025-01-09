import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class DiagnosisResult {
  int? patient_id;
  final int prediction;
  final int thalachh;
  final int restecg;
  final String timestamp;

  DiagnosisResult({
    this.patient_id,
    required this.prediction,
    required this.thalachh,
    required this.restecg,
    required this.timestamp
});

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) => _$DiagnosisResultFromJson(json);
  Map<String, dynamic> toJson() => _$DiagnosisResultToJson(this);
}

@JsonSerializable()
class History {
  List<Map<String, dynamic>> history;

  History({
    required this.history
  });

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}