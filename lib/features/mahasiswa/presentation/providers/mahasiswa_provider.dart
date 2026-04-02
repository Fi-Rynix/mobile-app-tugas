import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:first_proj/core/network/dio_client.dart';
import 'package:first_proj/core/services/local_storage_service.dart';
import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:first_proj/features/mahasiswa/data/repositories/mahasiswa_repository.dart';
import 'package:first_proj/features/mahasiswa/data/models/comment_model.dart';
import 'package:first_proj/features/mahasiswa/data/repositories/comment_repository.dart';


// Repository Provider untuk comment dengan DioClient injection
final mahasiswaCommentRepositoryProvider = Provider<MahasiswaCommentRepository>((ref) {
  final dioClient = DioClient();
  return MahasiswaCommentRepository(dioClient);
});

// LocalStorageService Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// — Provider semua comment yang disimpan —
final savedCommentsProvider = FutureProvider<List<Map<String, String>>>((
  ref,
) async {
  final storage = ref.watch(localStorageServiceProvider);
  return storage.getSavedComments();
});

// Notifier untuk mengelola state komentar mahasiswa
class MahasiswaCommentNotifier extends StateNotifier<AsyncValue<List<MahasiswaCommentModel>>> {
  final MahasiswaCommentRepository _repository;
  final LocalStorageService _storage;

  MahasiswaCommentNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadCommentsList();
  }

  Future<void> loadCommentsList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getCommentsList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadCommentsList();
  }

  /// Simpan comment yang dipilih ke local storage
  Future<void> saveSelectedComment(MahasiswaCommentModel comment) async {
    await _storage.addCommentToSavedList(
      userId: comment.id.toString(),
      username: comment.name,
    );
  }

  /// Hapus comment tertentu dari list
  Future<void> removeSavedComment(String commentId) async {
    await _storage.removeCommentFromSavedList(commentId);
  }

  /// Hapus semua comment dari list
  Future<void> clearSavedComments() async {
    await _storage.clearSavedComments();
  }
}

// StateNotifier provider untuk komentar mahasiswa
final mahasiswaCommentNotifierProvider =
    StateNotifierProvider.autoDispose<MahasiswaCommentNotifier, AsyncValue<List<MahasiswaCommentModel>>>(
      (ref) {
        final repository = ref.watch(mahasiswaCommentRepositoryProvider);
        final storage = ref.watch(localStorageServiceProvider);
        return MahasiswaCommentNotifier(repository, storage);
      },
    );

// =====================
// MAHASISWA PROVIDERS
// =====================

// Repository provider
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

// Notifier untuk mengelola state mahasiswa list
class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;

  MahasiswaNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final mahasiswaList = await _repository.getMahasiswaList();
      state = AsyncValue.data(mahasiswaList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }
}

// StateNotifier provider untuk mahasiswa list
final mahasiswaNotifierProvider = StateNotifierProvider<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repository);
});
