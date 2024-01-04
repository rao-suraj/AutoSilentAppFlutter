import 'package:auto_silent_app/data/data_source/local_data_source/profile_local_data_source.dart';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDataSource _profileLocalDataSource;

  ProfileRepositoryImpl(this._profileLocalDataSource);
  @override
  Future<void> deleteProfile({required Profile profile}) async {
    await _profileLocalDataSource.deleteProfile(profile: profile);
  }

  @override
  Stream<List<Profile>> getAllProfilesStream() {
    return _profileLocalDataSource.getAllProfilesStream();
  }

  @override
  Future<void> insertProfile({required Profile profile}) async {
    await _profileLocalDataSource.insertProfile(profile: profile);
  }

  @override
  Future<void> updateProfile({required Profile profile}) async {
    await _profileLocalDataSource.updateProfile(profile: profile);
  }
}
