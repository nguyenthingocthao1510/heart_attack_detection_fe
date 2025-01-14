import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/components/SearchButton/index.dart';
import 'package:heart_attack_detection_fe/models/PatientRecord/patientRecord.d.dart';
import 'package:heart_attack_detection_fe/pages/doctor/PatientRecord/PatientRecordDetail/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/doctorPatientRecordAPI.dart';
import 'package:provider/provider.dart';

class DoctorPatientRecordPage extends StatefulWidget {
  const DoctorPatientRecordPage({super.key});

  @override
  State<DoctorPatientRecordPage> createState() =>
      _DoctorPatientRecordPageState();
}

class _DoctorPatientRecordPageState extends State<DoctorPatientRecordPage> {
  List<doctorPatientRecord> patientRecords = [];
  String? name = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllPatientRecord();
  }

  Future<void> getAllPatientRecord() async {
    String? accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId;
    final response = await DoctorPatientRecordAPI.filterPatientRecord(
        int.parse(accountId!), name);
    setState(() {
      patientRecords = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Patient record'),
      ),
      body: Container(
        color: Color(0xFFF5F6FA),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SearchFunction(onSearch: (query) {
              setState(() {
                name = query;
              });
              fetchData();
            }),
            Expanded(
                child: ListView.builder(
              itemCount: patientRecords.length,
              itemBuilder: (context, index) {
                final patientRecord = patientRecords[index];
                final name = patientRecord.name;
                final gender = patientRecord.gender;
                final id = patientRecord.id;
                final patientRecordId = patientRecord.patient_record_id;

                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(name!),
                    subtitle: Text('ID: ${id} - ${gender}'),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientRecordDetail(
                                        patientRecordId: patientRecordId!,
                                      )));
                        },
                        icon: const Icon(Icons.chevron_right)),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
