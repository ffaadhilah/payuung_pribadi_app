import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_app/models/user_model.dart';
import 'package:payuung_pribadi_app/repos/user_repository.dart';

abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final User user;

  UpdateUserProfile({required this.user});
}

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  ProfileLoaded({required this.user});
}

class ProfileUpdated extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileLoading()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  void _onLoadUserProfile(
      LoadUserProfile event, Emitter<ProfileState> emit) async {
    try {
      final user = await userRepository.getUser();

      if (user != null) {
        emit(ProfileLoaded(user: user));
      } else {
        emit(ProfileError(message: "No user found."));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  void _onUpdateUserProfile(
      UpdateUserProfile event, Emitter<ProfileState> emit) async {
    try {
      await userRepository.updateUser(event.user);
      emit(ProfileUpdated());
      add(LoadUserProfile());
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
