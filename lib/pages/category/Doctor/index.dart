import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/doctor.d.dart';
import 'package:heart_attack_detection_fe/pages/category/Doctor/DoctorModal/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/providers/permissionProvider.dart';
import 'package:heart_attack_detection_fe/services/doctorApi.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorPage extends StatefulWidget {
  final Doctor? doctor;

  const DoctorPage({this.doctor, super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  Doctor? doctor;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchDoctorData = await getDoctorById();
      setState(() {
        doctor = fetchDoctorData;
      });
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Doctor> getDoctorById() async {
    try {
      final accountId =
          Provider.of<AccountProvider>(context, listen: false).accountId;
      final response = await DoctorAPI.getDoctorById(int.parse(accountId!));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(context);
    final permissions = permissionProvider.permissions;
    final prescriptionPermissions = permissions["Prescription"] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('Doctor Information'),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF5F6FA),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (prescriptionPermissions.contains('View')) ...[
                    _buildInfoRow(
                      icon: Icons.person,
                      label: 'Name',
                      value: doctor?.name ?? 'N/A',
                    ),
                    _buildInfoRow(
                      icon: Icons.access_time,
                      label: 'Age',
                      value: doctor?.age?.toString() ?? 'N/A',
                    ),
                    _buildInfoRow(
                      icon: doctor?.gender == 0 ? Icons.man : Icons.woman,
                      label: 'Gender',
                      value: doctor?.gender == 0 ? 'Male' : 'Female',
                    ),
                    _buildInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: doctor?.email ?? 'N/A',
                    ),
                    _buildInfoRow(
                      icon: Icons.home,
                      label: 'Address',
                      value: doctor?.address ?? 'N/A',
                    ),
                    _buildInfoRow(
                      icon: Icons.calendar_month,
                      label: 'Date of Birth',
                      value: doctor?.dob != null
                          ? DateFormat('dd/MM/yyyy').format(
                              DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                                  .parse(doctor!.dob!),
                            )
                          : 'Invalid date',
                    ),
                    _buildInfoRow(
                      icon: Icons.assignment_ind,
                      label: 'Specialization',
                      value: doctor?.specialization ?? 'N/A',
                    ),
                  ],
                  if (prescriptionPermissions.contains('Edit'))
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 0.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoctorModal(doctor: doctor),
                              ),
                            );
                          },
                          child: const Text(
                            'Update Information',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
