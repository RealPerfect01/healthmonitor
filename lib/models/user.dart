class User {
  final String id;
  final String email;
  String password;
  final String role; // 'admin' or 'doctor'

  User({required this.id, required this.email, required this.password, required this.role});
}
