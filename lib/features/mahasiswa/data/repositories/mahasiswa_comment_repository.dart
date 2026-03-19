import 'dart:convert';
import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MahasiswaCommentRepository {
  /// Mengambil komentar menggunakan http
  Future<List<MahasiswaCommentModel>> getCommentsHttp() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MahasiswaCommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat komentar: ${response.statusCode}');
    }
  }

  // Mengambil komentar menggunakan dio
  Future<List<MahasiswaCommentModel>> getCommentsDio() async {
    final dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/comments');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaCommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat komentar: ${response.statusCode}');
    }
  }
}
