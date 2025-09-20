import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomLineChart extends StatelessWidget {
  final List<FlSpot> spots;              // Your data points
  final String title;                    // Title above chart
  final Color lineColor;                 // Line color
  final Color fillColor;                 // Area fill color
  final bool showDots;                   // Show/hide dots
  final double minY;                     // Y axis min
  final double maxY;                     // Y axis max

  const CustomLineChart({
    super.key,
    required this.spots,
    this.title = "",
    this.lineColor = Colors.blue,
    this.fillColor = const Color(0x2200a0dc),
    this.showDots = true,
    this.minY = 0,
    this.maxY = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
              ),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: (spots.length - 1).toDouble(),
                  minY: minY,
                  maxY: maxY,
                  gridData: FlGridData(show: true, horizontalInterval: 1),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) => Text("M${value.toInt() + 1}"),
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: lineColor,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: showDots),
                      belowBarData: BarAreaData(
                        show: true,
                        color: fillColor,
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      // tooltipBgColor: Colors.white,
                      getTooltipItems: (touchedSpots) => touchedSpots.map((ts) {
                        return LineTooltipItem(
                          "Month ${ts.x.toInt() + 1}\n${ts.y.toStringAsFixed(2)}",
                          TextStyle(
                            color: lineColor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
