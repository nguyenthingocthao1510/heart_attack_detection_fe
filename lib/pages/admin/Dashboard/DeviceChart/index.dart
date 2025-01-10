import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/adminDashboard.d.dart';

class DeviceChartPage extends StatefulWidget {
  final DeviceChart? deviceChart;
  final DeviceChart? deviceNotAssign;

  const DeviceChartPage(
      {super.key, required this.deviceChart, required this.deviceNotAssign});

  @override
  State<DeviceChartPage> createState() => _DeviceChartPageState();
}

class _DeviceChartPageState extends State<DeviceChartPage> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final assignAmount = widget.deviceChart?.total_amount?.toDouble() ?? 0;
    final notAssignAmount =
        widget.deviceNotAssign?.total_amount?.toDouble() ?? 0;
    final total = assignAmount + notAssignAmount;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sectionsSpace: 4,
                  centerSpaceRadius: 50,
                  sections: [
                    makePieChartSection(
                        assignAmount, total, Colors.greenAccent, 'Assign', 0),
                    makePieChartSection(notAssignAmount, total,
                        Colors.cyanAccent, 'Not Assign', 1),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Indicator(
                color: Colors.greenAccent,
                text: 'Assign',
                isSquare: true,
              ),
              const SizedBox(height: 8),
              Indicator(
                color: Colors.cyanAccent,
                text: 'Not Assign',
                isSquare: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  PieChartSectionData makePieChartSection(
      double value, double total, Color color, String title, int index) {
    final isTouched = index == touchedIndex;
    final percentage = total == 0 ? 0 : (value / total * 100);
    return PieChartSectionData(
      value: value,
      title: '${percentage.toStringAsFixed(1)}%',
      color: color,
      titleStyle: TextStyle(
        color: Color(0xFF414656),
        fontSize: isTouched ? 18 : 16,
        fontWeight: FontWeight.bold,
      ),
      radius: isTouched ? 90 : 80,
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
