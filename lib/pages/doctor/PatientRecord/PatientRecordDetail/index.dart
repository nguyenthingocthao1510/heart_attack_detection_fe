import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/PatientRecord/patientRecord.d.dart';
import 'package:heart_attack_detection_fe/pages/doctor/PatientRecord/PatientHistoryRecord/index.dart';
import 'package:heart_attack_detection_fe/pages/doctor/PatientRecord/PatientModal/index.dart';
import 'package:heart_attack_detection_fe/services/doctorPatientRecordAPI.dart';
import 'package:intl/intl.dart';

class PatientRecordDetail extends StatefulWidget {
  final int? patientRecordId;
  final historyDoctorPatientRecord? patientRecord;

  const PatientRecordDetail(
      {super.key, this.patientRecordId, this.patientRecord});

  @override
  State<PatientRecordDetail> createState() => _PatientRecordDetailState();
}

class _PatientRecordDetailState extends State<PatientRecordDetail> {
  historyDoctorPatientRecord? patientRecords;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await getPatientRecordById();
      setState(() {
        patientRecords = response;
      });
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<historyDoctorPatientRecord> getPatientRecordById() async {
    try {
      final response = await DoctorPatientRecordAPI.getPatientRecordById(
          widget.patientRecordId!);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Patient record detail'),
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(16.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Age:', '${patientRecords?.age}'),
                  _buildRow('Gender:', '${patientRecords?.sex}'),
                  _buildRow(
                      'Number of major vessels:', '${patientRecords?.caa}'),
                  _buildRow('Cholesterol:', '${patientRecords?.chol}'),
                  _buildRow('Chest pain type:', '${patientRecords?.cp}'),
                  _buildRow(
                      'Exercise induced angina:', '${patientRecords?.exng}'),
                  _buildRow('Fasting Blood Sugar:', '${patientRecords?.fbs}'),
                  _buildRow('Old Peak:', '${patientRecords?.oldpeak}'),
                  _buildRow('Resting Electrocardiograph:',
                      '${patientRecords?.restecg}'),
                  _buildRow('Slope:', '${patientRecords?.slp}'),
                  _buildRow('Heart Rate:', '${patientRecords?.thalachh}'),
                  _buildRow('Asymptomatic:', '${patientRecords?.thall}'),
                  _buildRow(
                      'Resting Blood Pressure:', '${patientRecords?.trtbps}'),
                  _buildRow('Date created:',
                      '${_formatDate(patientRecords?.create_date.toString())}'),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blueAccent),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientRecordHistory(
                                        patientRecordId:
                                            patientRecords?.patient_id,
                                      )));
                        },
                        child: const Text(
                          'View history',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blueAccent),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientRecordModal(
                                        patientRecordId: widget.patientRecordId,
                                        patientRecord: patientRecords,
                                      )));
                        },
                        child: const Text(
                          'Update records',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PatientRecordModal(doctorId: patientRecords?.doctor_id)));
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
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

  Widget _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 230,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
