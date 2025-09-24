class Patient {
  final String name;
  final String condition;
  final String status;
  final String? profilePhotoUrl;
  final DateTime? lastUpdate;

  Patient({
    required this.name,
    required this.condition,
    required this.status,
    this.profilePhotoUrl,
    this.lastUpdate,
  });
}
