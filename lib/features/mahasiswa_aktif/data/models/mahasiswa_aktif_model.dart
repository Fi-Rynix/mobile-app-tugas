class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final String tahunMasuk;
  final String statusAkademik;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    required this.tahunMasuk,
    required this.statusAkademik,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      tahunMasuk: json['tahunMasuk'] ?? '',
      statusAkademik: json['statusAkademik'] ?? 'Aktif',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'tahunMasuk': tahunMasuk,
      'statusAkademik': statusAkademik,
    };
  }
}
