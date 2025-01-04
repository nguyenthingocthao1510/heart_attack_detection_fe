import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/DiagnosisForm/Component/textFieldInput.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/DiagnosisForm/Component/radioInput.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';
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
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(
                context, [
                _buildTextContainer(0.08, 0.8, "Welcome, ${patient.name}!", CustomTextStyle.textStyle1(28, Colors.black), TextAlign.start),
                _buildTextContainer(0.1,
                    0.8,
                    "Turn on monthly auto-diagnosis or fill information below to start diagnosing",
                    CustomTextStyle.textStyle2(16, Colors.black),
                    TextAlign.start),
                CustomDivider.divider2(context, 0.02),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTextContainer(0.07, 0.5, "Auto-prediction", CustomTextStyle.textStyle2(20, Colors.black), TextAlign.start),
                      FlutterSwitch(
                        activeColor: const Color.fromARGB(255, 20, 139, 251),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.04,
                        valueFontSize: 16,
                        toggleSize: MediaQuery.of(context).size.height * 0.03,
                        value: status,
                        borderRadius: 30.0,
                        showOnOff: true,
                        onToggle: (val) async {
                          var newStatus = val ? 'Yes' : 'No';
                          await patientAPI.toggleAutoPrediction(patient.id, newStatus);
                          setState(() => patient.need_prediction = newStatus);
                        },
                      ),
                    ],
                  ),
                ),
              ]
            ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [textFieldInput(context: context, label: 'Resting Blood Pressure', controller: trtbpsController)]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [textFieldInput(context: context, label: 'Cholesterol', controller: cholController)]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [textFieldInput(context: context, label: 'Old Peak', controller: oldpeakController)]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [textFieldInput(context: context, label: 'Fasting Blood Sugar', controller: fbsController)]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [
                _buildRadioItem(
                  'Exercise induced angina',
                  ['No', 'Yes'],
                  exng,
                  (newValue) {setState(() => exng = newValue);}
                )
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [
                _buildRadioItem(
                  'Number of major vessels',
                  [0, 1, 2, 3],
                  caa,
                  (newValue) {setState(() => caa = newValue);}
                )
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [
                _buildRadioItem(
                  'Chest pain type',
                  ['None', 'Typical angina', 'Atypical angina', 'Non-anginal pain'],
                  cp,
                  (newValue) {setState(() => cp = newValue);}
                )
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [
                _buildRadioItem(
                  'Slope',
                  ['None', 'Upsloping', 'Flat', 'Asymptomatic'],
                  slp,
                  (newValue) {setState(() => slp = newValue);}
                )
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildCard(context, [
                _buildRadioItem(
                  'Thallium Stress Test Result',
                  ['None', 'Normal', 'Fixed defect', 'Reversible defect'],
                  thall,
                  (newValue) {setState(() => slp = newValue);}
                )
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  Widget _buildCard(BuildContext context, List<Widget> children) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      color: Colors.white,
      elevation: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildTextContainer(height, width, text, style, TextAlign? textAlign) {
    return Container(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        textAlign: textAlign,
        style: style,
      ),
    );
  }

  Widget _buildRadioItem<T>(String title, List<T> options, T groupValue, ValueChanged<T> onChanged) {
    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
    ),
    padding: const EdgeInsets.all(16),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomTextStyle.textStyle1(16, Colors.black)),
        CustomDivider.divider2(context, 0.05),
        radioInput(options: options, groupValue: groupValue, onChanged: onChanged),
      ],
      )
    );
  }
}
