import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:heart_attack_detection_fe/providers/patientProvider.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});
  
  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {

    final patient = Provider.of<PatientProvider>(context).patient;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('Patient Information'),
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
                  _buildInfoRow(
                    icon: Icons.person,
                    label: 'Name',
                    value: patient?.name ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: patient?.gender == 0 ? Icons.man : Icons.woman,
                    label: 'Gender',
                    value: patient?.gender == 0 ? 'Male' : 'Female',
                  ),
                  _buildInfoRow(
                    icon: Icons.phone,
                    label: 'Phone number',
                    value: patient?.phone_number ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: patient?.email ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: Icons.home,
                    label: 'Address',
                    value: patient?.address ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: Icons.calendar_month,
                    label: 'Date of Birth',
                    value: patient?.dob != null
                        ? DateFormat('dd/MM/yyyy').format(
                      DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz')
                          .parse(patient!.dob!),
                    )
                        : 'Invalid date',
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