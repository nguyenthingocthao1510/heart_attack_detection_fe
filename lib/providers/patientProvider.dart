import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/patient.d.dart';

class PatientProvider extends ChangeNotifier {
  int? _patientId;

  int? get patientId => _patientId;

  String? _needPrediction;

  String? get needPrediction => _needPrediction;

  Patient? _patient;

  Patient? get patient => _patient;

  void setPatientId(int? patientId) {
    _patientId = patientId;
    notifyListeners();
  }

  void setNeedPrediction(String? needPrediction) {
    _needPrediction = needPrediction;
    notifyListeners();
  }

  void setPatient(Patient? patient) {
    _patient = patient;
    notifyListeners();
  }

}