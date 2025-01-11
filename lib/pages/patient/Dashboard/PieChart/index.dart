import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PieChart extends StatefulWidget {
  final List<Dashboard>? bpms;

  const PieChart({super.key, this.bpms});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late double latestBpm;
  late String latestTime;

  @override
  void initState() {
    super.initState();
    latestBpm = 0.0;
    latestTime = "N/A";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bpms != null && widget.bpms!.isNotEmpty) {
      final latestData = widget.bpms!.first;

      if (latestData.timestamp != null) {
        DateTime timestamp = latestData.timestamp!;

        latestTime =
            "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
      } else {
        latestTime = "N/A";
      }

      latestBpm = latestData.thalachh?.toDouble() ?? 0.0;
    }

    return SfRadialGauge(
      title: GaugeTitle(
        text: '',
        textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 121,
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 59,
                color: Colors.blue.shade50,
                startWidth: 20,
                endWidth: 20),
            GaugeRange(
                startValue: 60,
                endValue: 100,
                color: Colors.green.shade300,
                startWidth: 20,
                endWidth: 20),
            GaugeRange(
                startValue: 101,
                endValue: 120,
                color: Colors.red,
                startWidth: 20,
                endWidth: 20),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              knobStyle: KnobStyle(color: Colors.blue.shade100),
              value: latestBpm,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyan.shade300.withOpacity(0.5)],
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      latestBpm.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      latestTime,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              angle: 90,
              positionFactor: 0.8,
            ),
          ],
        ),
      ],
    );
  }
}
