import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/prescription.d.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (!mounted) return;
    await getAllPrescription();
  }

  Future<void> getAllPrescription() async {
    String accountId =
        Provider.of<AccountProvider>(context, listen: false).accountId!;
    final response =
        await PrescriptionAPI.getAllPrescription(int.parse(accountId));
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
        title: Text('Prescriptions'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            if (prescriptionPermissions.contains('List'))
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
                                arguments:
                                    prescriptions[index].prescription_id);
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
          Navigator.pushNamed(context, addPrescription);
          // Navigator.pushNamed(context, addPrescription, arguments: {
          //   'doctor_id': prescriptions[0].doctor_id, // Pass doctor_id here
          //   'doctor_name': prescriptions[0].doctor_name
          // });
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
