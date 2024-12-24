import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/diagnosis.d.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.dart';
import 'DiagnosisForm/index.dart';
import 'ProcessPrediction/index.dart';
import 'DisplayResult/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/History/index.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/predictApi.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/receiveUserInputApi.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/History/diagnosisHistoryApi.dart';

import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  DiagnosisResult? predictionResult;
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

    PredictAPI predictAPI = PredictAPI();
    DiagnosisResult result = await predictAPI.predict();

    DiagnosisHistoryApi diagnosisHistoryApi = DiagnosisHistoryApi();
    result.patientId = Provider.of<PatientProvider>(context, listen: false).patient?.id;
    await diagnosisHistoryApi.addDiagnosisHistory(result);

    setState(() {
      predictionResult = result;
      isPredicting = false;
    });
  } catch (error) {
    setState(() {
      isPredicting = false;
    });
    print('error during prediction: $error');
  }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;

    if (isPredicting) {
      currentWidget = const ProcessPrediction();
    } else if (predictionResult != null) {
      currentWidget = DisplayResult(result: predictionResult!);
    } else {
      currentWidget = DiagnosisForm(onSubmit: startPrediction);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 15, right: 10, bottom: 10),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(icon64px),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: const Text('Diagnosis',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 10, bottom: 10),
              child: Container(
                width: 40,
                height: 40,
                child: IconButton(
                  icon: Image.asset(historyIcon),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosisHistory()));
                  },
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: currentWidget,
    );
  }
}
