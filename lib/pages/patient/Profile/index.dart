import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});
  
  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {

    // final patient = Provider.of<PatientProvider>(context).patient;
    // ListTile(
    //   title: Text('Name: ${patient.name}'),
    //   subtitle: Text(
    //     'Gender: ${patient.gender}\nDOB: ${patient.dob}\nAge: ${patient.age}'),
    // ),

    return Scaffold(
      appBar: AppBar(title: const Text('Personal Information')),
      body: 
        // patient == null
        // ? const Center(child: CircularProgressIndicator()) : 
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: const Color.fromARGB(255, 20, 139, 251),
              )
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.white,
                child: 
                    _buildText(),
                  
                )
              )
            
          ],
        ),
    );
  }

  Widget _buildText() {
    return 
    // FractionallySizedBox(
    //   widthFactor: 0.8,
    //   heightFactor: 0.07,
    //   child: 
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10)
        ),
      // )
    );
  }
}