import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/features/dosen/data/models/dosen_model.dart';
import 'package:first_proj/features/dosen/data/repositories/dosen_repository.dart';

// Repository provider
final dosenRepositoryProvider = Provider((ref) {
  return DosenRepository();
});

// Notifier untuk mengelola state dosen list
class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository repository;

  DosenNotifier(this.repository) : super(const AsyncValue.loading()) {
    _loadDosen();
  }

  Future<void> _loadDosen() async {
    try {
      state = const AsyncValue.loading();
      final dosenList = await repository.getDosenList();
      state = AsyncValue.data(dosenList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadDosen();
  }
}

// StateNotifier provider untuk dosen list
final dosenNotifierProvider = StateNotifierProvider<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  return DosenNotifier(repository);
});
