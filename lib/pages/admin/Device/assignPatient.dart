import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';
import 'package:heart_attack_detection_fe/models/Device/device.dart';
import 'package:heart_attack_detection_fe/services/Device/device.dart';

class AssignPatientPage extends StatefulWidget {
  final String deviceId;
  final VoidCallback onRefresh;
  const AssignPatientPage({super.key, required this.deviceId, required this.onRefresh});

  @override
  State<AssignPatientPage> createState() => _AssignPatientPageState();
}

class _AssignPatientPageState extends State<AssignPatientPage> {
  final DeviceApi deviceApi = DeviceApi();
  Future<UnassignedPatient>? patientFuture;
  UnassignedPatient? patients;
  late bool checkSelected;

  @override
  void initState() {
    super.initState();
    fetchUnassignedPatients();
    checkSelected = false;
  }

  Future<void> fetchUnassignedPatients() async {
    try {
      final data = await deviceApi.getAllUnassignedPatient();
      setState(() {
        patients = data;
        patientFuture = Future.value(data);
      });
    } catch (error) {
        print('Error fetching patients: $error');
      setState(() {
        patientFuture = Future.error(error);
      });
    }
  }


void selectPatient(int index) {
  if (patients == null) return;

  setState(() {
    for (var patient in patients!.unassigned_patient) {
      patient['selected'] = false;
    }
    patients!.unassigned_patient[index]['selected'] = true;
    checkSelected = true;
  });
}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<UnassignedPatient>(
          future: patientFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final patientData = snapshot.data!.unassigned_patient;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select patient to assign',
                    style: CustomTextStyle.textStyle1(24, Colors.black),
                  ),
                  CustomDivider.divider2(context, 0.04),
                  _buildListViewLabel(context),
                  Expanded(
                    child: ListView.builder(
                      itemCount: patientData.length,
                      itemBuilder: (context, index) {
                        final patients = patientData[index];
                        return Column(
                          children: [
                            CustomDivider.divider2(context, 0.01),
                            _buildPatientInformation(context, patients, index),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildConfirmButton(context, patientData),
                ],
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildListViewLabel(BuildContext context) {
    List labels = ["ID", "Name"];
    return Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            ...labels.map((label) =>
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.textStyle1(16, Colors.black)
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildPatientInformation(BuildContext context, Map<String, dynamic> item, int index) {
    final patientId = item['patient_id'];
    final patientName = item['patient_name'];

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => selectPatient(index),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: item['selected']
                ? const Color.fromARGB(255, 20, 139, 251)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: item['selected']
                    ? const Color.fromARGB(255, 20, 139, 251)
                    : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Text(
                  patientId.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: item['selected']
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: item['selected']
                    ? const Color.fromARGB(255, 20, 139, 251)
                    : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Text(
                  patientName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: item['selected']
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              ),
            ],
          )
        ),
      )
    );
  }

  Widget _buildConfirmButton(BuildContext context, List<Map<String, dynamic>> patients) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          checkSelected ? 
        const Color.fromARGB(255, 20, 139, 251) :
          Colors.grey
        ),
      ),
      onPressed: () async {
        if (checkSelected) {
          final selectedPatient = patients.firstWhere(
                (patient) => patient['selected'] == true,
          );
          if (selectedPatient != null) {
            final patientId = AssignDevice(patient_id: selectedPatient['patient_id']);
            await deviceApi.updateDeviceAssignment(widget.deviceId, patientId);
            widget.onRefresh();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Patient assigned successfully!')),
              );
              Navigator.pop(context);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a patient to assign')),
            );
          }
        }
      }, 
      child: Text(
        'Confirm',
        style: CustomTextStyle.textStyle2(
          16, 
          Colors.white
        ),
      )
    );
  }
}

