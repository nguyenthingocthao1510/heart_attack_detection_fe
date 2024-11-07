import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';
import 'package:heart_attack_detection_fe/services/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PieChartDashboard extends StatefulWidget {
  const PieChartDashboard({super.key});

  @override
  State<PieChartDashboard> createState() => _PieChartDashboardState();
}

class _PieChartDashboardState extends State<PieChartDashboard> {
  Timer? _timer;
  List<Dashboard> temperatures = [];
  double latestTemperature = 0.0;
  String latestTime = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    startDataFetching();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    await getAllTemperature();
  }

  Future<void> getAllTemperature() async {
    final response = await DashboardAPI.getTemperature();
    setState(() {
      temperatures = response;
      if (temperatures.isNotEmpty) {
        latestTemperature = temperatures.last.temperature?.toDouble() ?? 0.0;
        latestTime = DateFormat('HH:mm').format(DateTime.parse(
            temperatures.last.timestamp ?? DateTime.now().toString()));
      }
    });
  }

  void startDataFetching() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) async {
      await getAllTemperature();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: '',
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: 30, maximum: 40, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 34,
                color: Colors.blue.shade50,
                startWidth: 20,
                endWidth: 20),
            GaugeRange(
                startValue: 34,
                endValue: 37,
                color: Colors.green.shade300,
                startWidth: 20,
                endWidth: 20),
            GaugeRange(
                startValue: 37,
                endValue: 40,
                color: Colors.red,
                startWidth: 20,
                endWidth: 20)
          ], pointers: <GaugePointer>[
            NeedlePointer(
              knobStyle: KnobStyle(color: Colors.blue.shade100),
              value: latestTemperature,
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.cyan.shade300.withOpacity(0.5)]),
            ),
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      latestTemperature.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      latestTime,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )),
                angle: 90,
                positionFactor: 0.8)
          ])
        ]);
  }
}
