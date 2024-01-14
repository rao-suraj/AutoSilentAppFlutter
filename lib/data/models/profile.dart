import 'package:floor/floor.dart';

@entity
class Profile {
  @primaryKey
  final int id;
  final String title;
  final bool isActive;
  final double volumeLevel;
  final double ringerLevel;
  final bool isVibrationActive;
  final bool isDNDActive;

  Profile(
      {required this.id,
      required this.title,
      required this.volumeLevel,
      required this.ringerLevel,
      this.isActive = false,
      this.isVibrationActive = false,
      this.isDNDActive = false,});

  Profile copyWith({
    int? id,
    String? title,
    bool? isActive,
    double? volumeLevel,
    double? ringerLevel,
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
