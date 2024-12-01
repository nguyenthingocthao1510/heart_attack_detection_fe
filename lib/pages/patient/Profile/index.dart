import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heart_attack_detection_fe/models/patient.d.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';
import 'package:heart_attack_detection_fe/services/patientApi.dart';



class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});
  
  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {

      final patient = Provider.of<PatientProvider>(context).patient;

    return Scaffold(
      appBar: AppBar(title: const Text('Personal Information')),
      body: patient == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              ListTile(
                title: Text('Name: ${patient.name}'),
                subtitle: Text('Gender: ${patient.gender}\nDOB: ${patient.dob}\nAge: ${patient!.age}'),
              ),
            ],
          ),
    );
  }
}