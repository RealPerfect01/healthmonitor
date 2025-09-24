import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:myapp/models/patient.dart';

class PatientDetailPage extends StatelessWidget {
  final Patient patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildPatientInfo(),
            const SizedBox(height: 24),
            _buildLiveVitals(),
            const SizedBox(height: 24),
            _buildHistoricalDataChart(),
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
    );
  }

  Widget _buildPatientInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: patient.profilePhotoUrl != null ? AssetImage(patient.profilePhotoUrl!) : null,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age: 35', style: const TextStyle(fontSize: 16)),
                Text('Gender: Male', style: const TextStyle(fontSize: 16)),
                Text('ID: 123456', style: const TextStyle(fontSize: 16)),
                Text('Contact: 555-1234', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveVitals() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Live Vitals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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

  Widget _buildHistoricalDataChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Historical Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
    return List.generate(30, (index) {
      return FlSpot(index.toDouble(), random.nextDouble() * 100);
    });
  }

  Widget _buildNotesSection() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Patient is responding well to treatment.'),
          ],
        ),
      ),
    );
  }

  Widget _buildMedications() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Medications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Aspirin, 81mg, daily'),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertStatus() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text('Alert Status:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(width: 16),
            Text('Stable', style: TextStyle(fontSize: 20, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedDevices() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Connected Devices', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Apple Watch Series 9'),
          ],
        ),
      ),
    );
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
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
