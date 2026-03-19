import 'dart:convert';
import 'package:first_proj/features/mahasiswa_aktif/data/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class PostRepository {
  /// Mengambil posts menggunakan http
  Future<List<PostModel>> getPostsHttp() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat posts: ${response.statusCode}');
    }
  }

  /// Mengambil posts menggunakan dio
  Future<List<PostModel>> getPostsDio() async {
    final dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat posts: ${response.statusCode}');
    }
  }
}
