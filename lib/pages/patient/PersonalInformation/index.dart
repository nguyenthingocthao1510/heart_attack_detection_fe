import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heart_attack_detection_fe/models/patient.d.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/patientApi.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});
  
  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  Patient? patient;

  Future<void> fetchData() async {
    final accountId = int.parse(
      Provider.of<AccountProvider>(context, listen: false).accountId!,
    );
    try {
      final patientData = await PatientAPI.getPatientByAccountId(accountId);
      setState(() {
        patient = patientData;
      });
    } catch (error) {
      print('Error fetching patient data: $error');
    }
  }

  @override 
  void initState() { 
    super.initState(); 
    fetchData(); 
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Information')),
      body: patient == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ListTile(
                  title: Text('Name: ${patient!.name}'),
                  subtitle: Text('Gender: ${patient!.gender}\nDOB: ${patient!.dob}'),
                ),
              ],
            ),
    );
  }

  
}