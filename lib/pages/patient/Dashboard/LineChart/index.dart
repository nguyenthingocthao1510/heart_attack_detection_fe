import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';

class LineChartDashboard extends StatefulWidget {
  final List<Dashboard>? avgBpm;

  const LineChartDashboard({super.key, this.avgBpm});

  @override
  State<LineChartDashboard> createState() => _LineChartDashboardState();
}

class _LineChartDashboardState extends State<LineChartDashboard> {
  List<Color> gradientColors = [Colors.orangeAccent, Colors.redAccent];

  @override
  void initState() {
    super.initState();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int index = value.toInt();

    if (widget.avgBpm == null ||
        widget.avgBpm!.isEmpty ||
        index < 0 ||
        index >= widget.avgBpm!.length) {
      return Container();
    }

    DateTime timestamp = widget.avgBpm![index].timestamp!;
    String formattedTime = "${timestamp.hour}:${timestamp.minute}";

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        formattedTime,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
      ),
    );
  }

  LineChartData mainData() {
    List<Dashboard> sortedAvgBpm = List.from(widget.avgBpm ?? []);
    sortedAvgBpm.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

    List<FlSpot> spots = sortedAvgBpm.asMap().entries.map((entry) {
      int index = entry.key;
      Dashboard data = entry.value;

      return FlSpot(
        index.toDouble(),
        (data.avg_bpm?.toDouble() ?? 0).clamp(0, 120),
      );
    }).toList();

    return LineChartData(
      minX: 0,
      maxX: spots.isNotEmpty ? spots.length - 1 : 0,
      minY: 0,
      maxY: 120,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
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
            getTitlesWidget: (value, meta) {
              int index = value.toInt();

              if (index < 0 || index >= sortedAvgBpm.length) {
                return Container();
              }

              DateTime timestamp = sortedAvgBpm[index].timestamp!;
              String formattedTime = "${timestamp.hour}:${timestamp.minute}";

              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 20,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              );
            },
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: FlGridData(show: true),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          top: BorderSide.none,
          right: BorderSide.none,
          left: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        ),
      ),
    );
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
}
