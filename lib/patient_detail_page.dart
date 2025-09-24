
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:provider/provider.dart';

import 'package:myapp/models/patient.dart';
import 'package:myapp/theme_provider.dart';

class PatientDetailPage extends StatefulWidget {
  final Patient patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  String _selectedTimeRange = '24h';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient.name),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha(25),
              Theme.of(context).colorScheme.secondary.withAlpha(25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildPatientInfo(),
              const SizedBox(height: 24),
              _buildLiveVitals(),
              const SizedBox(height: 24),
              _buildVitalsTrends(),
              const SizedBox(height: 24),
              _buildNotesSection(),
              const SizedBox(height: 24),
              _buildMedications(),
              const SizedBox(height: 24),
              _buildAlertStatus(),
              const SizedBox(height: 24),
              _buildConnectedDevices(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: widget.patient.profilePhotoUrl != null
                  ? AssetImage(widget.patient.profilePhotoUrl!)
                  : null,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age: 35', style: Theme.of(context).textTheme.titleMedium),
                Text('Gender: Male', style: Theme.of(context).textTheme.titleMedium),
                Text('ID: 123456', style: Theme.of(context).textTheme.titleMedium),
                Text('Contact: 555-1234', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveVitals() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Live Vitals', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                VitalTile(name: 'Heart Rate', value: '80 bpm'),
                VitalTile(name: 'Blood Pressure', value: '120/80 mmHg'),
                VitalTile(name: 'SpO2', value: '98%'),
                VitalTile(name: 'Respiratory Rate', value: '16 rpm'),
                VitalTile(name: 'Temperature', value: '37.0 C'),
                VitalTile(name: 'Glucose', value: '90 mg/dL'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalsTrends() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vitals Trends', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
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
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: _selectedTimeRange == range ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildVitalChart(
      String title, String unit, double minRange, double maxRange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Standard Range: $minRange - $maxRange $unit',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Theme.of(context).dividerColor,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: _getChartData(minRange, maxRange),
                  isCurved: true,
                  color: Theme.of(context).colorScheme.primary,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              minY: minRange - 10,
              maxY: maxRange + 10,
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: maxRange,
                    color: Theme.of(context).colorScheme.error,
                    strokeWidth: 2,
                  ),
                  HorizontalLine(
                    y: minRange,
                    color: Theme.of(context).colorScheme.error,
                    strokeWidth: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _getChartData(double min, double max) {
    final Random random = Random();
    final int numPoints = _selectedTimeRange == '24h'
        ? 24
        : _selectedTimeRange == '7d'
            ? 7
            : 30;
    return List.generate(numPoints, (index) {
      return FlSpot(index.toDouble(), min + random.nextDouble() * (max - min));
    });
  }

  Widget _buildNotesSection() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Patient is responding well to treatment.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedications() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Medications', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Aspirin, 81mg, daily',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertStatus() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text('Alert Status:', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Text(
              widget.patient.status,
              style: TextStyle(
                fontSize: 20,
                color: _getStatusColor(widget.patient.status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedDevices() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Connected Devices', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Apple Watch Series 9',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Critical':
        return Colors.red;
      case 'Warning':
        return Colors.amber;
      case 'Stable':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class VitalTile extends StatelessWidget {
  final String name;
  final String value;

  const VitalTile({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
