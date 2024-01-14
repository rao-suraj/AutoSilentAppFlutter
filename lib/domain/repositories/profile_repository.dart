import 'package:auto_silent_app/data/models/profile.dart';

abstract class ProfileRepository {
  Future<void> insertProfile({required Profile profile});

  Future<void> updateProfile({required Profile profile});

  Future<void> deleteProfile({required Profile profile});

  Stream<List<Profile>> getAllProfilesStream();

  Future<void> setProfile({required Profile profile});

  Future<void> removeProfile({required Profile profile});

  Future<List<Profile>> getAllActiveProfiles();
}
