import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/DiagnosisForm/Component/textFieldInput.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/DiagnosisForm/Component/radioInput.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/services/patientApi.dart';


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
  PatientAPI patientAPI = PatientAPI();

  @override
  Widget build(BuildContext DiagnosisForm) {
    var patient = Provider.of<PatientProvider>(context).patient;
    bool status = (patient!.need_prediction == 'Yes') ? true : false;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 139, 251),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: 
          Column(
            children: [
              _buildTextContainer(0.1, 1.0, "Welcome, ${patient.name}", CustomTextStyle.textStyle1(36, Colors.white), TextAlign.start),
              Row(
                children: [
                  _buildTextContainer(0.1, 0.7, "Tap for auto-prediction", CustomTextStyle.textStyle2(20, Colors.white), TextAlign.start),
                  FlutterSwitch(
                    activeColor: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.05,
                    valueFontSize: 16,
                    toggleSize: MediaQuery.of(context).size.height * 0.04,
                    value: status,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (val) async {
                      var newStatus = val ? 'Yes' : 'No';
                      await patientAPI.toggleAutoPrediction(patient.id, newStatus);
                      setState(() {
                        patient.need_prediction = newStatus;
                      });
                    },
                  ),
                ],
              ),
              _buildTextContainer(0.1, 1.0, "Or fill information", CustomTextStyle.textStyle2(20, Colors.white), TextAlign.center),
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

  Widget _buildTextContainer(height, width, text, style, TextAlign? textAlign) {
    return Container(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: textAlign,
        style: style,
      ),
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
