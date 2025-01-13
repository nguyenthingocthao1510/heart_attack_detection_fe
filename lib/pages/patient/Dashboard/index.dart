import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/BarChart/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/LineChart/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/PieChart/index.dart';
import 'package:heart_attack_detection_fe/services/dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Dashboard> avgBpm = [];
  List<Dashboard> ecg = [];
  List<Dashboard> bpm = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    startDataFetching();
  }

  Future<void> fetchData() async {
    await getAllAvgBPM();
    await getAllECG();
    await getAllBPM();
  }

  void startDataFetching() {
    _timer = Timer.periodic(Duration(seconds: 65), (timer) async {
      await fetchData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> getAllAvgBPM() async {
    final response = await PatientDashboardAPI.getAllAvgBPM();
    setState(() {
      avgBpm = response;
    });
  }

  Future<void> getAllECG() async {
    final response = await PatientDashboardAPI.getAllECG();
    setState(() {
      ecg = response;
    });
  }

  Future<void> getAllBPM() async {
    final response = await PatientDashboardAPI.getAllBPM();
    setState(() {
      bpm = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.cyan,
        leading: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 15,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.redAccent],
                  ).createShader(bounds),
                  child: const Text(
                    'Average BPM:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                child: LineChartDashboard(
                  avgBpm: avgBpm,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 30, bottom: 20),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.redAccent],
                  ).createShader(bounds),
                  child: const Text(
                    'ECG per minutes:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: BarChartDashboard(
                    ecg: ecg,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 0, bottom: 20),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.redAccent],
                  ).createShader(bounds),
                  child: const Text(
                    'BPM:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                child: PieChart(
                  bpms: bpm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
