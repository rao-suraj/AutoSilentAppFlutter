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

  Calendar copyWith({
    int? id,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? dateTime,
    bool? isActive,
  }) {
    return Calendar(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      dateTime: dateTime ?? this.dateTime,
      isActive: isActive ?? this.isActive,
    );
  }
}
