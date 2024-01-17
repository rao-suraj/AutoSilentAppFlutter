import 'dart:math';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepository _profileRepository;
  ProfileCubit(this._profileRepository) : super(const ProfileLoading());

  void getProfileStream() {
    emit(ProfileLoaded(_profileRepository.getAllProfilesStream()));
  }

  Future<void> insertProfile(
      {required String title,
      required double volumeLevel,
      required double ringerLevel,
      required bool isDNDActive,
      required bool isVibrationActive}) async {
    await _profileRepository.insertProfile(
        profile: Profile(
            id: Random().nextInt(500),
            title: title,
            volumeLevel: volumeLevel,
            ringerLevel: ringerLevel,
            isDNDActive: isDNDActive,
            isVibrationActive: isVibrationActive));
  }

  Future<void> updateProfile({required Profile profile}) async {
    await _profileRepository.updateProfile(profile: profile);
  }

  Future<List<double?>> getCurrentVolumeLevels() async {
    return await _profileRepository.getCurrentVolumes();
  }

  Future<void> switchIsActive({required Profile profile}) async {
    final list = await getAllActiveProfiles();
    // if any other profile is active and its not the one that you are trying to switch return immediately
    if (list.isNotEmpty && list[0].id != profile.id) {
      emit(const ProfileError('A Profile is already active'));
      getProfileStream(); // putting it to profile loaded state again
      return;
    }

    // get the present state
    final bool change;
    (profile.isActive) ? change = false : change = true;

    // update the profile in database so that the change is displayed
    await _profileRepository.updateProfile(
        profile: profile.copyWith(isActive: change));

    // set or remove the profile based on the value of change
    if (change) {
      await setProfile(profile: profile);
    } else {
      await removeProfile(profile: profile);
    }
  }

  Future<void> setProfile({required Profile profile}) async {
    await _profileRepository.setProfile(profile: profile);
  }

  Future<void> removeProfile({required Profile profile}) async {
    await _profileRepository.removeProfile(profile: profile);
  }

  Future<List<Profile>> getAllActiveProfiles() async {
    return await _profileRepository.getAllActiveProfiles();
  }
}
