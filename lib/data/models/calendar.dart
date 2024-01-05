import 'package:floor/floor.dart';

@entity
class Calendar {
  @primaryKey
  final int id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime dateTime;
  final bool isActive;

  Calendar(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.dateTime,
      this.isActive = false});
}
