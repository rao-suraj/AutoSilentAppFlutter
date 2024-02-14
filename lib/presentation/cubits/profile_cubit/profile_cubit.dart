import 'dart:math';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
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
    final response = await _profileRepository.insertProfile(
        profile: Profile(
            id: Random().nextInt(500),
            title: title,
            volumeLevel: volumeLevel,
            ringerLevel: ringerLevel,
            isDNDActive: isDNDActive,
            isVibrationActive: isVibrationActive));

    response.fold((left) => emit(ProfileError(left.message!)),
        (right) => emit(const ProfileSuccess("Inserted Successfully")));
    getProfileStream();
  }

  Future<void> updateProfile({required Profile profile}) async {
    final response = _profileRepository.updateProfile(profile: profile);

    response.fold((left) {
      emit(ProfileError(left.message!));
    }, (right) => emit(const ProfileSuccess("Updated Successfully")));
    getProfileStream();
  }

  Future<List<double?>> getCurrentVolumeLevels() async {
    final respons = await _profileRepository.getCurrentVolumes();
    late List<double?> volumeLevel;
    respons.fold((left) => emit(ProfileError(left.message!)), (right) {
      volumeLevel = right;
    });
    return volumeLevel;
  }

  Future<void> switchIsActive({required Profile profile}) async {
    final currentVal = profile.isActive;

    // if we have to make it active i.e currently it is false then check if more the one profile is active
    // if yes then return with a message
    // else continue
    if (!currentVal) {
      final activeList = await _profileRepository.getAllActiveProfiles();
      // I don't know why when there is one active the length is 0
      if (activeList.isNotEmpty) {
        emit(const ProfileError("Can't have more than one active profile"));
        getProfileStream();
        return;
      }
    }

    // activate based on the current value
    if (currentVal) {
      await removeProfile(profile: profile);
    } else {
      await setProfile(profile: profile);
    }

    // change the value in database
    final response = _profileRepository.updateProfile(
        profile: profile.copyWith(isActive: !currentVal));
    response.fold((left) {
      ProfileError(left.message!);
      getProfileStream();
    }, (right) => null);
  }

  Future<void> setProfile({required Profile profile}) async {
    final response = await _profileRepository.setProfile(profile: profile);

    response.fold((left) {
      emit(ProfileError(left.message!));
      getProfileStream();
    }, (right) => null);
  }

  Future<void> removeProfile({required Profile profile}) async {
    final response = await _profileRepository.removeProfile(profile: profile);

    response.fold((left) {
      emit(ProfileError(left.message!));
      getProfileStream();
    }, (right) => null);
  }

  Future<List<Profile>> getAllActiveProfiles() async {
    return await _profileRepository.getAllActiveProfiles();
  }

  void deleteProfile({required Profile profile}) async {
    final response = await _profileRepository.deleteProfile(profile: profile);
    response.fold((left) {
      emit(ProfileError(left.message!));
      getProfileStream();
    }, (right) => null);
  }
}
