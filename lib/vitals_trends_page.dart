import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class VitalsTrendsPage extends StatefulWidget {
  const VitalsTrendsPage({super.key});

  @override
  State<VitalsTrendsPage> createState() => _VitalsTrendsPageState();
}

class _VitalsTrendsPageState extends State<VitalsTrendsPage> {
  String _selectedTimeRange = '24h';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vitals Trends'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTimeRangeFilter(),
            const SizedBox(height: 24),
            _buildVitalChart('Heart Rate', 'bpm', 60, 100),
            const SizedBox(height: 24),
            _buildVitalChart('Blood Pressure', 'mmHg', 90, 120),
            const SizedBox(height: 24),
            _buildVitalChart('SpO2', '%', 95, 100),
            const SizedBox(height: 24),
            _buildVitalChart('Respiratory Rate', 'rpm', 12, 20),
            const SizedBox(height: 24),
            _buildVitalChart('Temperature', 'C', 36.5, 37.5),
            const SizedBox(height: 24),
            _buildVitalChart('Glucose', 'mg/dL', 70, 100),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterChip('24h'),
        _buildFilterChip('7d'),
        _buildFilterChip('30d'),
      ],
    );
  }

  Widget _buildFilterChip(String range) {
    return ChoiceChip(
      label: Text(range),
      selected: _selectedTimeRange == range,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedTimeRange = range;
          });
        }
      },
    );
  }

  Widget _buildVitalChart(String title, String unit, double minRange, double maxRange) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Standard Range: $minRange - $maxRange $unit', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getChartData(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minY: minRange - 10,
                  maxY: maxRange + 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getChartData() {
    final Random random = Random();
    final int numPoints = _selectedTimeRange == '24h'
        ? 24
        : _selectedTimeRange == '7d'
            ? 7
            : 30;
    return List.generate(numPoints, (index) {
      return FlSpot(index.toDouble(), 80 + random.nextDouble() * 20);
    });
  }
}
