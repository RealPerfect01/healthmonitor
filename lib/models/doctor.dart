
import 'package:myapp/models/user.dart';

class Doctor extends User {
  final String name;
  final String specialization;

  Doctor({
    required super.id,
    required super.email,
    required super.password,
    required this.name,
    required this.specialization,
  }) : super(role: 'doctor');
}
