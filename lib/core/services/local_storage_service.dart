import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _savedDosenKey = 'saved_dosen';
  static const String _savedCommentsKey = 'saved_comments';

  // — Token

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // — User

  Future<void> saveUser({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_usernameKey, username);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // — simpan dosen di list
  // (Tambah dosen ke list (tidak menghapus yang lama)
  Future<void> addDosenToSavedList({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedDosenKey) ?? [];

    // Cek duplikasi userId
    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    if (isDuplicate) return; // Jika sudah ada, lewati

    final newDosen = jsonEncode({
      'user_id': userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });
    rawList.add(newDosen);
    await prefs.setStringList(_savedDosenKey, rawList);
  }

  /// Ambil semua dosen yang sudah disimpan
  Future<List<Map<String, String>>> getSavedDosen() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedDosenKey) ?? [];

    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return {
        'user_id': (map['user_id'] ?? '').toString(),
        'username': (map['username'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
      };
    }).toList();
  }

  /// delete dosen tertentu dari list
  Future<void> removeDosenFromSavedList(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedDosenKey) ?? [];

    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    await prefs.setStringList(_savedDosenKey, rawList);
  }

  /// delete semua dosen dari list
  Future<void> clearSavedDosen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedDosenKey);
  }

  // — simpan comment di list
  // (Tambah comment ke list (tidak menghapus yang lama)
  Future<void> addCommentToSavedList({
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedCommentsKey) ?? [];

    // Cek duplikasi userId
    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    if (isDuplicate) return; // Jika sudah ada, lewati

    final newComment = jsonEncode({
      'user_id': userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });
    rawList.add(newComment);
    await prefs.setStringList(_savedCommentsKey, rawList);
  }

  /// Ambil semua comment yang sudah disimpan
  Future<List<Map<String, String>>> getSavedComments() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedCommentsKey) ?? [];

    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return {
        'user_id': (map['user_id'] ?? '').toString(),
        'username': (map['username'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
      };
    }).toList();
  }

  /// delete comment tertentu dari list
  Future<void> removeCommentFromSavedList(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_savedCommentsKey) ?? [];

    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'] == userId;
    });

    await prefs.setStringList(_savedCommentsKey, rawList);
  }

  /// delete semua comment dari list
  Future<void> clearSavedComments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedCommentsKey);
  }

  // — Clear All preferences
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
