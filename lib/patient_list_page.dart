import 'package:flutter/material.dart';
import 'package:myapp/patient_detail_page.dart';
import 'package:myapp/models/patient.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  final List<Patient> _allPatients = [
    Patient(name: 'John Doe', condition: 'Fever', status: 'Stable', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 10))),
    Patient(name: 'Jane Smith', condition: 'Heart Condition', status: 'Critical', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 5))),
    Patient(name: 'Peter Jones', condition: 'Diabetes', status: 'Stable', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(hours: 1))),
    Patient(name: 'Mary Johnson', condition: 'Asthma', status: 'Warning', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 30))),
    Patient(name: 'David Williams', condition: 'Hypertension', status: 'Stable', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(hours: 2))),
    Patient(name: 'Susan Brown', condition: 'Kidney Disease', status: 'Critical', profilePhotoUrl: 'assets/images/logo.png', lastUpdate: DateTime.now().subtract(const Duration(minutes: 15))),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
      ),
      body: Padding(
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
            leading: CircleAvatar(
              backgroundImage: patient.profilePhotoUrl != null ? AssetImage(patient.profilePhotoUrl!) : null,
            ),
            title: Text(patient.name),
            subtitle: Text('${patient.condition} - Last update: ${patient.lastUpdate?.toLocal()}'),
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
        return Colors.orange;
      case 'Stable':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
