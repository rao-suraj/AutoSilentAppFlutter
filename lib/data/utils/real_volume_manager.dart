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
    try {
      return await RealVolume.getCurrentVol(streamType);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setRingerMode({required RingerMode ringerMode}) async {
    try {
      await RealVolume.setRingerMode(ringerMode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setVolume(
      {required double volumeLevel, required StreamType streamType}) async {
    try {
      await RealVolume.setVolume(volumeLevel, streamType: streamType);
    } catch (e) {
      rethrow;
    }
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
