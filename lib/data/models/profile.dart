import 'package:floor/floor.dart';

@entity
class Profile {
  @primaryKey
  final int id;
  final String title;
  final bool isActive;
  final int? volumeLevel;
  final int? ringerLevel;
  final bool? isNetActive;
  final bool? isDNDActive;

  Profile(
      {required this.id,
      required this.title,
      this.isActive = false,
      this.isNetActive,
      this.isDNDActive,
      this.volumeLevel,
      this.ringerLevel});
}
