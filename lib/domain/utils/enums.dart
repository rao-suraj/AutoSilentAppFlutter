enum DayOfTheWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thusdays,
  friday,
  saterday;

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
      case DayOfTheWeek.thusdays:
        return 'thusdays';
      case DayOfTheWeek.friday:
        return 'friday';
      case DayOfTheWeek.saterday:
        return 'saterday';
    }
  }
}


