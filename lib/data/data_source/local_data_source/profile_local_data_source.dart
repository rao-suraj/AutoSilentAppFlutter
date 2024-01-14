import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileLocalDataSource {
  Future<void> insertProfile({required Profile profile});

  Future<void> updateProfile({required Profile profile});

  Future<void> deleteProfile({required Profile profile});

  Stream<List<Profile>> getAllProfilesStream();

  Future<List<Profile>> getAllActiveProfiles();
}

@LazySingleton(as: ProfileLocalDataSource)
class ProflieLocalDataSourceImpl extends ProfileLocalDataSource {
  final AppDatabase _database;

  ProflieLocalDataSourceImpl(this._database);
  @override
  Future<void> deleteProfile({required Profile profile}) async {
    await _database.profileDao.deleteProfile(profile);
  }

  @override
  Stream<List<Profile>> getAllProfilesStream() {
    return _database.profileDao.getAllProfileStream();
  }

  @override
  Future<void> insertProfile({required Profile profile}) async {
    await _database.profileDao.insertProfile(profile);
  }

  @override
  Future<void> updateProfile({required Profile profile}) async {
    await _database.profileDao.updateProfile(profile);
  }
  
  @override
  Future<List<Profile>> getAllActiveProfiles() async {
    return await _database.profileDao.getAllActiveProfiles();
  }
}
