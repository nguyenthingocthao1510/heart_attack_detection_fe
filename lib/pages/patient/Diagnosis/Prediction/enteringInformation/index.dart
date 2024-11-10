import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/icon/index.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EnteringInformation extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  final ageController = TextEditingController();
  final trtbpsController = TextEditingController();
  final cholController = TextEditingController();
  final thalachhController = TextEditingController();
  final oldpeakController = TextEditingController();

  String sex = 'Male';
  String exng = 'No';
  String caa = '0';
  String cp = '0';
  String fbs = 'No';
  String restecg = '0';
  String slp = '0';
  String thall = '0';

  final exngController = TextEditingController();
  final caaController = TextEditingController();
  final cpController = TextEditingController();
  final fbsController = TextEditingController();
  final restecgController = TextEditingController();
  final slpController = TextEditingController();
  final thallController = TextEditingController();

  EnteringInformation({required this.onSubmit});

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
              ).animate()
                .slide(
                  duration: const Duration(seconds: 1),
                  begin: const Offset(1, 0)
                ),
              Container(
                height: 300,
                width: 300,
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 225, 225, 225),
                  borderRadius: BorderRadius.circular(300)
                ),
                child: Image.asset(
                  heartImage,
                  fit: BoxFit.contain
                ).animate(
                    onComplete: (controller) => controller.repeat()
                  )
                  .scale(
                    duration: const Duration(milliseconds: 500),
                    begin: const Offset(1.0, 1.0),
                    end: const Offset(1.2, 1.2),
                    curve: Curves.easeInOut,
                  )
                  .then(delay: const Duration(milliseconds: 100))
                  .scale(
                    duration: const Duration(milliseconds: 500),
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(1.0, 1.0),
                    curve: Curves.easeInOut,
                  ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Please answer questions below to start diagnosing...",
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ).animate()
                  .slide(
                    delay: const Duration(seconds: 1),
                    duration: const Duration(seconds: 1),
                    begin: const Offset(3, 0)
                  )
                ,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: ageController,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: trtbpsController,
                      decoration: InputDecoration(labelText: 'Resting Blood Pressure'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: cholController,
                      decoration: InputDecoration(labelText: 'Cholesterol (chol)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: thalachhController,
                      decoration: InputDecoration(labelText: 'Max Heart Rate (thalachh)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: oldpeakController,
                      decoration: InputDecoration(labelText: 'Oldpeak'),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButtonFormField<String>(
                      value: sex,
                      items: ['Male', 'Female','None'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        sex = newValue!;
                      },
                      decoration: InputDecoration(labelText: 'Sex'),
                    ),
                    TextField(
                      controller: exngController,
                      decoration: InputDecoration(labelText: 'Exercise Induced Angina (exng)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: caaController,
                      decoration: InputDecoration(labelText: 'Caa'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: cpController,
                      decoration: InputDecoration(labelText: 'Chest Pain Type (cp)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: fbsController,
                      decoration: InputDecoration(labelText: 'Fasting Blood Sugar (fbs)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: restecgController,
                      decoration: InputDecoration(labelText: 'Rest ECG (restecg)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: slpController,
                      decoration: InputDecoration(labelText: 'Slope (slp)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: thallController,
                      decoration: InputDecoration(labelText: 'Thall'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),
                  ],
                )
              ).animate()
              .slide(
                duration: const Duration(seconds: 3),
                begin: const Offset(4, 0),
              )
              ,
              ElevatedButton(
                onPressed: () {
                  try {
                    Map<String, dynamic> inputData = {
                      'age': int.tryParse(ageController.text) ?? 0,
                      'trtbps': int.tryParse(trtbpsController.text) ?? 0,
                      'chol': int.tryParse(cholController.text) ?? 0,
                      'thalachh': int.tryParse(thalachhController.text) ?? 0,
                      'oldpeak': double.tryParse(oldpeakController.text) ?? 0.0,
                      'sex': int.tryParse(sex) ?? 0,
                      'exng': int.tryParse(exngController.text) ?? 0,
                      'caa': int.tryParse(caaController.text) ?? 0,
                      'cp': int.tryParse(cpController.text) ?? 0,
                      'fbs': int.tryParse(fbsController.text) ?? 0,
                      'restecg': int.tryParse(restecgController.text) ?? 0,
                      'slp': int.tryParse(slpController.text) ?? 0,
                      'thall': int.tryParse(thallController.text) ?? 0,
                    };
                    onSubmit(inputData);
                  } catch (e) {
                    print("Error parsing inputs: $e");
                  }
                },
                child: const Text('Predict'),
              ),
            ],
          ),
      )
    );
  }
}
