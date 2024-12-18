import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/EnteringInformation/InputFormComponent/textFieldInput.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/EnteringInformation/InputFormComponent/radioInput.dart';

// ignore: must_be_immutable
class EnteringInformation extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const EnteringInformation({super.key, required this.onSubmit});

  @override
  _EnteringInformationState createState() => _EnteringInformationState();
}

class _EnteringInformationState extends State<EnteringInformation> {

  final ageController = TextEditingController();
  final trtbpsController = TextEditingController();
  final cholController = TextEditingController();
  final thalachhController = TextEditingController();
  final oldpeakController = TextEditingController();
  final fbsController = TextEditingController();

  String sex = 'Male';
  String exng = 'No';
  int caa = 0;
  String cp = 'None';
  int restecg = 0;
  String slp = 'None';
  String thall = 'None';

  @override
  Widget build(BuildContext enteringInformation) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 139, 251),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: 
          Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Welcome to diagnosis section",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Fill in information to start diagnosing:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                )
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 16, 
                  right: 24, 
                  bottom: 16, 
                  left: 24
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textFieldInput(label: 'Resting Blood Pressure', controller: trtbpsController),
                    textFieldInput(label: 'Cholesterol', controller: cholController),
                    textFieldInput(label: 'Old Peak', controller: oldpeakController),
                    textFieldInput(label: 'Fasting Blood Sugar', controller: fbsController),
                    const Text(
                      'Exercise induced angina',
                      style: TextStyle(fontSize: 16),
                    ),
                    radioInput(
                      label: "No",
                      value: "No",
                      groupValue: exng,
                      onChanged: (newValue) {
                        setState(() {
                          exng = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Yes",
                      value: "Yes",
                      groupValue: exng,
                      onChanged: (newValue) {
                        setState(() {
                          exng = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Number of major vessels',
                      style: TextStyle(fontSize: 16),
                    ),
                    radioInput(
                      label: "0",
                      value: 0,
                      groupValue: caa,
                      onChanged: (newValue) {
                        setState(() {
                          caa = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "1",
                      value: 1,
                      groupValue: caa,
                      onChanged: (newValue) {
                        setState(() {
                          caa = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "2",
                      value: 2,
                      groupValue: caa,
                      onChanged: (newValue) {
                        setState(() {
                          caa = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "3",
                      value: 3,
                      groupValue: caa,
                      onChanged: (newValue) {
                        setState(() {
                          caa = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Chest pain type',
                      style: TextStyle(fontSize: 16),
                    ),
                    radioInput(
                      label: "None",
                      value: "None",
                      groupValue: cp,
                      onChanged: (newValue) {
                        setState(() {
                          cp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Typical angina",
                      value: "Typical angina",
                      groupValue: cp,
                      onChanged: (newValue) {
                        setState(() {
                          cp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Atypical angina",
                      value: "Atypical angina",
                      groupValue: cp,
                      onChanged: (newValue) {
                        setState(() {
                          cp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Non-anginal pain",
                      value: "Non-anginal pain",
                      groupValue: cp,
                      onChanged: (newValue) {
                        setState(() {
                          cp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Asymptomatic",
                      value: "Asymptomatic",
                      groupValue: cp,
                      onChanged: (newValue) {
                        setState(() {
                          cp = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Slope',
                      style: TextStyle(fontSize: 16),
                    ),
                    radioInput(
                      label: "None",
                      value: "None",
                      groupValue: slp,
                      onChanged: (newValue) {
                        setState(() {
                          slp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Upsloping",
                      value: "Upsloping",
                      groupValue: slp,
                      onChanged: (newValue) {
                        setState(() {
                          slp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Flat",
                      value: "Flat",
                      groupValue: slp,
                      onChanged: (newValue) {
                        setState(() {
                          slp = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Asymptomatic",
                      value: "Asymptomatic",
                      groupValue: slp,
                      onChanged: (newValue) {
                        setState(() {
                          slp = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Thalium Stress Test Result',
                      style: TextStyle(fontSize: 16),
                    ),
                    radioInput(
                      label: "None",
                      value: "None",
                      groupValue: thall,
                      onChanged: (newValue) {
                        setState(() {
                          thall = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Normal",
                      value: "Normal",
                      groupValue: thall,
                      onChanged: (newValue) {
                        setState(() {
                          thall = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Fixed defect",
                      value: "Fixed defect",
                      groupValue: thall,
                      onChanged: (newValue) {
                        setState(() {
                          thall = newValue;
                        });
                      },
                    ),
                    radioInput(
                      label: "Reversible defect",
                      value: "Reversible defect",
                      groupValue: thall,
                      onChanged: (newValue) {
                        setState(() {
                          thall = newValue;
                        });
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 20, 139, 251)),
                      ),
                      onPressed: () {
                        try {
                          Map<String, dynamic> inputData = {
                            'trtbps': int.tryParse(trtbpsController.text) ?? 0,
                            'chol': int.tryParse(cholController.text) ?? 0,
                            'oldpeak': double.tryParse(oldpeakController.text) ?? 0.0,
                            'fbs': int.tryParse(fbsController.text) ?? 0,
                            'exng': exng,
                            'caa': caa,
                            'cp': cp,
                            'slp': slp,
                            'thall': thall,
                          };
                          widget.onSubmit(inputData);
                        } catch (e) {
                          print("Error parsing inputs: $e");
                        }
                      },
                      child: const Text(
                        'Predict',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ]
                )
              )
            ],
          ),
      )
    );
  }
}
