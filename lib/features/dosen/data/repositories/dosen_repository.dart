import 'package:first_proj/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  /// Mendapatkan daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy dosen
    return [
      DosenModel(
        nama: 'Anak Prasetyo',
        nip: '123456789',
        email: 'anak.prasetyo@example.com',
        jurusan: 'Teknik Informatika',
      ),
      DosenModel(
        nama: 'Rachman Sinatriya',
        nip: '987654321',
        email: 'rachman.sinatriya@example.com',
        jurusan: 'Teknik Informatika',
      ),
      DosenModel(
        nama: 'Alfian Sukma',
        nip: '456789123',
        email: 'alfian.sukma@example.com',
        jurusan: 'Teknik Informatika',
      ),
    ];
  }
}
