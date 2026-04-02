import 'package:dio/dio.dart';
import 'package:first_proj/core/network/dio_client.dart';
import 'package:first_proj/features/mahasiswa/data/models/comment_model.dart';

class MahasiswaCommentRepository {
  final DioClient _dioClient;

  MahasiswaCommentRepository(DioClient dioClient)
      : _dioClient = dioClient ?? DioClient();

  /// Get data daftar komentar
  Future<List<MahasiswaCommentModel>> getCommentsList() async {
    try {
      final response = await _dioClient.dio.get('/comments');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaCommentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal memuat komentar: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}
