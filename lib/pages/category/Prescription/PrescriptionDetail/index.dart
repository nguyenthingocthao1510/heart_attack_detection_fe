import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/medicine.d.dart';
import 'package:heart_attack_detection_fe/models/prescription.d.dart';
import 'package:heart_attack_detection_fe/pages/category/Prescription/PrescriptionModal/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/services/medicine.dart';
import 'package:heart_attack_detection_fe/services/prescription.dart';
import 'package:provider/provider.dart';

class PrescriptionDetail extends StatefulWidget {
  final int prescriptionId;

  const PrescriptionDetail({super.key, required this.prescriptionId});

  @override
  State<PrescriptionDetail> createState() => _PrescriptionDetailState();
}

class _PrescriptionDetailState extends State<PrescriptionDetail> {
  late Future<Prescription> prescription;
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    prescription = fetchPrescriptionData();
    await prescription.then((_) {
      fetchMedicines();
    });
  }

  Future<Prescription> fetchPrescriptionData() async {
    try {
      int accountId = int.parse(
          Provider.of<AccountProvider>(context, listen: false).accountId!);
      final prescriptionData = await PrescriptionAPI.getPrescriptionId(
          accountId, widget.prescriptionId);
      return prescriptionData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchMedicines() async {
    try {
      final medicineList = await MedicineAPI.getAllMedicine();
      setState(() {
        medicines = medicineList;
      });
    } catch (e) {
      print('Error fetching medicines: $e');
    }
  }

  String getMedicineName(int medicineId) {
    final medicine = medicines.firstWhere(
      (med) => med.id?.toInt() == medicineId.toInt(),
      orElse: () => Medicine(id: -1, name: 'Unknown'),
    );
    return medicine.name ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);
    final permissions = permissionProvider.permissions;
    final prescriptionPermissions = permissions["Prescription"] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Prescription Detail'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<Prescription>(
        future: prescription,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final prescriptionData = snapshot.data!;
          final prescriptionDetails = prescriptionData.details ?? [];

          return Card(
            margin: const EdgeInsets.all(16.0),
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prescription Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      title: 'Patient:',
                      value: prescriptionData.patient_name ?? 'N/A',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      title: 'Doctor:',
                      value: prescriptionData.doctor_name ?? 'N/A',
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      title: 'Date:',
                      value: prescriptionData.prescription_date ?? 'N/A',
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Medicines Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    prescriptionDetails.isEmpty
                        ? const Text(
                            'No medicines listed.',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: prescriptionDetails.length,
                              itemBuilder: (context, index) {
                                final medicine = prescriptionDetails[index];
                                print('medicineName: ${medicine.medicine_id}');
                                final medicineName = getMedicineName(
                                    medicine.medicine_id ??
                                        -1); // Lấy tên thuốc
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  title: Text(
                                    medicineName,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    'Usage: ${medicine.usage_instructions ?? 'N/A'}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  trailing: Text(
                                    '${medicine.medicine_amount ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(height: 20),
                    Text(
                      'Note',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prescriptionData.note ?? 'N/A',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (prescriptionPermissions.contains('Edit'))
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final updatedDetails = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrescriptionModal(
                                  prescriptionData: prescriptionData,
                                ),
                              ),
                            );
                            if (updatedDetails != null) {
                              setState(() {
                                prescription = fetchPrescriptionData();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Update prescription',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
