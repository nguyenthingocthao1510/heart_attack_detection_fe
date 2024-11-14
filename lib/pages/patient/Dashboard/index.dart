import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/BarChart/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/LineChart/index.dart';
import 'package:heart_attack_detection_fe/pages/patient/Dashboard/PieChart/index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final bool isShowingMainData = true;

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
                    'Heartbeat per minute:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const LineChartDashboard(),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 30, bottom: 20),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.redAccent],
                  ).createShader(bounds),
                  child: const Text(
                    'SP02 per minute:',
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
                  child: const BarChartDashboard(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 0, bottom: 20),
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.redAccent],
                  ).createShader(bounds),
                  child: const Text(
                    'Temperature per minute:',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const PieChartDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
