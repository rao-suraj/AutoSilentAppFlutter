import 'package:floor/floor.dart';

@entity
class Calender {
  @primaryKey
  final int id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime dateTime;
  final bool isActive;

  Calender(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.dateTime,
      this.isActive = false});
}
