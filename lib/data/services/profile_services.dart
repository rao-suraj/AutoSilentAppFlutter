import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/utils/shared_preferance_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:real_volume/real_volume.dart';

abstract class ProfileService {
  Future<void> setProfile({required Profile profile});
  Future<void> removeProfile({required Profile profile});
}

@LazySingleton(as: ProfileService)
class ProfileServicesImpl extends ProfileService {
  final SharedPreferanceManager _spManager;
  ProfileServicesImpl(this._spManager);

  @override
  Future<void> removeProfile({required Profile profile}) async {
    // get the original music volume and ringer volume for the purpose of using it when the profile is removed
    double currentVolumeLevel =
        await RealVolume.getCurrentVol(StreamType.MUSIC) ?? 0.7;
    double currentReingerLevel =
        await RealVolume.getCurrentVol(StreamType.RING) ?? 0.7;

    // stored it in the shared preference
    await _spManager.setProfileConfiguration(
        id: profile.id,
        volumeLevel: currentVolumeLevel,
        ringerLevel: currentReingerLevel);

    await RealVolume.setVolume(profile.volumeLevel,
        streamType: StreamType.MUSIC);

    if (profile.isDNDActive == true) {
      RealVolume.setRingerMode(
          RingerMode.SILENT); // it puts the phone to DND mode
    } else if (profile.isVibrationActive == true) {
      RealVolume.setRingerMode(RingerMode.VIBRATE);
      await RealVolume.setVolume(profile.volumeLevel,
          streamType: StreamType.MUSIC);
    } else {
      await RealVolume.setVolume(profile.ringerLevel,
          streamType: StreamType.RING);
    }
  }

  @override
  Future<void> setProfile({required Profile profile}) async {
    double originalVolumeLevel, originalReingerLevel;
    final List<String>? response =
        _spManager.getProfileConfiguration(id: profile.id);
    if (response != null) {
      originalVolumeLevel = double.parse(response[0]);
      originalReingerLevel = double.parse(response[1]);
    } else {
      originalVolumeLevel = 0.7;
      originalReingerLevel = 0.7;
    }

    await RealVolume.setRingerMode(RingerMode.NORMAL);
    await RealVolume.setVolume(originalVolumeLevel,
        streamType: StreamType.MUSIC);
    await RealVolume.setVolume(originalReingerLevel,
        streamType: StreamType.RING);
  }
}
