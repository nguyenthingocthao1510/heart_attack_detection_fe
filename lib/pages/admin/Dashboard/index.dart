import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/adminDashboard.d.dart';
import 'package:heart_attack_detection_fe/pages/admin/Dashboard/AccountChart/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Dashboard/DeviceChart/index.dart';
import 'package:heart_attack_detection_fe/pages/admin/Dashboard/MedicineChart/index.dart';
import 'package:heart_attack_detection_fe/services/adminDashboard.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  List<MedicineChart> medicinesChart = [];
  AccountChart? accountActive;
  AccountChart? accountInactive;
  DeviceChart? deviceChart;
  DeviceChart? deviceNotAssign;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      await fetchMedicineData();
      await fetchAccountData();
      await fetchDeviceData();
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchMedicineData() async {
    final response = await AdminDashboardAPI.getAllMedicineInfo();
    setState(() {
      medicinesChart = response;
    });
  }

  Future<void> fetchAccountData() async {
    final active = await AdminDashboardAPI.getAccountActiveChart();
    final inactive = await AdminDashboardAPI.getAccountInactiveChart();
    setState(() {
      accountActive = active;
      accountInactive = inactive;
    });
  }

  Future<void> fetchDeviceData() async {
    final assigned = await AdminDashboardAPI.getDeviceChart();
    final notAssigned = await AdminDashboardAPI.getDeviceNotAssignChart();
    setState(() {
      deviceChart = assigned;
      deviceNotAssign = notAssigned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Administrator dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF1B2339)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.white],
                  ).createShader(bounds),
                  child: const Text(
                    'Medicine:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              MedicineChartPage(medicinesChart: medicinesChart),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.white],
                  ).createShader(bounds),
                  child: const Text(
                    'Account:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              AccountChartPage(
                  accountActive: accountActive,
                  accountInactive: accountInactive),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.white],
                  ).createShader(bounds),
                  child: const Text(
                    'Device:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              DeviceChartPage(
                  deviceChart: deviceChart, deviceNotAssign: deviceNotAssign),
            ],
          )),
        ),
      ),
    );
  }
}
