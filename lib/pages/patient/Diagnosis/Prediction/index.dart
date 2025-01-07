import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/diagnosis.d.dart';
import 'package:heart_attack_detection_fe/models/Diagnosis/result.dart';
import 'DiagnosisForm/index.dart';
import 'ProcessPrediction/index.dart';
import 'DisplayResult/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/History/index.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/Prediction/predictApi.dart';
import 'package:heart_attack_detection_fe/services/Diagnosis/Prediction/receiveUserInputApi.dart';
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
        title: Text(
          'Diagnosis',
          style: CustomTextStyle.textStyle1(28, Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 139, 251),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Image.asset(
                historyIcon,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const DiagnosisHistory()));
              },
            ),
          ),
        ],
      ),
      body: currentWidget,
    );
  }
}
