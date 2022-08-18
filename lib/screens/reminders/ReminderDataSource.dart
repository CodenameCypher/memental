import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReminderDataSource extends CalendarDataSource {
  ReminderDataSource(List<Appointment> source){
    appointments = source;
  }
}