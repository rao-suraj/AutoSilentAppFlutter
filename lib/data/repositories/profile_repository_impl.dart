import 'package:auto_silent_app/data/data_source/local_data_source/profile_local_data_source.dart';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/services/profile_services.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:auto_silent_app/data/utils/call_with_error.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDataSource _profileLocalDataSource;
  final ProfileService _profileService;

  ProfileRepositoryImpl(this._profileLocalDataSource, this._profileService);
  @override
  Future<Either<AppError, void>> deleteProfile(
      {required Profile profile}) async {
    return CallWithError.call(
        () => _profileLocalDataSource.deleteProfile(profile: profile));
  }

  @override
  Stream<List<Profile>> getAllProfilesStream() {
    return _profileLocalDataSource.getAllProfilesStream();
  }

  @override
  Future<Either<AppError, void>> insertProfile({required Profile profile}) async {
    return CallWithError.call(
        () => _profileLocalDataSource.insertProfile(profile: profile));
  }

  @override
  Future<Either<AppError, void>> updateProfile({required Profile profile}) async {
    return CallWithError.call(() => _profileLocalDataSource.updateProfile(profile: profile));
  }

  @override
  Future<List<Profile>> getAllActiveProfiles() {
    return _profileLocalDataSource.getAllActiveProfiles();
  }

  @override
  Future<Either<AppError, void>> removeProfile(
      {required Profile profile}) async {
    return await CallWithError.call(
        () => _profileService.removeProfile(profile: profile));
  }

  @override
  Future<Either<AppError, void>> setProfile({required Profile profile}) async {
    return await CallWithError.call(
        () => _profileService.setProfile(profile: profile));
  }

  @override
  Future<Either<AppError, List<double?>>> getCurrentVolumes() async {
    return await CallWithError.call(() => _profileService.getCurrentVolume());
  }
}
