import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_app_prot1/features/home/presentation/widgets/bar_data.dart';

class CustomBarGraph extends StatefulWidget {
  final List<Map<String, dynamic>> weeklyDetection;
  const CustomBarGraph({super.key, required this.weeklyDetection});

  @override
  State<CustomBarGraph> createState() => _CustomBarGraphState();
}

class _CustomBarGraphState extends State<CustomBarGraph> {
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(weeklyDetection: widget.weeklyDetection);
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipMargin: 0,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String yValue = rod.toY.toString();
              return BarTooltipItem(
                yValue,
                TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        maxY: 8,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x + 1,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
                    width: 25,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ],
                showingTooltipIndicators: [0, 1, 22],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  int valueInteger = value.toInt();
  String dayInitial = DateFormat('MMM').format(DateTime.fromMillisecondsSinceEpoch(valueInteger)).substring(0, 3);
  return Text(dayInitial);
}
