
class Patient {
  final String id;
  final String name;
  final String condition;
  final String status;
  final String machineNumber;
  final String? doctorId;
  final String? profilePhotoUrl;
  final DateTime? lastUpdate;

  Patient({
    required this.id,
    required this.name,
    required this.condition,
    required this.status,
    required this.machineNumber,
    this.doctorId,
    this.profilePhotoUrl,
    this.lastUpdate,
  });
}
