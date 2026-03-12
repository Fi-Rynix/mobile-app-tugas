import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:first_proj/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

// Repository provider
final mahasiswaRepositoryProvider = Provider((ref) {
  return MahasiswaRepository();
});

// Notifier untuk mengelola state mahasiswa list
class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository repository;

  MahasiswaNotifier(this.repository) : super(const AsyncValue.loading()) {
    _loadMahasiswa();
  }

  Future<void> _loadMahasiswa() async {
    try {
      state = const AsyncValue.loading();
      final mahasiswaList = await repository.getMahasiswaList();
      state = AsyncValue.data(mahasiswaList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadMahasiswa();
  }
}

// StateNotifier provider untuk mahasiswa list
final mahasiswaNotifierProvider = StateNotifierProvider<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repository);
});
