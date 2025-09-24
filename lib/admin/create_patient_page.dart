
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/doctor.dart';
import 'package:myapp/models/patient.dart';
import 'package:myapp/services/data_store.dart';
import 'package:myapp/theme_provider.dart';

class CreatePatientPage extends StatefulWidget {
  const CreatePatientPage({super.key});

  @override
  State<CreatePatientPage> createState() => _CreatePatientPageState();
}

class _CreatePatientPageState extends State<CreatePatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _conditionController = TextEditingController();
  final _machineNumberController = TextEditingController();
  String? _selectedDoctorId;

  @override
  void initState() {
    super.initState();
    _selectedDoctorId = null;
  }

  void _createPatient() {
    if (_formKey.currentState!.validate()) {
      final newPatient = Patient(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        condition: _conditionController.text,
        status: 'Stable', // Default status
        machineNumber: _machineNumberController.text,
        doctorId: _selectedDoctorId,
      );

      DataStore().addPatient(newPatient);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient created successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctors = DataStore().doctors;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Patient'),
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _conditionController,
                          decoration: const InputDecoration(
                            labelText: 'Condition',
                            prefixIcon: Icon(Icons.healing),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a condition';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _machineNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Machine Number',
                            prefixIcon: Icon(Icons.monitor_heart),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a machine number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Assign to Doctor',
                             prefixIcon: Icon(Icons.medical_services),
                          ),
                          initialValue: _selectedDoctorId,
                          items: doctors.map((Doctor doctor) {
                            return DropdownMenuItem<String>(
                              value: doctor.id,
                              child: Text(doctor.name),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDoctorId = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please assign a doctor';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _createPatient,
                          child: const Text('Create Patient'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
