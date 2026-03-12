import 'dart:io';

class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  void tampilkanData() {
    print("Nama: ${nama ?? 'Belum diisi'}");
    print("NIM: ${nim ?? 'Belum diisi'}");
    print("Jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

void main() {
  Mahasiswa mahasiswa = Mahasiswa();
  print("Masukkan nama mahasiswa: ");
  mahasiswa.nama = stdin.readLineSync();
  print("Masukkan NIM mahasiswa: ");
  mahasiswa.nim = int.tryParse(stdin.readLineSync() ?? '');
  print("Masukkan jurusan mahasiswa: ");
  mahasiswa.jurusan = stdin.readLineSync();
  mahasiswa.tampilkanData();
}
