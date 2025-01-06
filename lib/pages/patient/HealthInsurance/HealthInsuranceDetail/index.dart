import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/healthInsurance.dart';
import 'package:heart_attack_detection_fe/pages/patient/HealthInsurance/HealthInsuranceModal/index.dart';
import 'package:heart_attack_detection_fe/routes/route.constant.dart';
import 'package:heart_attack_detection_fe/services/healthInsuranceAPI.dart';

class HealthInsuranceDetail extends StatefulWidget {
  final HealthInsurance? healthInsurance;
  final int? patientId;

  const HealthInsuranceDetail(
      {super.key, this.healthInsurance, this.patientId});

  @override
  State<HealthInsuranceDetail> createState() => _HealthInsuranceDetailState();
}

class _HealthInsuranceDetailState extends State<HealthInsuranceDetail> {
  late Future<HealthInsurance> healthInsurance;

  @override
  void initState() {
    super.initState();
    healthInsurance = fetchHealthInsuranceData();
  }

  Future<HealthInsurance> fetchHealthInsuranceData() async {
    try {
      final data = await HealthInsuranceAPI.getHealthInsuranceById(
          widget.healthInsurance!.id!);
      return data;
    } catch (e) {
      throw Exception('Failed to fetch health insurance details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Health Insurance Detail'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<HealthInsurance>(
        future: healthInsurance,
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

          final healthInsuranceData = snapshot.data!;

          return Column(
            children: [
              Card(
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
                          'Health Insurance Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          title: 'Registration Place:',
                          value:
                              healthInsuranceData.registration_place ?? 'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          title: 'Place Provide:',
                          value: healthInsuranceData.place_provide ?? 'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          title: 'Shelf Life:',
                          value: healthInsuranceData.shelf_life.toString() ??
                              'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          title: '5 Years Insurance:',
                          value: healthInsuranceData.five_years_insurance
                                  .toString() ??
                              'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          title: 'Create Date:',
                          value: healthInsuranceData.create_date.toString() ??
                              'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          title: 'Modified By:',
                          value: healthInsuranceData.modified_by ?? 'N/A',
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          title: 'Health Insurance ID:',
                          value:
                              healthInsuranceData.health_insurance_id ?? 'N/A',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HealthInsuranceModal(
                                    healthInsurance: healthInsuranceData,
                                    patientId: widget.patientId,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const SizedBox(
                              width: 200,
                              child: Center(
                                child: Text(
                                  'Update Health Insurance',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              final bool? isConfirmed = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                    'Are you sure you want to delete this health insurance?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (isConfirmed == true) {
                                try {
                                  await HealthInsuranceAPI
                                      .deleteHealthInsurance(
                                          healthInsuranceData.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Health insurance deleted successfully')),
                                  );
                                  Navigator.pushNamed(
                                      context, healthInsuranceRoute);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to delete health insurance: $e')),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const SizedBox(
                              width: 200,
                              child: Center(
                                child: Text(
                                  'Delete Health Insurance',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
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
