import 'dart:io';

//mahasisqa
class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  void tampilkanData() {
    print("Nama: $nama");
    print("NIM: $nim");
    print("Jurusan: $jurusan");
  }
}

//aktif extend mahasiswa
class MahasiswaAktif extends Mahasiswa {
  int? semester;
  double? ipk;

  void tampilkanDataAktif() {
    print("--- Data Mahasiswa Aktif ---");
    tampilkanData();
    print("Semester: $semester");
    print("IPK: $ipk");
  }
}

//alumni extend mahasiswa
class MahasiswaAlumni extends Mahasiswa {
  int? tahunLulus;
  String? pekerjaanTerakhir;

  void tampilkanDataAlumni() {
    print("--- Data Mahasiswa Alumni ---");
    tampilkanData();
    print("Tahun Lulus: $tahunLulus");
    print("Pekerjaan Terakhir: $pekerjaanTerakhir");
  }
}

void main() {
  print("=== Input Data Mahasiswa Aktif ===");
  var mahasiswaAktif = MahasiswaAktif();
  
  stdout.write("Nama: ");
  mahasiswaAktif.nama = stdin.readLineSync();
  
  stdout.write("NIM: ");
  mahasiswaAktif.nim = int.tryParse(stdin.readLineSync() ?? "");
  
  stdout.write("Jurusan: ");
  mahasiswaAktif.jurusan = stdin.readLineSync();
  
  stdout.write("Semester: ");
  mahasiswaAktif.semester = int.tryParse(stdin.readLineSync() ?? "");
  
  stdout.write("IPK: ");
  mahasiswaAktif.ipk = double.tryParse(stdin.readLineSync() ?? "");
  
  print("");
  mahasiswaAktif.tampilkanDataAktif();
  
  print("\n=== Input Data Mahasiswa Alumni ===");
  var mahasiswaAlumni = MahasiswaAlumni();
  
  stdout.write("Nama: ");
  mahasiswaAlumni.nama = stdin.readLineSync();
  
  stdout.write("NIM: ");
  mahasiswaAlumni.nim = int.tryParse(stdin.readLineSync() ?? "");
  
  stdout.write("Jurusan: ");
  mahasiswaAlumni.jurusan = stdin.readLineSync();
  
  stdout.write("Tahun Lulus: ");
  mahasiswaAlumni.tahunLulus = int.tryParse(stdin.readLineSync() ?? "");
  
  stdout.write("Pekerjaan Terakhir: ");
  mahasiswaAlumni.pekerjaanTerakhir = stdin.readLineSync();
  
  print("");
  mahasiswaAlumni.tampilkanDataAlumni();
}
