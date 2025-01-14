import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/dashboard.dart';

class BarChartDashboard extends StatefulWidget {
  final List<Dashboard>? ecg;

  const BarChartDashboard({super.key, this.ecg});

  @override
  State<BarChartDashboard> createState() => _BarChartDashboardState();
}

class _BarChartDashboardState extends State<BarChartDashboard> {
  Widget _buildBottomTitle(double value, TitleMeta meta) {
    List<Dashboard> reversedEcg = widget.ecg?.reversed.toList() ?? [];

    int index = value.toInt();

    if (index < 0 || index >= reversedEcg.length) {
      return const SizedBox.shrink();
    }

    DateTime? timestamp = reversedEcg[index].timestamp;
    String formattedTime = timestamp != null
        ? "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}"
        : "N/A";

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        formattedTime,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Dashboard> reversedEcg = widget.ecg?.reversed.toList() ?? [];

    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 8,
            getTooltipItem: (BarChartGroupData group, int groupIndex,
                BarChartRodData rod, int rodIndex) {
              return BarTooltipItem(
                rod.toY.round().toString(),
                const TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: _buildBottomTitle,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, TitleMeta meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4,
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: reversedEcg.asMap().entries.map((entry) {
          int index = entry.key;
          double heartRate = entry.value.restecg?.toDouble() ?? 0;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: heartRate,
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.cyan],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ],
          );
        }).toList(),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 200,
      ),
    );
  }
}
