import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/healthInsurance.dart';
import 'package:heart_attack_detection_fe/models/prescription.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/healthInsuranceAPI.dart';
import 'package:heart_attack_detection_fe/services/prescription.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientPrescriptionPage extends StatefulWidget {
  const PatientPrescriptionPage({super.key});

  @override
  State<PatientPrescriptionPage> createState() =>
      _PatientPrescriptionPageState();
}

class _PatientPrescriptionPageState extends State<PatientPrescriptionPage> {
  PatientHealthInsurance? patient;
  List<PatientPrescription> patientPrescriptions = [];
  List<DoctorPrescription> doctors = [];
  List<MedicinePrescription> medicines = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getPatientById();
    await getAllPatientPrescription();
    await getAllDoctors();
    await getAllMedicines();
  }

  Future<void> getPatientById() async {
    try {
      final accountId =
          Provider.of<AccountProvider>(context, listen: false).accountId;
      final response =
          await HealthInsuranceAPI.getPatientByAccountId(int.parse(accountId!));
      setState(() {
        patient = response;
      });
    } catch (e) {
      print('Error fetching patient: $e');
    }
  }

  Future<void> getAllPatientPrescription() async {
    final response =
        await PrescriptionAPI.getAllPatientPrescription(patient!.id!);
    setState(() {
      patientPrescriptions = response;
    });
  }

  Future<void> getAllDoctors() async {
    final response = await PrescriptionAPI.getAllDoctorPrescription();
    setState(() {
      doctors = response;
    });
  }

  Future<void> getAllMedicines() async {
    final response = await PrescriptionAPI.getAllMedicinePrescription();
    setState(() {
      medicines = response;
    });
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'No date available';
    return DateFormat('EEE, dd MMM yyyy').format(date);
  }

  String getDoctorName(int doctorId) {
    final doctor = doctors.firstWhere((doctor) => doctor.id == doctorId,
        orElse: () => DoctorPrescription(name: 'Unknown'));
    return doctor.name ?? 'Unknown';
  }

  String getMedicineName(int medicineId) {
    final medicine = medicines.firstWhere(
        (medicine) => medicine.id == medicineId,
        orElse: () => MedicinePrescription(name: 'Unknown'));
    return medicine.name ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Health Insurance'),
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: patientPrescriptions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFFF5F6FA),
              child: ListView.builder(
                itemCount: patientPrescriptions.length,
                itemBuilder: (context, index) {
                  final prescription = patientPrescriptions[index];
                  final doctorName = getDoctorName(prescription.doctor_id!);
                  final medicineName =
                      getMedicineName(prescription.medicine_id!);
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Doctor: $doctorName',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Patient ID: ${prescription.patient_id}',
                              style: TextStyle(fontSize: 16)),
                          Text('Medicine: ${medicineName}',
                              style: TextStyle(fontSize: 16)),
                          Text(
                              'Medicine Amount: ${prescription.medicine_amount}',
                              style: TextStyle(fontSize: 16)),
                          Text('Note: ${prescription.note}',
                              style: TextStyle(fontSize: 16)),
                          Text(
                            'Prescription Date: ${formatDate(prescription.prescription_date)}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Usage Instructions: ${prescription.usage_instructions}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
    );
  }
}
