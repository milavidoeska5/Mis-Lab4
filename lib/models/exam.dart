class Exam {
  final String subject;
  final DateTime dateTime;
  final String location;
  final double? latitude;
  final double? longitude;

  Exam({required this.subject, required this.dateTime, required this.location,
    this.latitude, this.longitude,});
}
