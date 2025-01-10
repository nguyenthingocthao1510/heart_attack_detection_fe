import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/adminDashboard.d.dart';

class MedicineChartPage extends StatefulWidget {
  final List<MedicineChart> medicinesChart;

  const MedicineChartPage({super.key, required this.medicinesChart});

  @override
  State<MedicineChartPage> createState() => _MedicineChartPageState();
}

class _MedicineChartPageState extends State<MedicineChartPage> {
  int touchedIndex = -1;
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    if (widget.medicinesChart.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 38),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      duration: animDuration,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double totalAmount, {
    bool isTouched = false,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: 100,
          width: 20,
          color: Color(0xFF414656),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              totalAmount,
              isTouched ? Colors.blueAccent : Colors.white,
            ),
          ],
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ],
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            if (groupIndex < 0 || groupIndex >= widget.medicinesChart.length) {
              return null;
            }
            final medicine = widget.medicinesChart[groupIndex];
            return BarTooltipItem(
              '${medicine.name}: ${medicine.total_amount}',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              final index = value.toInt();
              if (index < 0 || index >= widget.medicinesChart.length) {
                return const Text('');
              }
              return Text(
                widget.medicinesChart[index].name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: widget.medicinesChart.asMap().entries.map((entry) {
        int index = entry.key;
        MedicineChart medicine = entry.value;
        return makeGroupData(
          index,
          medicine.total_amount?.toDouble() ?? 0,
          isTouched: index == touchedIndex,
        );
      }).toList(),
      gridData: const FlGridData(show: false),
    );
  }
}
