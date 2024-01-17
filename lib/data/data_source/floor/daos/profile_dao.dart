import 'package:auto_silent_app/data/models/profile.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProfileDao {
  @insert
  Future<void> insertProfile(Profile profile);

  @delete
  Future<void> deleteProfile(Profile profile);

  @update
  Future<void> updateProfile(Profile profile);

  @Query('SELECT * FROM Profile')
  Stream<List<Profile>> getAllProfileStream();

  @Query('SELECT * FROM Profile WHERE isActive = :isTure')
  Future<List<Profile>> getAllActiveProfiles(bool isTure);
}
