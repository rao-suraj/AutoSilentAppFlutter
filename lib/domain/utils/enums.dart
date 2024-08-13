enum DayOfTheWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursdays,
  friday,
  saturday;

  @override
  String toString() {
    switch (this) {
      case DayOfTheWeek.sunday:
        return 'sunday';
      case DayOfTheWeek.monday:
        return 'monday';
      case DayOfTheWeek.tuesday:
        return 'tuesday';
      case DayOfTheWeek.wednesday:
        return 'wednesday';
      case DayOfTheWeek.thursdays:
        return 'thusdays';
      case DayOfTheWeek.friday:
        return 'friday';
      case DayOfTheWeek.saturday:
        return 'saterday';
    }
  }

  static DayOfTheWeek getDay() {
    switch (DateTime.now().weekday) {
      case 1:
        return DayOfTheWeek.monday;
      case 2:
        return DayOfTheWeek.tuesday;
      case 3:
        return DayOfTheWeek.wednesday;
      case 4:
        return DayOfTheWeek.thursdays;
      case 5:
        return DayOfTheWeek.friday;
      case 6:
        return DayOfTheWeek.saturday;
      case 7:
        return DayOfTheWeek.sunday;
      default:
        throw Exception('invalid day');
    }
  }
}

enum ErrorType { permissionNotGranted, unknown,database }

enum PermissionType {
  dndPermission,alarmPermission
}
