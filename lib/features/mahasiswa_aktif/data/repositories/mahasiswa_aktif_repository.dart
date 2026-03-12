import 'package:first_proj/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  /// Mendapatkan daftar mahasiswa aktif
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa aktif
    return [
      MahasiswaAktifModel(
        nama: 'Adi Pratama',
        nim: '2021001',
        email: 'adi.pratama@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2021',
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Siti Nurhaliza',
        nim: '2021002',
        email: 'siti.nurhaliza@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2021',
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Rini Wijaya',
        nim: '2021004',
        email: 'rini.wijaya@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2021',
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Hendra Kusuma',
        nim: '2022001',
        email: 'hendra.kusuma@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2022',
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Desi Ratnasari',
        nim: '2022002',
        email: 'desi.ratnasari@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2022',
        statusAkademik: 'Aktif',
      ),
    ];
  }
}
