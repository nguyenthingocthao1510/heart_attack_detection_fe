// lib/pages/diagnose_page.dart
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/diagnosis.d.dart';
import 'enteringInformation/index.dart';
import 'processingPrediction/index.dart';
import 'displayingResult/index.dart';
import 'package:heart_attack_detection_fe/services/predictApi.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  String? predictionResult;
  bool isPredicting = false;

  void startPrediction(Map<String, dynamic> inputData) async {
    setState(() {
      isPredicting = true;
    });

    Diagnosis diagnosis = Diagnosis(
      age: inputData['age'],
      trtbps: inputData['trtbps'],
      chol: inputData['chol'],
      thalachh: inputData['thalachh'],
      oldpeak: inputData['oldpeak'],
      sex: inputData['sex'],
      exng: inputData['exng'],
      caa: inputData['caa'],
      cp: inputData['cp'],
      fbs: inputData['fbs'],
      restecg: inputData['restecg'],
      slp: inputData['slp'],
      thall: inputData['thall'],
    );

    String result = await PredictAPI.predict(diagnosis);

    setState(() {
      predictionResult = result;
      isPredicting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;

    if (isPredicting) {
      currentWidget = const ProcessingPrediction();
    } else if (predictionResult != null) {
      currentWidget = DisplayingResult(result: predictionResult!);
    } else {
      currentWidget = EnteringInformation(onSubmit: startPrediction);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Heart Attack Diagnosis')),
      body: currentWidget,
    );
  }
}
