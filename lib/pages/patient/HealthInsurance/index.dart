import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/healthInsurance.dart';
import 'package:heart_attack_detection_fe/pages/admin/HomePage/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/HealthInsurance/HealthInsuranceDetail/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/HealthInsurance/HealthInsuranceModal/index.dart';
import 'package:heart_attack_detection_fe/providers/accountProvider.dart';
import 'package:heart_attack_detection_fe/services/healthInsuranceAPI.dart';
import 'package:provider/provider.dart';

class HealthInsurancePage extends StatefulWidget {
  const HealthInsurancePage({super.key});

  @override
  State<HealthInsurancePage> createState() => _HealthInsurancePageState();
}

class _HealthInsurancePageState extends State<HealthInsurancePage> {
  PatientHealthInsurance? patient;
  List<HealthInsurance> healthInsurances = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllPatient();
    await getAllHealthInsurance();
  }

  Future<void> getAllPatient() async {
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

  Future<void> getAllHealthInsurance() async {
    try {
      final accountId =
          Provider.of<AccountProvider>(context, listen: false).accountId;
      final response =
          await HealthInsuranceAPI.getAllHealthInsurance(int.parse(accountId!));
      setState(() {
        healthInsurances = response;
      });
    } catch (e) {
      print('Error fetching health insurances: $e');
    }
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
      body: healthInsurances.isEmpty
          ? const Center(
              child: Text(
                'No information about health insurance! Please press the button to create one!',
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              color: const Color(0xFFF5F6FA),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: healthInsurances.length,
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) {
                  final healthInsurance = healthInsurances[index];
                  final healthInsuranceId = healthInsurance.health_insurance_id;
                  final name = healthInsurance.name;

                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(name ?? 'Unnamed'),
                      subtitle: Text('ID: ${healthInsuranceId ?? 'Unknown'}'),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthInsuranceDetail(
                                  patientId: patient?.id,
                                  healthInsurance: healthInsurance),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: healthInsurances.isEmpty
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HealthInsuranceModal(patientId: patient?.id)),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white, size: 35),
            )
          : null,
    );
  }
}
