class Appointment{
  String uid = '';
  String puid;
  String duid;
  DateTime dateTime;
  String prescription;
  bool approval;
  String disease;
  bool done;

  Appointment({
    required this.puid,
    required this.duid,
    required this.dateTime,
    required this.prescription,
    required this.approval,
    required this.disease,
    required this.done,
  });
}