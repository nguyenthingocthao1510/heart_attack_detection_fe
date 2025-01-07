import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';

class AssignPatientPage extends StatefulWidget {
  final String deviceId;
  const AssignPatientPage({super.key, required this.deviceId});

  @override
  State<AssignPatientPage> createState() => _AssignPatientPageState();
}

class _AssignPatientPageState extends State<AssignPatientPage> {
  late List<Map<String, dynamic>> patients;

  @override
  void initState() {
    super.initState();
    patients = List.generate(
      20,
          (index) => {'name': 'Patient ${index + 1}', 'selected': false},
    );
  }

  void selectPatient(int index) {
    setState(() {
      for (var patient in patients) {
        patient['selected'] = false;
      }
      patients[index]['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Select a patient to assign',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.grey[200],
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(patients.length, (index) {
                    final patient = patients[index];
                    return GestureDetector(
                      onTap: () => selectPatient(index),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: patient['selected']
                              ? Colors.blueAccent
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          patient['name'],
                          style: TextStyle(
                            fontSize: 16,
                            color: patient['selected']
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // final selectedPatient = patients
                //     .firstWhere((patient) => patient['selected'], orElse: () => null);
                // if (selectedPatient != null) {
                //   // Do something with the selected patient
                //   print('Assigned to: ${selectedPatient['name']}');
                // } else {
                //   // No patient selected
                //   print('No patient selected');
                // }
              },
              child: const Text('Assign Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
