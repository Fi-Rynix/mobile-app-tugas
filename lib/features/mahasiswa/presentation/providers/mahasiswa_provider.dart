import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:first_proj/features/mahasiswa/data/repositories/mahasiswa_repository.dart';
import 'package:first_proj/features/mahasiswa/data/models/comment_model.dart';
import 'package:first_proj/features/mahasiswa/data/repositories/comment_repository.dart';

// Repository provider untuk komentar
final mahasiswaCommentRepositoryProvider = Provider((ref) {
  return MahasiswaCommentRepository();
});

// Notifier untuk mengelola state komentar mahasiswa
class MahasiswaCommentNotifier extends StateNotifier<AsyncValue<List<MahasiswaCommentModel>>> {
  final MahasiswaCommentRepository repository;

  MahasiswaCommentNotifier(this.repository) : super(const AsyncValue.loading()) {
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      state = const AsyncValue.loading();
      final commentList = await repository.getCommentsHttp();
      state = AsyncValue.data(commentList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadComments();
  }
}

// StateNotifier provider untuk komentar mahasiswa
final mahasiswaCommentNotifierProvider = StateNotifierProvider<MahasiswaCommentNotifier, AsyncValue<List<MahasiswaCommentModel>>>((ref) {
  final repository = ref.watch(mahasiswaCommentRepositoryProvider);
  return MahasiswaCommentNotifier(repository);
});




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
