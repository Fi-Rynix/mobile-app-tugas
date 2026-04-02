import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:first_proj/core/network/dio_client.dart';
import 'package:first_proj/core/services/local_storage_service.dart';
import 'package:first_proj/features/dosen/data/models/dosen_model.dart';
import 'package:first_proj/features/dosen/data/repositories/dosen_repository.dart';

// Repository Provider
final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  final dioClient = DioClient();
  return DosenRepository(dioClient);
});

// LocalStorageService Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// — Provider semua dosen yang disimpan —
final savedDosenProvider = FutureProvider<List<Map<String, String>>>((
  ref,
) async {
  final storage = ref.watch(localStorageServiceProvider);
  return storage.getSavedDosen();
});

// Provider untuk membaca saved user dari local storage
final savedUserProvider = FutureProvider<Map<String, String?>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  final userId = await storage.getUserId();
  final username = await storage.getUsername();
  final token = await storage.getToken();
  return {'userId': userId, 'username': username, 'token': token};
});

// StateNotifier untuk mengelola state dosen
class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;
  final LocalStorageService _storage;

  DosenNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadDosenList();
  }

  /// Simpan dosen yang dipilih ke local storage (tanpa menghapus yang lama)
  Future<void> saveSelectedDosen(DosenModel dosen) async {
    await _storage.addDosenToSavedList(
      userId: dosen.id.toString(),
      username: dosen.username,
    );
  }

  /// Hapus dosen tertentu dari list
  Future<void> removeSavedDosen(String userId) async {
    await _storage.removeDosenFromSavedList(userId);
  }

  /// Hapus semua dosen dari list
  Future<void> clearSavedDosen() async {
    await _storage.clearSavedDosen();
  }
}

// StateNotifier provider untuk dosen list
final dosenNotifierProvider =
    StateNotifierProvider.autoDispose<DosenNotifier, AsyncValue<List<DosenModel>>>(
      (ref) {
        final repository = ref.watch(dosenRepositoryProvider);
        final storage = ref.watch(localStorageServiceProvider);
        return DosenNotifier(repository, storage);
      },
    );
