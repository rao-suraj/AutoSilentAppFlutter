import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/domain/repositories/profile_repository.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepository _profileRepository;
  ProfileCubit(this._profileRepository) : super(const ProfileLoading());

  void getProfileStream()  {
    emit(ProfileLoaded(_profileRepository.getAllProfilesStream()));
  }

  Future<void> insertProfile({required Profile profile}) async {
    await _profileRepository.insertProfile(profile: profile);
  }

  Future<void> updateProfile({required Profile profile}) async {
    await _profileRepository.updateProfile(profile: profile);
  }
}
