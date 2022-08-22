class Reminder{
  String uid = "";
  String userUID;
  String subject;
  DateTime startTime;
  DateTime endTime;

  Reminder({
    required this.userUID,
    required this.subject,
    required this.startTime,
    required this.endTime
  });
}