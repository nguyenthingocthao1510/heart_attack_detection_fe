import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/assets/components/SearchButton/index.dart';
import 'package:heart_attack_detection_fe/models/doctor.d.dart';
import 'package:heart_attack_detection_fe/models/prescription.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/doctorApi.dart';
import 'package:heart_attack_detection_fe/services/prescription.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  List<Prescription> prescriptions = [];
  Doctor? doctor;
  String? patientName = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (!mounted) return;
    await getAllPrescription();
    await getAllDoctor();
  }

  Future<void> getAllDoctor() async {
    final accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId;
    final response = await DoctorAPI.getDoctorById(int.parse(accountId!));
    setState(() {
      doctor = response;
    });
  }

  Future<void> getAllPrescription() async {
    String accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId!;
    final response = await PrescriptionAPI.filterPrescription(
        int.parse(accountId), patientName);
    if (mounted) {
      setState(() {
        prescriptions = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);
    final permissions = permissionProvider.permissions;
    final prescriptionPermissions = permissions["Prescription"] ?? [];

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Prescriptions'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            if (prescriptionPermissions.contains('List'))
              SearchFunction(onSearch: (query) {
                setState(() {
                  patientName = query;
                });
                fetchData();
              }),
            Expanded(
              child: ListView.builder(
                itemCount: prescriptions.length,
                itemBuilder: (context, index) {
                  final prescription = prescriptions[index];
                  final doctorName = prescription.doctor_name;
                  final patientName = prescription.patient_name;

                  DateTime? prescriptionDate;
                  try {
                    prescriptionDate =
                        DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'")
                            .parse(prescription.prescription_date!);
                  } catch (e) {
                    print('Error parsing date: $e');
                  }

                  final formatDate = prescriptionDate != null
                      ? DateFormat.yMMMd().format(prescriptionDate)
                      : 'Invalid Date';

                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(patientName!),
                      subtitle: Text('$doctorName - $formatDate'),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, prescriptionDetail,
                              arguments: prescriptions[index].prescription_id);
                        },
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, addPrescription, arguments: {
            'doctor_id': doctor?.id,
            'doctor_name': doctor?.name
          });
        },
        icon: Icon(Icons.add),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            iconColor: WidgetStatePropertyAll(Colors.white),
            iconSize: WidgetStatePropertyAll(35.0)),
      ),
    );
  }
}
