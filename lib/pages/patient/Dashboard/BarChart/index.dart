import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';
import 'package:heart_attack_detection_fe/services/dashboard.dart';
import 'package:intl/intl.dart';

class BarChartDashboard extends StatefulWidget {
  const BarChartDashboard({super.key});

  @override
  State<BarChartDashboard> createState() => _BarChartDashboardState();
}

class _BarChartDashboardState extends State<BarChartDashboard> {
  Timer? _timer;
  List<Dashboard> heartbeats = [];

  @override
  void initState() {
    super.initState();

    heartbeats = List.generate(
      10,
      (index) => Dashboard(
        heartRate: 60 + index,
        timestamp:
            DateTime.now().subtract(Duration(seconds: 60)).toIso8601String(),
      ),
    );

    fetchData();
    startDataFetching();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    await getLatestHeartBeats();
  }

  void startDataFetching() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) async {
      await getLatestHeartBeats();
    });
  }

  Future<void> getLatestHeartBeats() async {
    final response = await DashboardAPI.getHeartRate();
    if (response.isNotEmpty) {
      setState(() {
        heartbeats = response.length > 5
            ? response.sublist(response.length - 5)
            : response;
      });
    }
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
        color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 10);

    String text = '';
    if (value >= 0 && value < heartbeats.length) {
      final timestamp = heartbeats[value.toInt()].timestamp;
      text = timestamp != null
          ? DateFormat('HH:mm').format(DateTime.parse(timestamp))
          : '00:00';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return SideTitleWidget(
              axisSide: meta.axisSide,
              space: 4,
              child: Text(
                value.toString(),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)));

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient => LinearGradient(
      colors: [Colors.blue, Colors.cyan],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);

  List<BarChartGroupData> get barGroups {
    return heartbeats.asMap().entries.map((entry) {
      int index = entry.key;
      double? heartRate = entry.value.heartRate?.toDouble() ?? 0;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: heartRate,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 120,
      ),
    );
  }
}
