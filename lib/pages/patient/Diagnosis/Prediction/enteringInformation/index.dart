import 'package:flutter/material.dart';

class EnteringInformation extends StatelessWidget {
  final Function(Map<String, dynamic>) onSubmit;

  final ageController = TextEditingController();
  final trtbpsController = TextEditingController();
  final cholController = TextEditingController();
  final thalachhController = TextEditingController();
  final oldpeakController = TextEditingController();
  final sexController = TextEditingController();
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
    return Column(
      children: [
        TextField(controller: ageController, decoration: InputDecoration(labelText: 'Age')),
        TextField(controller: trtbpsController, decoration: InputDecoration(labelText: 'Resting Blood Pressure')),
        TextField(controller: cholController, decoration: InputDecoration(labelText: 'Cholesterol (chol)'), keyboardType: TextInputType.number),
        TextField(controller: thalachhController, decoration: InputDecoration(labelText: 'Max Heart Rate (thalachh)'), keyboardType: TextInputType.number),
        TextField(controller: oldpeakController, decoration: InputDecoration(labelText: 'Oldpeak'), keyboardType: TextInputType.number),
        TextField(controller: sexController, decoration: InputDecoration(labelText: 'Sex (0 or 1)'), keyboardType: TextInputType.number),
        TextField(controller: exngController, decoration: InputDecoration(labelText: 'Exercise Induced Angina (exng)'), keyboardType: TextInputType.number),
        TextField(controller: caaController, decoration: InputDecoration(labelText: 'Caa'), keyboardType: TextInputType.number),
        TextField(controller: cpController, decoration: InputDecoration(labelText: 'Chest Pain Type (cp)'), keyboardType: TextInputType.number),
        TextField(controller: fbsController, decoration: InputDecoration(labelText: 'Fasting Blood Sugar (fbs)'), keyboardType: TextInputType.number),
        TextField(controller: restecgController, decoration: InputDecoration(labelText: 'Rest ECG (restecg)'), keyboardType: TextInputType.number),
        TextField(controller: slpController, decoration: InputDecoration(labelText: 'Slope (slp)'), keyboardType: TextInputType.number),
        TextField(controller: thallController, decoration: InputDecoration(labelText: 'Thall'), keyboardType: TextInputType.number),
        ElevatedButton(
          onPressed: () {
            Map<String, dynamic> inputData = {
              'age': int.parse(ageController.text),
              'trtbps': int.parse(trtbpsController.text),
              'chol': int.parse(cholController.text),
              'thalachh': int.parse(thalachhController.text),
              'oldpeak': double.parse(oldpeakController.text),
              'sex': sexController.text, 
              'exng': exngController.text,
              'caa': int.parse(caaController.text),
              'cp': cpController.text,
              'fbs': int.parse(fbsController.text),
              'restecg': int.parse(restecgController.text),
              'slp': slpController.text,
              'thall': thallController.text,    
            };
            onSubmit(inputData);
          },
          child: const Text('Predict'),
        ),
      ],
    );
  }
}
