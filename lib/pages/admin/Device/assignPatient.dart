import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/themes/textStyle.dart';
import 'package:heart_attack_detection_fe/themes/divider.dart';
import 'package:heart_attack_detection_fe/models/Device/device.dart';
import 'package:heart_attack_detection_fe/services/Device/device.dart';

class AssignPatientPage extends StatefulWidget {
  final String deviceId;
  const AssignPatientPage({super.key, required this.deviceId});

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
      height: MediaQuery.of(context).size.height * 0.5,
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
              print('Patient: $patientFuture');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final patientData = snapshot.data!.unassigned_patient;
              return Column(
                children: [
                  Text(
                    'Select patient to assign',
                    style: CustomTextStyle.textStyle1(24, Colors.black),
                  ),
                  CustomDivider.divider2(context, 0.05),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: patientData.length,
                      itemBuilder: (context, index) {
                        final patients = patientData[index];
                        return Column(
                          children: [
                            _buildPatientInformation(context, patients, index),
                          ],
                        );
                      },
                    ),
                  ),
                  _buildConfirmButton(context),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                patientId.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: item['selected']
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                patientName,
                style: TextStyle(
                  fontSize: 16,
                  color: item['selected']
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          )
        ),
      )
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          checkSelected ? 
        const Color.fromARGB(255, 20, 139, 251) :
          Colors.grey
        ),
      ),
      onPressed: () {

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

