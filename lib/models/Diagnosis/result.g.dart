// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagnosisResult _$DiagnosisResultFromJson(Map<String, dynamic> json) =>
    DiagnosisResult(
      patient_id: (json['patient_id'] as num?)?.toInt(),
      prediction: (json['prediction'] as num).toInt(),
      thalachh: (json['thalachh'] as num).toInt(),
      restecg: (json['restecg'] as num).toInt(),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$DiagnosisResultToJson(DiagnosisResult instance) =>
    <String, dynamic>{
      'patient_id': instance.patient_id,
      'prediction': instance.prediction,
      'thalachh': instance.thalachh,
      'restecg': instance.restecg,
      'timestamp': instance.timestamp,
    };

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      history: (json['history'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'history': instance.history,
    };
