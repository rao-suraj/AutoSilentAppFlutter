import 'package:injectable/injectable.dart';
import 'package:real_volume/real_volume.dart';

abstract class RealVolumeManager {
  Future<void> setVolume(
      {required double volumeLevel, required StreamType streamType});
  Future<double?> getVolumeLevel({required StreamType streamType});
  Future<void> setRingerMode({required RingerMode ringerMode});
}

@LazySingleton(as: RealVolumeManager)
class RealVolumeManagerImpl extends RealVolumeManager {
  RealVolumeManagerImpl();
  @override
  Future<double?> getVolumeLevel({required StreamType streamType}) async {
    return await RealVolume.getCurrentVol(streamType);
  }

  @override
  Future<void> setRingerMode({required RingerMode ringerMode}) async {
    await RealVolume.setRingerMode(ringerMode);
  }

  @override
  Future<void> setVolume(
      {required double volumeLevel, required StreamType streamType}) async {
    await RealVolume.setVolume(volumeLevel, streamType: streamType);
  }

  // @pragma('vm:entry-point')
  // static Future<void> setSilentModeFunc() async {
  //   await RealVolume.setRingerMode(RingerMode.SILENT);
  // }

  // @pragma('vm:entry-point')
  // static Future<void> setNormalModeFunc() async {
  //   await RealVolume.setRingerMode(RingerMode.NORMAL);
  // }
}
