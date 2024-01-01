import 'package:floor/floor.dart';

@entity
class Session {
  @primaryKey
  final int id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final bool isActive;
  final bool sunday;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;

  Session(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.endTime,
      this.isActive = false,
      this.sunday = false,
      this.monday = false,
      this.tuesday = false,
      this.wednesday = false,
      this.thursday = false,
      this.friday = false,
      this.saturday = false});
}
