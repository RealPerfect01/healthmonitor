import 'package:flutter/material.dart';
import 'package:myapp/help_center_page.dart';
import 'package:myapp/login_screen.dart';
import 'package:myapp/models/patient.dart';
import 'package:myapp/patient_list_page.dart';
import 'package:myapp/settings_page.dart';
import 'package:myapp/splash_screen.dart';
import 'package:myapp/theme_provider.dart';
import 'package:myapp/vitals_trends_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/patientList': (context) => const PatientListPage(),
            '/vitalsTrends': (context) => const VitalsTrendsPage(),
            '/settings': (context) => const SettingsPage(),
            '/helpCenter': (context) => const HelpCenterPage(),
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Patient> _allPatients = [
    Patient(name: 'John Doe', condition: 'Fever', status: 'Stable'),
    Patient(name: 'Jane Smith', condition: 'Heart Condition', status: 'Critical'),
    Patient(name: 'Peter Jones', condition: 'Diabetes', status: 'Stable'),
    Patient(name: 'Mary Johnson', condition: 'Asthma', status: 'Warning'),
    Patient(name: 'David Williams', condition: 'Hypertension', status: 'Stable'),
    Patient(name: 'Susan Brown', condition: 'Kidney Disease', status: 'Critical'),
    Patient(name: 'Sarah Lee', condition: 'Pneumonia', status: 'Stable'),
    Patient(name: 'Michael Clark', condition: 'Migraine', status: 'Warning'),
    Patient(name: 'Emily Rodriguez', condition: 'Broken Leg', status: 'Stable'),
    Patient(name: 'Daniel Martinez', condition: 'COVID-19', status: 'Critical'),
    Patient(name: 'Jessica Taylor', condition: 'Allergies', status: 'Stable'),
  ];

  List<Patient> _filteredPatients = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
    _searchController.addListener(() {
      _filterPatients();
    });
  }

  void _filterPatients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPatients = _allPatients.where((patient) {
        final nameMatches = patient.name.toLowerCase().contains(query);
        final conditionMatches = patient.condition.toLowerCase().contains(query);
        final statusMatches = _selectedFilter == 'All' || patient.status == _selectedFilter;
        return (nameMatches || conditionMatches) && statusMatches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final criticalAlerts = _allPatients.where((p) => p.status == 'Critical').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Vitals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.trending_up),
            onPressed: () {
              Navigator.pushNamed(context, '/vitalsTrends');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              Navigator.pushNamed(context, '/helpCenter');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildVitalAlertsSummary(criticalAlerts),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterButtons(),
            const SizedBox(height: 16),
            Expanded(child: _buildPatientList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/patientList');
        },
        child: const Icon(Icons.list),
      ),
    );
  }

  Widget _buildVitalAlertsSummary(int criticalAlerts) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Vital Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('$criticalAlerts Critical Cases', style: const TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search Patients',
        hintText: 'Search by name or condition',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterChip('All'),
        _buildFilterChip('Critical'),
        _buildFilterChip('Warning'),
        _buildFilterChip('Stable'),
      ],
    );
  }

  Widget _buildFilterChip(String filter) {
    return ChoiceChip(
      label: Text(filter),
      selected: _selectedFilter == filter,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = filter;
            _filterPatients();
          });
        }
      },
    );
  }

  Widget _buildPatientList() {
    return ListView.builder(
      itemCount: _filteredPatients.length,
      itemBuilder: (context, index) {
        final patient = _filteredPatients[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: _getStatusColor(patient.status),
            ),
            title: Text(patient.name),
            subtitle: Text(patient.condition),
            trailing: Text(patient.status, style: TextStyle(color: _getStatusColor(patient.status))),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Critical':
        return Colors.red;
      case 'Warning':
        return Colors.orange;
      case 'Stable':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
