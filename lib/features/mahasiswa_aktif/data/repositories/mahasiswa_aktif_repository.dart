import 'package:first_proj/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  /// Mendapatkan daftar mahasiswa aktif
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa aktif
    return [
      MahasiswaAktifModel(
        nama: 'Udin Aralan Linux',
        nim: '434241083',
        email: 'udin.aralan@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2018',
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Viki Femboy Arifian',
        nim: '434241038',
        email: 'viki.femboy@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2019',
        statusAkademik: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Rafi Fedo Fernandito',
        nim: '434241117',
        email: 'rafi.fernando@example.com',
        jurusan: 'Teknik Informatika',
        tahunMasuk: '2021',
        statusAkademik: 'Aktif',
      ),
    ];
  }
}
