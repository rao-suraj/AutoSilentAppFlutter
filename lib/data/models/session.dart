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

  Session copyWith(
      {int? id,
      String? title,
      DateTime? startTime,
      DateTime? endTime,
      bool? isActive,
      bool? sunday,
      bool? monday,
      bool? tuesday,
      bool? wednesday,
      bool? thursday,
      bool? friday,
      bool? saturday}) {
    return Session(
        id: id ?? this.id,
        title: title ?? this.title,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isActive: isActive ?? this.isActive,
        sunday: sunday ?? this.sunday,
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday);
  }
}
