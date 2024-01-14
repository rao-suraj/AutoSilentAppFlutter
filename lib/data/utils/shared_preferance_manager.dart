import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferanceManager {
  Future<void> setProfileConfiguration(
      {required int id,
      required double volumeLevel,
      required double ringerLevel});
  List<String>? getProfileConfiguration({required int id});
}

@LazySingleton(as: SharedPreferanceManager)
class SharedPreferenceManagerImp extends SharedPreferanceManager {
  final SharedPreferences _sharedPreference;
  SharedPreferenceManagerImp(this._sharedPreference);

  @override
  Future<void> setProfileConfiguration(
      {required int id,
      required double volumeLevel,
      required double ringerLevel}) async {
    await _sharedPreference.setStringList(
        id.toString(), [volumeLevel.toString(), ringerLevel.toString()]);
  }

  @override
  List<String>? getProfileConfiguration({required int id}) {
    return _sharedPreference.getStringList(id.toString());
  }
}
