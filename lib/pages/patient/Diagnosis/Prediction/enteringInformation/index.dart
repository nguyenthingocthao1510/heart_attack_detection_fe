import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/enteringInformation/textFieldInput.dart';
import 'package:heart_attack_detection_fe/pages/patient/Diagnosis/Prediction/enteringInformation/radioInput.dart';

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
  String caa = '0';
  String cp = 'None';
  String restecg = '0';
  String slp = 'None';
  String thall = 'None';

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 50, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ).animate(delay: const Duration(milliseconds: 1500))
                .fade(
                  duration: const Duration(milliseconds: 1500),
                  begin: 0.1,
                  end: 1
                )
                .slide(
                  duration: const Duration(milliseconds: 1100),
                  begin: const Offset(1, 0)
                ),
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Fill in information to start diagnosing:",
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: const Duration(milliseconds: 1500))
                  .fade(
                    duration: const Duration(milliseconds: 1500),
                    begin: 0.1,
                    end: 1
                  )
                  .slide(
                    duration: const Duration(milliseconds: 1100),
                    begin: const Offset(1, 0)
                  ),
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
                    const Text(
                      'Age',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: textFieldInput(ageController)
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Resting Blood Pressure',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: textFieldInput(trtbpsController)
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Cholesterol',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: textFieldInput(cholController)
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Heart Rate',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: textFieldInput(thalachhController)
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Old Peak',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: textFieldInput(oldpeakController)
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Fasting blood sugar',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: textFieldInput(fbsController)
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Gender',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: "Male", groupValue: sex),
                    RadioInput(value: "Female", groupValue: sex),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Exercise induced angina',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: "No", groupValue: exng),
                    RadioInput(value: "Yes", groupValue: exng),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Number of major vessels',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: 0, groupValue: caa),
                    RadioInput(value: 1, groupValue: caa),
                    RadioInput(value: 2, groupValue: caa),
                    RadioInput(value: 3, groupValue: caa),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Chest pain type',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: "None", groupValue: cp),
                    RadioInput(value: "Typical angina", groupValue: cp),
                    RadioInput(value: "Atypical angina", groupValue: cp),
                    RadioInput(value: "Non-anginal pain", groupValue: cp),
                    RadioInput(value: "Asymptomatic", groupValue: cp),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Resting Electrocardiographic result',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: 0, groupValue: restecg),
                    RadioInput(value: 1, groupValue: restecg),
                    RadioInput(value: 2, groupValue: restecg),
                    RadioInput(value: 3, groupValue: restecg),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Slope',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: "None", groupValue: slp),
                    RadioInput(value: "Upsloping", groupValue: slp),
                    RadioInput(value: "Flat", groupValue: slp),
                    RadioInput(value: "Downsloping", groupValue: slp),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Thalium Stress Test Result',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioInput(value: "None", groupValue: slp),
                    RadioInput(value: "Normal", groupValue: slp),
                    RadioInput(value: "Fixed defect", groupValue: slp),
                    RadioInput(value: "Reversible defect", groupValue: slp),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 20, 139, 251)),
                        
                      ),
                      onPressed: () {
                        try {
                          Map<String, dynamic> inputData = {
                            'age': int.tryParse(ageController.text) ?? 0,
                            'trtbps': int.tryParse(trtbpsController.text) ?? 0,
                            'chol': int.tryParse(cholController.text) ?? 0,
                            'thalachh': int.tryParse(thalachhController.text) ?? 0,
                            'oldpeak': double.tryParse(oldpeakController.text) ?? 0.0,
                            'fbs': int.tryParse(fbsController.text) ?? 0,
                            'sex': sex,
                            'exng': exng,
                            'caa': int.tryParse(caa) ?? 0,
                            'cp': cp,
                            'restecg': int.tryParse(restecg) ?? 0,
                            'slp': slp,
                            'thall': thall,
                          };
                          widget.onSubmit(inputData);
                        } catch (e) {
                          print("Error parsing inputs: $e");
                        }
                      },
                      child: const Text('Predict'),
                    ),
                  ]
                )
              ).animate()
              .slide(
                duration: const Duration(seconds: 3),
                begin: const Offset(4, 0),
              ),
            ],
          ),
      )
    );
  }
}
