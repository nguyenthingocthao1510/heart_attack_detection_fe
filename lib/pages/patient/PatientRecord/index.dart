import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/PatientRecord/patientRecord.d.dart';
import 'package:heart_attack_detection_fe/pages/patient/PatientRecord/PatientHistoryRecord/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/patientPatientRecordAPI.dart';
import 'package:provider/provider.dart';

class PatientPatientRecordPage extends StatefulWidget {
  const PatientPatientRecordPage({super.key});

  @override
  State<PatientPatientRecordPage> createState() =>
      _PatientPatientRecordPageState();
}

class _PatientPatientRecordPageState extends State<PatientPatientRecordPage> {
  // Change patientRecord to nullable
  patientPatientRecord? patientRecord;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch data from the API
  Future<void> fetchData() async {
    try {
      final response = await getOnePatientRecord();
      setState(() {
        patientRecord = response;
      });
    } catch (e) {
      print("Error fetching patient record: $e");
    }
  }

  // Get the patient record
  Future<patientPatientRecord> getOnePatientRecord() async {
    final accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId;
    final response = await PatientPatientRecordAPI.fetchOnePatientRecord(
        int.parse(accountId!));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Patient Record'),
      ),
      body: patientRecord == null
          // Show a loading spinner if the record is null
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Color(0xFFF5F6FA),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(patientRecord?.name ?? 'No name'),
                      subtitle: Text(
                          'Specialization: ${patientRecord?.specialization} - Age: ${patientRecord?.age}'),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PatientRecordHistoryPage()));
                        },
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
