import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heart_attack_detection_fe/models/diagnosis.d.dart';
import 'enteringInformation/index.dart';
import 'processingPrediction/index.dart';
import 'displayingResult/index.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/predictApi.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/receiveUserInputApi.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
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
    
  try {
    Diagnosis diagnosis = Diagnosis(
      age: Provider.of<PatientProvider>(context, listen: false).patient!.age,
      trtbps: inputData['trtbps'],
      chol: inputData['chol'],
      oldpeak: inputData['oldpeak'],
      sex: Provider.of<PatientProvider>(context, listen: false).patient!.gender,
      exng: inputData['exng'],
      caa: inputData['caa'],
      cp: inputData['cp'],
      fbs: inputData['fbs'],
      slp: inputData['slp'],
      thall: inputData['thall'],
    );

    String userInputResponse = await ReceiveUserInputAPI.receiveUserInput(diagnosis);

    if (userInputResponse.startsWith('Prediction failed')) {
      throw Exception(userInputResponse);
    }

    String result = await PredictAPI.predict();

    if (result.startsWith('Prediction failed')) {
      throw Exception(result);
    }

    setState(() {
      predictionResult = result;
      isPredicting = false;
    });
  } catch (error) {
    setState(() {
      isPredicting = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error during prediction: $error')),
    );
  }
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
