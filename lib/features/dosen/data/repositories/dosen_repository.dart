import 'dart:convert';
import 'package:first_proj/features/dosen/data/models/dosen_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class DosenRepository {
  //// Mendapatkan daftar dosen
  // Future<List<DosenModel>> getDosenList() async {
  //   final response = await http.get(
  //     Uri.parse('https://jsonplaceholder.typicode.com/users'),
  //     headers: {'Accept': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     print(data); // Debug: Tampilkan data yang sudah di-decode
  //     return data.map((json) => DosenModel.fromJson(json)).toList();
  //   } else {
  //     print('Error: ${response.statusCode} - ${response.body}');
  //     throw Exception('Gagal memuat data dosen: ${response.statusCode}');
  //   }
  // }

  Future<List<DosenModel>> getDosenList() async {
  final dio = Dio();

  try {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/users',
      options: Options(
        headers: {'Accept': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      print(data); // Debug
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.data}');
      throw Exception('Gagal memuat data dosen: ${response.statusCode}');
    }
  } catch (e) {
    print('Error Dio: $e');
    throw Exception('Terjadi kesalahan saat mengambil data');
  }
}
}
