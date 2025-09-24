import 'package:myapp/models/doctor.dart';
import 'package:myapp/models/patient.dart';
import 'package:myapp/models/user.dart';

class DataStore {
  static final DataStore _instance = DataStore._internal();
  factory DataStore() => _instance;
  DataStore._internal();

  final List<User> _users = [
    User(id: 'admin', email: 'admin@gmail.com', password: 'password', role: 'admin'),
    Doctor(id: 'doctor1', email: 'sunday@gmail.com', password: 'password', name: 'Dr. Sunday', specialization: 'Cardiology'),
  ];

  final List<Patient> _patients = [
    Patient(id: 'patient1', name: 'John Doe', condition: 'Fever', status: 'Stable', machineNumber: '12345', doctorId: 'doctor1', lastUpdate: DateTime.now().subtract(const Duration(minutes: 10))),
    Patient(id: 'patient2', name: 'Jane Smith', condition: 'Heart Condition', status: 'Critical', machineNumber: '67890', doctorId: 'doctor1', lastUpdate: DateTime.now().subtract(const Duration(minutes: 5))),
  ];

  final List<Doctor> _doctors = [
    Doctor(id: 'doctor1', email: 'sunday@gmail.com', password: 'password', name: 'Dr. Sunday', specialization: 'Cardiology'),
  ];

  List<User> get users => _users;
  List<Patient> get patients => _patients;
  List<Doctor> get doctors => _doctors;

  void addUser(User user) {
    _users.add(user);
  }

  void addPatient(Patient patient) {
    _patients.add(patient);
  }

  void addDoctor(Doctor doctor) {
    _doctors.add(doctor);
    _users.add(doctor);
  }

  User? getUserByEmail(String email) {
    for (var user in _users) {
      if (user.email == email) {
        return user;
      }
    }
    return null;
  }

  void updateUserPassword(String email, String newPassword) {
    final user = getUserByEmail(email);
    if (user != null) {
      user.password = newPassword;
    }
  }
}
