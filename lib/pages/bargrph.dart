import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;





class _BarChart extends StatelessWidget {
  _BarChart();


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
        maxY: 100, // Maximum marks
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(

      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          '${rod.toY.round()} marks',
          TextStyle(
            color: colors[groupIndex % colors.length],
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final TextStyle style = TextStyle(
      color: colors[value.toInt() % colors.length],
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    List<String> subjects = ['Math', 'Science', 'History', 'Art', 'English', 'PE', 'Music'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(subjects[value.toInt()], style: style),
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
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<Color> colors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.cyanAccent,
  ];

  LinearGradient getGradient(int index) => LinearGradient(
    colors: [
      colors[index % colors.length],
      colors[index % colors.length].withOpacity(0.5),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => List.generate(7, (index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: (index + 1) * 10 + (5 * (index % 3)), // Example marks data
          gradient: getGradient(index),
        )
      ],
      showingTooltipIndicators: [0],
    );
  });

}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(),
    );
  }
}



