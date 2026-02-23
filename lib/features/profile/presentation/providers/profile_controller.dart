import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileState {
  final Map<String, dynamic>? profile;
  final bool isLoading;
  final String? errorMessage;

  ProfileState({this.profile, this.isLoading = false, this.errorMessage});

  ProfileState copyWith({
    Map<String, dynamic>? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ProfileController extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileController(this._repository) : super(ProfileState()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await _repository.getProfile();
      state = state.copyWith(profile: profile, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> updateProfile(
    Map<String, dynamic> data, {
    File? imageFile,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateProfile(data, imageFile: imageFile);
      // Reload profile after update
      await loadProfile();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, ProfileState>((ref) {
      return ProfileController(ServiceLocator.instance.profileRepository);
    });
