import 'package:auto_silent_app/data/data_source/local_data_source/profile_local_data_source.dart';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/services/profile_services.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDataSource _profileLocalDataSource;
  final ProfileService _profileService;

  ProfileRepositoryImpl(this._profileLocalDataSource, this._profileService);
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
  @override
  Future<List<Profile>> getAllActiveProfiles() {
    return _profileLocalDataSource.getAllActiveProfiles();
  }

  @override
  Future<void> removeProfile({required Profile profile}) async {
    await _profileService.setProfile(profile: profile);
  }

  @override
  Future<void> setProfile({required Profile profile}) async {
    await _profileService.removeProfile(profile: profile);
  }

  @override
  Future<List<double?>> getCurrentVolumes() async{
    return await _profileService.getCurrentVolume();
  }
}
