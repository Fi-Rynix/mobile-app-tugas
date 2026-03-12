import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:first_proj/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

// Repository provider
final mahasiswaAktifRepositoryProvider = Provider((ref) {
  return MahasiswaAktifRepository();
});

// Notifier untuk mengelola state mahasiswa aktif list
class MahasiswaAktifNotifier extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository repository;

  MahasiswaAktifNotifier(this.repository) : super(const AsyncValue.loading()) {
    _loadMahasiswaAktif();
  }

  Future<void> _loadMahasiswaAktif() async {
    try {
      state = const AsyncValue.loading();
      final mahasiswaAktifList = await repository.getMahasiswaAktifList();
      state = AsyncValue.data(mahasiswaAktifList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadMahasiswaAktif();
  }
}

// StateNotifier provider untuk mahasiswa aktif list
final mahasiswaAktifNotifierProvider = StateNotifierProvider<MahasiswaAktifNotifier, AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  final repository = ref.watch(mahasiswaAktifRepositoryProvider);
  return MahasiswaAktifNotifier(repository);
});
