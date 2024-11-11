import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                      child: TextField(
                        controller: ageController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Color.fromARGB(255, 20, 139, 251),
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                    )
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Resting Blood Pressure',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: TextField(
                        controller: trtbpsController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Color.fromARGB(255, 20, 139, 251),
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                    )
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Cholesterol',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: TextField(
                        controller: cholController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Color.fromARGB(255, 20, 139, 251),
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                    )
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Heart Rate',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: TextField(
                        controller: thalachhController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Color.fromARGB(255, 20, 139, 251),
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                    )
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Old Peak',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 64,
                      child: TextField(
                        controller: oldpeakController,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color:Color.fromARGB(255, 20, 139, 251),
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                    )
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    const Text(
                      'Gender',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: "Male",
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {sex = value!;});
                          },
                        ),
                        const Text('Male'),
                        Radio(
                          value: "Female",
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {sex = value!;});
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: exng,
                      items: ['No','Yes'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        exng = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'Do you have exercise induce angina?'),
                    ),
                    DropdownButtonFormField<String>(
                      value: caa,
                      items: ['0','1','2','3'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        caa = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'How many major vessels?'),
                    ),
                    DropdownButtonFormField<String>(
                      value: cp,
                      items: ['None',
                              'Typical angina',
                              'Atypical angina',
                              'Non-anginal pain',
                              'Asymptomatic']
                              .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        cp = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'What is your chest pain type?'),
                    ),
                    TextField(
                      controller: fbsController,
                      decoration: const InputDecoration(labelText: 'Fasting Blood Sugar (fbs)'),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButtonFormField<String>(
                      value: restecg,
                      items: ['0','1','2','3'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        restecg = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'What is your resting electrocardiographic result?'),
                    ),
                    DropdownButtonFormField<String>(
                      value: slp,
                      items: ['None',
                              'Upsloping',
                              'Flat',
                              'Downsloping']
                              .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        slp = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'Your slope of the peak exercise ST segment?'),
                    ),
                    DropdownButtonFormField<String>(
                      value: thall,
                      items: ['None',
                              'Normal',
                              'Fixed defect',
                              'Reversible defect']
                              .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        thall = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'Your Thalium Stress Test result?'),
                    ),
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
                            'fbs': int.tryParse(fbsController.text) ?? 0,
                            'restecg': int.tryParse(restecg) ?? 0,
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
