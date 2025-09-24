
import 'package:flutter/material.dart';
import 'package:myapp/login_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/doctor_profile_page.dart';
import 'package:myapp/patient_detail_page.dart';
import 'package:myapp/models/patient.dart';
import 'package:myapp/services/data_store.dart';
import 'package:myapp/theme_provider.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  final List<Patient> _allPatients = [
    Patient(id: '1', name: 'John Doe', condition: 'Fever', status: 'Stable', machineNumber: '101', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 10))),
    Patient(id: '2', name: 'Jane Smith', condition: 'Heart Condition', status: 'Critical', machineNumber: '102', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 5))),
    Patient(id: '3', name: 'Peter Jones', condition: 'Diabetes', status: 'Stable', machineNumber: '103', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(hours: 1))),
    Patient(id: '4', name: 'Mary Johnson', condition: 'Asthma', status: 'Warning', machineNumber: '104', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 30))),
    Patient(id: '5', name: 'David Williams', condition: 'Hypertension', status: 'Stable', machineNumber: '105', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(hours: 2))),
    Patient(id: '6', name: 'Susan Brown', condition: 'Kidney Disease', status: 'Critical', machineNumber: '106', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 15))),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final doctor = DataStore().doctors.first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorProfilePage(doctor: doctor)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Logout',
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildFilterButtons(),
              const SizedBox(height: 16),
              Expanded(child: _buildPatientList()),
            ],
          ),
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
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: _selectedFilter == filter ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildPatientList() {
    return ListView.builder(
      itemCount: _filteredPatients.length,
      itemBuilder: (context, index) {
        final patient = _filteredPatients[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: patient.profilePhotoUrl != null ? AssetImage(patient.profilePhotoUrl!) : null,
            ),
            title: Text(patient.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text(
              '${patient.condition} - Last update: ${patient.lastUpdate?.toLocal()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Text(patient.status, style: TextStyle(color: _getStatusColor(patient.status))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientDetailPage(patient: patient),
                ),
              );
            },
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
        return Colors.amber;
      case 'Stable':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
