import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/patientRecord.d.dart';
import 'package:heart_attack_detection_fe/pages/doctor/PatientRecord/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/doctorPatientRecordAPI.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientRecordHistory extends StatefulWidget {
  final int? patientRecordId;

  const PatientRecordHistory({super.key, this.patientRecordId});

  @override
  State<PatientRecordHistory> createState() => _PatientRecordHistoryState();
}

class _PatientRecordHistoryState extends State<PatientRecordHistory> {
  List<historyDoctorPatientRecord> patientRecords = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllPatientRecord();
  }

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      DateTime parsedDate =
          DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz').parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid date format';
    }
  }

  Future<void> getAllPatientRecord() async {
    String? accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId;
    int? patientId = widget.patientRecordId;
    print('patientId: $patientId');
    final response = await DoctorPatientRecordAPI.getHistoryPatientRecord(
        int.parse(accountId!), patientId!);
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
        title: const Text('Patient Record'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF5F6FA),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: patientRecords.length,
                itemBuilder: (context, index) {
                  final patientRecord = patientRecords[index];

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Use Row for separating label and value
                          Row(
                            children: [
                              Text(
                                "Patient ID: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.patient_id ?? 'Unknown'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Age: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.age ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Gender: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.sex ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Cholesterol: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.chol ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Chest Pain Type: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.cp ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Exercise Induced Angina: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.exng ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Fasting Blood Sugar: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.fbs ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Old Peak: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.oldpeak ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Resting ECG: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.restecg ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Systolic BP: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.trtbps ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Thalach: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.thalachh ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Thalassemia: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.thall ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Slope: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.slp ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Number of Major Vessels: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${patientRecord.caa ?? 'N/A'}"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Create date: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${_formatDate(patientRecord.create_date)}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorPatientRecordPage()));
                  },
                  child: Text('Return to patient list',
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.blueAccent)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
