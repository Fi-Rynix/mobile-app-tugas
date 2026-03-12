import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  /// Mendapatkan daftar mahasiswa
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa
    return [
      MahasiswaModel(
        nama: 'Udin Aralan Linux',
        nim: '434241083',
        email: 'udin.aralan@example.com',
        jurusan: 'Teknik Informatika',
        semester: '6',
        ipk: 3.85,
      ),
      MahasiswaModel(
        nama: 'Viki Femboy Arifian',
        nim: '434241038',
        email: 'viki.femboy@example.com',
        jurusan: 'Teknik Informatika',
        semester: '7',
        ipk: 3.92,
      ),
      MahasiswaModel(
        nama: 'Rafi Fedo Fernandito',
        nim: '434241117',
        email: 'rafi.fernando@example.com',
        jurusan: 'Teknik Informatika',
        semester: '4',
        ipk: 3.65,
      ),
      MahasiswaModel(
        nama: 'Rizkimok Ibrahimok',
        nim: '434241085',
        email: 'rizki.ibrahimok@example.com',
        jurusan: 'Teknik Informatika',
        semester: '67',
        ipk: 3.78,
      ),
      MahasiswaModel(
        nama: 'Vitosuki Adityamok',
        nim: '434241086',
        email: 'vitosuki.aditya@example.com',
        jurusan: 'Teknik Informatika',
        semester: '67',
        ipk: 3.55,
      ),
    ];
  }
}
