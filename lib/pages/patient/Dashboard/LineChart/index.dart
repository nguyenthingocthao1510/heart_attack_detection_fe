import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';
import 'package:heart_attack_detection_fe/services/dashboard.dart';
import 'package:intl/intl.dart';

class LineChartDashboard extends StatefulWidget {
  const LineChartDashboard({super.key});

  @override
  State<LineChartDashboard> createState() => _LineChartDashboardState();
}

class _LineChartDashboardState extends State<LineChartDashboard> {
  List<Color> gradientColors = [Colors.orangeAccent, Colors.redAccent];
  List<Dashboard> heartBeats = [];
  Timer? timer;
  double xValue = 0;
  double step = 0.05;

  @override
  void initState() {
    super.initState();
    heartBeats = [];
    fetchData();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      fetchLatestHeartRate();
    });
  }

  Future<void> fetchData() async {
    final response = await DashboardAPI.getAvgBPM();
    if (mounted) {
      setState(() {
        heartBeats.clear();
        heartBeats = response.toList();
      });
    }
  }

  Future<void> fetchLatestHeartRate() async {
    final response = await DashboardAPI.getAvgBPM();
    if (response.isNotEmpty && mounted) {
      setState(() {
        heartBeats.add(response.last);

        while (heartBeats.length > 5) {
          heartBeats.removeAt(0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
              curve: Curves.easeInOut,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int index = value.toInt();
    if (index >= heartBeats.length || index < 0) {
      return Container();
    }
    String text = DateFormat('HH:mm')
        .format(DateTime.parse(heartBeats[index].timestamp!));
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      minX: 0,
      maxX: heartBeats.length.toDouble() - 1,
      minY: 0,
      maxY: 120,
      lineBarsData: [
        LineChartBarData(
          spots: heartBeats.asMap().entries.map((entry) {
            int index = entry.key;
            Dashboard data = entry.value;
            return FlSpot(index.toDouble(), data.AvgBPM?.toDouble() ?? 0);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
              spotsLine: BarAreaSpotsLine(
                  show: true, flLineStyle: FlLine(color: Colors.cyan))),
        ),
      ],
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
    );
  }
}
