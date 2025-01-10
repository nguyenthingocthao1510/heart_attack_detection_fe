import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/adminDashboard.d.dart';

class AccountChartPage extends StatelessWidget {
  final AccountChart? accountActive;
  final AccountChart? accountInactive;

  const AccountChartPage(
      {super.key, required this.accountActive, required this.accountInactive});

  @override
  Widget build(BuildContext context) {
    double maxY = (accountActive?.total_amount ?? 0) >
            (accountInactive?.total_amount ?? 0)
        ? (accountActive?.total_amount?.toDouble() ?? 0)
        : (accountInactive?.total_amount?.toDouble() ?? 0);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1,
        child: BarChart(
          BarChartData(
            maxY: maxY + 10,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String title = group.x == 0 ? 'Active' : 'Inactive';
                  String value = group.x == 0
                      ? 'Active: ${accountActive?.total_amount ?? 0}'
                      : 'Inactive: ${accountInactive?.total_amount ?? 0}';
                  return BarTooltipItem(value,
                      const TextStyle(color: Colors.white, fontSize: 14));
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(value == 0 ? 'Active' : 'Inactive',
                        style: const TextStyle(color: Colors.white));
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toString(),
                        style: const TextStyle(color: Colors.white));
                  },
                ),
              ),
            ),
            barGroups: [
              makeGroupData(0, accountActive?.total_amount?.toDouble() ?? 0),
              makeGroupData(1, accountInactive?.total_amount?.toDouble() ?? 0),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: x == 0 ? Colors.yellowAccent : Colors.redAccent,
          width: 22,
        ),
      ],
    );
  }
}
