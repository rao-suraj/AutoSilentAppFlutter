import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:either_dart/either.dart';

abstract class ProfileRepository {
  Future<Either<AppError, void>> insertProfile({required Profile profile});

  Future<Either<AppError, void>> updateProfile({required Profile profile});

  Future<Either<AppError, void>> deleteProfile({required Profile profile});

  Stream<List<Profile>> getAllProfilesStream();

  Future<Either<AppError,List<double?>>> getCurrentVolumes();
  
  Future<List<Profile>> getAllActiveProfiles();

  Future<Either<AppError,void>> setProfile({required Profile profile});

  Future<Either<AppError,void>> removeProfile({required Profile profile});


}
