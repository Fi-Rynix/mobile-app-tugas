import 'dart:io';

//class mahasiswa
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

//mixin 1
mixin PresensiMixin {
  int? hadir = 0;
  int? sakit = 0;
  int? izin = 0;
  int? alpa = 0;

  void tambahPresensi(String jenis) {
    if (jenis == "hadir") {
      hadir = (hadir ?? 0) + 1;
      print("Presensi hadir ditambah. Total: $hadir");
    } else if (jenis == "sakit") {
      sakit = (sakit ?? 0) + 1;
      print("Presensi sakit ditambah. Total: $sakit");
    } else if (jenis == "izin") {
      izin = (izin ?? 0) + 1;
      print("Presensi izin ditambah. Total: $izin");
    } else if (jenis == "alpa") {
      alpa = (alpa ?? 0) + 1;
      print("Presensi alpa ditambah. Total: $alpa");
    }
  }

  void tampilkanPresensi() {
    print("--- Rekap Presensi ---");
    print("Hadir: $hadir");
    print("Sakit: $sakit");
    print("Izin: $izin");
    print("Alpa: $alpa");
  }
}

//mixin 2
mixin NilaiMixin {
  Map<String, double> nilaiMataKuliah = {};

  void tambahNilai(String mataKuliah, double nilai) {
    nilaiMataKuliah[mataKuliah] = nilai;
    print("Nilai $mataKuliah: $nilai telah ditambahkan");
  }

  double? hitungRataNilai() {
    if (nilaiMataKuliah.isEmpty) return 0;
    double total = nilaiMataKuliah.values.fold(0, (a, b) => a + b);
    return total / nilaiMataKuliah.length;
  }

  void tampilkanNilai() {
    print("--- Daftar Nilai ---");
    nilaiMataKuliah.forEach((mataKuliah, nilai) {
      print("$mataKuliah: $nilai");
    });
    print("Rata-rata: ${hitungRataNilai()?.toStringAsFixed(2)}");
  }
}

//mixin 3
mixin SertifikatMixin {
  List<String> sertifikat = [];

  void tambahSertifikat(String namaSertifikat) {
    sertifikat.add(namaSertifikat);
    print("Sertifikat '$namaSertifikat' telah ditambahkan");
  }

  void tampilkanSertifikat() {
    print("--- Daftar Sertifikat ---");
    if (sertifikat.isEmpty) {
      print("Belum ada sertifikat");
    } else {
      for (int i = 0; i < sertifikat.length; i++) {
        print("${i + 1}. ${sertifikat[i]}");
      }
    }
  }
}

//mixin 4
mixin KomunikasiMixin {
  String? email;
  String? noTelepon;

  void setKontak(String email, String noTelepon) {
    this.email = email;
    this.noTelepon = noTelepon;
    print("Kontak telah diperbarui");
  }

  void tampilkanKontak() {
    print("--- Kontak ---");
    print("Email: $email");
    print("No Telepon: $noTelepon");
  }
}

//dosen extend mahasiswa dengan mixin
class Dosen extends Mahasiswa with PresensiMixin, SertifikatMixin, KomunikasiMixin {
  String? nip;
  String? keahlian;

  void tampilkanDataDosen() {
    print("=== Data Dosen ===");
    tampilkanData();
    print("NIP: $nip");
    print("Keahlian: $keahlian");
  }
}

//fakultas extend mahasiswa dengan mixin
class Fakultas extends Mahasiswa with NilaiMixin, PresensiMixin, KomunikasiMixin {
  String? fakultas;
  String? prodi;

  void tampilkanDataFakultas() {
    print("=== Data Mahasiswa Fakultas ===");
    tampilkanData();
    print("Fakultas: $fakultas");
    print("Program Studi: $prodi");
  }
}

void main() {
  //doden
  print("========== DATA DOSEN ==========\n");
  var dosen = Dosen();
  dosen.nama = "Dr. Budi Santoso";
  dosen.nim = 1001;
  dosen.jurusan = "Teknik Informatika";
  dosen.nip = "198505152010121002";
  dosen.keahlian = "Algoritma & Struktur Data";
  
  dosen.tampilkanDataDosen();
  print("");
  
  dosen.setKontak("budi@universitas.ac.id", "081234567890");
  dosen.tampilkanKontak();
  print("");
  
  dosen.tambahPresensi("hadir");
  dosen.tambahPresensi("hadir");
  dosen.tambahPresensi("alpa");
  dosen.tampilkanPresensi();
  print("");
  
  dosen.tambahSertifikat("Google Cloud Associate");
  dosen.tambahSertifikat("Oracle Certified");
  dosen.tampilkanSertifikat();

  //fakultas
  print("\n========== DATA MAHASISWA FAKULTAS ==========\n");
  var mahasiswa = Fakultas();
  mahasiswa.nama = "Rina Wijaya";
  mahasiswa.nim = 2022001;
  mahasiswa.jurusan = "Teknik Informatika";
  mahasiswa.fakultas = "Teknik";
  mahasiswa.prodi = "Teknik Informatika";
  
  mahasiswa.tampilkanDataFakultas();
  print("");
  
  mahasiswa.setKontak("rina@student.ac.id", "089876543210");
  mahasiswa.tampilkanKontak();
  print("");
  
  mahasiswa.tambahNilai("Algoritma", 85.5);
  mahasiswa.tambahNilai("Database", 90.0);
  mahasiswa.tambahNilai("Web Programming", 88.0);
  mahasiswa.tampilkanNilai();
  print("");
  
  mahasiswa.tambahPresensi("hadir");
  mahasiswa.tambahPresensi("hadir");
  mahasiswa.tambahPresensi("sakit");
  mahasiswa.tambahPresensi("hadir");
  mahasiswa.tampilkanPresensi();
}
