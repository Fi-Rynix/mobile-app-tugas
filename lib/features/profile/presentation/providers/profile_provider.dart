import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/features/profile/data/models/profile_model.dart';
import 'package:first_proj/features/profile/data/repositories/profile_repository.dart';

// Repository provider
final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository();
});

// Notifier untuk mengelola state profile
class ProfileNotifier extends StateNotifier<AsyncValue<ProfileModel>> {
  final ProfileRepository repository;

  ProfileNotifier(this.repository) : super(const AsyncValue.loading()) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      state = const AsyncValue.loading();
      final profile = await repository.getUserProfile();
      state = AsyncValue.data(profile);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadProfile();
  }

  Future<bool> updateProfile(ProfileModel profile) async {
    try {
      final success = await repository.updateUserProfile(profile);
      if (success) {
        state = AsyncValue.data(profile);
      }
      return success;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }
}

// StateNotifier provider untuk profile
final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<ProfileModel>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository);
});
