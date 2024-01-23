import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/utils/real_volume_manager.dart';
import 'package:auto_silent_app/data/utils/shared_preferance_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:real_volume/real_volume.dart';

abstract class ProfileService {
  Future<void> setProfile({required Profile profile});
  Future<void> removeProfile({required Profile profile});
  Future<List<double?>> getCurrentVolume();
}

@LazySingleton(as: ProfileService)
class ProfileServicesImpl extends ProfileService {
  final SharedPreferanceManager _spManager;
  final RealVolumeManager _rvManager;
  ProfileServicesImpl(this._spManager, this._rvManager);

  @override
  Future<void> setProfile({required Profile profile}) async {
    // get the original music volume and ringer volume for the purpose of using it when the profile is removed
    double currentVolumeLevel =
        await _rvManager.getVolumeLevel(streamType: StreamType.MUSIC) ?? 0.7;
    double currentReingerLevel =
        await _rvManager.getVolumeLevel(streamType: StreamType.RING) ?? 0.7;

    // stored it in the shared preference
    await _spManager.setProfileConfiguration(
        id: profile.id,
        volumeLevel: currentVolumeLevel,
        ringerLevel: currentReingerLevel);

    if (currentVolumeLevel != profile.volumeLevel) {
      await _rvManager.setVolume(
          volumeLevel: profile.volumeLevel, streamType: StreamType.MUSIC);
    }

    if (profile.isDNDActive == true) {
      await _rvManager.setRingerMode(
          ringerMode: RingerMode.SILENT); // it puts the phone to DND mode
    } else if (profile.isVibrationActive == true) {
      await _rvManager.setRingerMode(ringerMode: RingerMode.VIBRATE);
    } else if (currentReingerLevel != profile.ringerLevel) {
      await _rvManager.setVolume(
          volumeLevel: profile.ringerLevel, streamType: StreamType.RING);
    }
  }

  @override
  Future<void> removeProfile({required Profile profile}) async {
    double originalVolumeLevel, originalReingerLevel;
    final List<String>? response =
        _spManager.getProfileConfiguration(id: profile.id);
    if (response != null) {
      originalVolumeLevel = double.parse(response[0]);
      originalReingerLevel = double.parse(response[1]);
    } else {
      // get some values to be set
      originalVolumeLevel = 0.7;
      originalReingerLevel = 0.7;
    }

    await _rvManager.setRingerMode(ringerMode: RingerMode.NORMAL);
    await _rvManager.setVolume(
        volumeLevel: originalVolumeLevel, streamType: StreamType.MUSIC);
    await _rvManager.setVolume(
        volumeLevel: originalReingerLevel, streamType: StreamType.RING);
  }
  
  @override
  Future<List<double?>> getCurrentVolume() async{
    List<double?> list = [];
    list.add(await _rvManager.getVolumeLevel(streamType: StreamType.MUSIC));
    list.add(await _rvManager.getVolumeLevel(streamType: StreamType.RING));
    return list;
  }
}
