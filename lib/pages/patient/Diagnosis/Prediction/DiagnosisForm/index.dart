import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/DiagnosisForm/InputFormComponent/textFieldInput.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/DiagnosisForm/InputFormComponent/radioInput.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';

// ignore: must_be_immutable
class DiagnosisForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const DiagnosisForm({super.key, required this.onSubmit});

  @override
  _DiagnosisFormState createState() => _DiagnosisFormState();
}

class _DiagnosisFormState extends State<DiagnosisForm> {

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
  String slp = 'None';
  String thall = 'None';

  ValueChanged changeRadioValue(dynamic groupValue) {
    return (newValue) {
      setState(() {
        groupValue = newValue;
      });
    };
  }

  @override
  Widget build(BuildContext DiagnosisForm) {
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
                child: Text(
                  "Welcome to diagnosis section",
                  style: CustomTextStyle.textStyle1(50, Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Fill in information to start diagnosing:",
                  style: CustomTextStyle.textStyle1(20, Colors.white),
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
                    _buildRadioForm(),
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
  Widget _buildRadioItem<T>(String title, List<T> options, T groupValue, ValueChanged<T> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomTextStyle.textStyle1(12, Colors.black)),
        radioInput(options: options, groupValue: groupValue, onChanged: onChanged),
        const Padding(padding: EdgeInsets.all(12)),
      ],
    );
  }
  Widget _buildRadioForm() {
    return Column(
      children: [
        _buildRadioItem(
          'Exercise induced angina',
          ['No', 'Yes'],
          exng,
          (newValue) {
            setState(() {
              exng = newValue;
            });
          }
        ),
        _buildRadioItem(
          'Number of major vessels',
          [0, 1, 2, 3],
          caa,
          (newValue) {
            setState(() {
              caa = newValue;
            });
          }
        ),
        _buildRadioItem(
          'Chest pain type',
          ['None', 'Typical angina', 'Atypical angina', 'Non-anginal pain'],
          cp,
          (newValue) {
            setState(() {
              cp = newValue;
            });
          }
        ),
        _buildRadioItem(
          'Slope',
          ['None', 'Upsloping', 'Flat', 'Asymptomatic'],
          slp,
          (newValue) {
            setState(() {
              slp = newValue;
            });
          }
        ),
        _buildRadioItem(
          'Thallium Stress Test Result',
          ['None', 'Normal', 'Fixed defect', 'Reversible defect'],
          thall,
          (newValue) {
            setState(() {
              slp = newValue;
            });
          }
        ),
      ],
    );
  }
}
