import 'package:floor/floor.dart';

@entity
class Calander {
  @primaryKey
  final int id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime dateTime;
  final bool isActive;

  Calander(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.dateTime,
      this.isActive = false});
}
