import 'package:floor/floor.dart';

@entity
class Profile {
  @primaryKey
  final int id;
  final String title;
  final bool isActive;
  final int? volumeLevel;
  final int? ringerLevel;
  final bool? isVibrationActive;
  final bool? isDNDActive;

  Profile(
      {required this.id,
      required this.title,
      this.isActive = false,
      this.isVibrationActive = false,
      this.isDNDActive = false,
      this.volumeLevel,
      this.ringerLevel});

  Profile copyWith({
    int? id,
    String? title,
    bool? isActive,
    int? volumeLevel,
    int? ringerLevel,
    bool? isVibrationActive,
    bool? isDNDActive,
  }) {
    return Profile(
      id: id ?? this.id,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      isVibrationActive: isVibrationActive ?? this.isVibrationActive,
      isDNDActive: isDNDActive ?? this.isDNDActive,
      volumeLevel: volumeLevel ?? this.volumeLevel,
      ringerLevel: ringerLevel ?? this.ringerLevel,
    );
  }
}
