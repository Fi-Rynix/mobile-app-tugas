import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  /// Mendapatkan daftar mahasiswa
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa
    return [
      MahasiswaModel(
        nama: 'Adi Pratama',
        nim: '2021001',
        email: 'adi.pratama@example.com',
        jurusan: 'Teknik Informatika',
        semester: '7',
        ipk: 3.85,
      ),
      MahasiswaModel(
        nama: 'Siti Nurhaliza',
        nim: '2021002',
        email: 'siti.nurhaliza@example.com',
        jurusan: 'Teknik Informatika',
        semester: '7',
        ipk: 3.92,
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '2021003',
        email: 'budi.santoso@example.com',
        jurusan: 'Teknik Informatika',
        semester: '6',
        ipk: 3.65,
      ),
      MahasiswaModel(
        nama: 'Rini Wijaya',
        nim: '2021004',
        email: 'rini.wijaya@example.com',
        jurusan: 'Teknik Informatika',
        semester: '7',
        ipk: 3.78,
      ),
      MahasiswaModel(
        nama: 'Ahmad Rizki',
        nim: '2021005',
        email: 'ahmad.rizki@example.com',
        jurusan: 'Teknik Informatika',
        semester: '5',
        ipk: 3.55,
      ),
    ];
  }
}
