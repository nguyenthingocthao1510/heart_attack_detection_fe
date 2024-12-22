// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagnosisResult _$DiagnosisResultFromJson(Map<String, dynamic> json) =>
    DiagnosisResult(
      patientId: (json['patientId'] as num?)?.toInt(),
      prediction: (json['prediction'] as num).toInt(),
      thalachh: (json['thalachh'] as num).toInt(),
      restecg: (json['restecg'] as num).toInt(),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$DiagnosisResultToJson(DiagnosisResult instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'prediction': instance.prediction,
      'thalachh': instance.thalachh,
      'restecg': instance.restecg,
      'timestamp': instance.timestamp,
    };
