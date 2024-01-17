import 'dart:math';
import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_volume/real_volume.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepository _profileRepository;
  ProfileCubit(this._profileRepository) : super(const ProfileLoading());

  void getProfileStream() {
    emit(ProfileLoaded(_profileRepository.getAllProfilesStream()));
  }

  Future<void> insertProfile(
      {required String title,
      required int volumeLevel,
      required int ringerLevel,
      bool? isDNDActive,
      bool? isVibrationActive}) async {
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

  Future<void> switchIsActive({required Profile profile}) async {
    final bool change;
    (profile.isActive) ? change = false : change = true;
    await _profileRepository.updateProfile(
        profile: profile.copyWith(isActive: change));
  }

  Future<List<double?>> getCurrentVolumeLevels() async {
    List<double?> list = [];
    list.add(await RealVolume.getCurrentVol(StreamType.MUSIC));
    list.add(await RealVolume.getCurrentVol(StreamType.RING));
    return list;
  }
}
