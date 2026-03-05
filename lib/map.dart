import 'dart:io';

void main() {

  print('\n'); //declare awal
  Map<String, String> data = {
    'Anang': '081234567890',
    'Arman': '082345678901',
    'Doni': '083456789012'
  };
  print('Contacts: $data');


  print('\n'); //tambah data
  data['Rio'] = '084567890123';
  print('Data setelah ditambahkan: $data');


  print('\n'); //tampilkan data berdasarkan key
  print('Nomor Anang: ${data['Anang']}');


  print('\n'); //ubah data berdasarkan key
  stdout.write('Masukkan nama yang nomornyax` ingin diubah: ');
  String keyUbah = stdin.readLineSync()!;

  if (data.containsKey(keyUbah)) {
    stdout.write('Masukkan nomor baru: ');
    String nomorBaru = stdin.readLineSync()!;
    data[keyUbah] = nomorBaru;
    print('Data setelah diubah: $data');
  } else {
    print('Key tidak ditemukan!');
  }


  print('\n'); //hapus data berdasarkan key
  stdout.write('Masukkan nama yang ingin dihapus: ');
  String keyHapus = stdin.readLineSync()!;

  if (data.containsKey(keyHapus)) {
    data.remove(keyHapus);
    print('Data setelah dihapus: $data');
  } else {
    print('Key tidak ditemukan!');
  }


  print('\n'); //cek data berdasarkan key
  stdout.write('Masukkan nama yang ingin dicek: ');
  String keyCek = stdin.readLineSync()!;

  if (data.containsKey(keyCek)) {
    print('Data ditemukan: ${data[keyCek]}');
  } else {
    print('Data tidak ditemukan!');
  }


  print('\n'); //hitung jumlah data
  print('Jumlah data: ${data.length}');


  print('\n'); //tampilkan semua key
  print('Semua nama:');
  for (String key in data.keys) {
    print(key);
  }


  print('\n'); //tampilkan semua value
  print('Semua nomor:');
  for (String value in data.values) {
    print(value);
  }


  print('\n'); //input data single
  print('=== INPUT DATA MAHASISWA ===');

  Map<String, dynamic> mahasiswa = {};

  stdout.write('Masukkan NIM: ');
  mahasiswa['nim'] = stdin.readLineSync();

  stdout.write('Masukkan Nama: ');
  mahasiswa['nama'] = stdin.readLineSync();

  stdout.write('Masukkan Jurusan: ');
  mahasiswa['jurusan'] = stdin.readLineSync();

  stdout.write('Masukkan IPK: ');
  mahasiswa['ipk'] = double.parse(stdin.readLineSync()!);

  print('Data Mahasiswa: $mahasiswa');


  print('\n'); //input data multiple
  print('=== INPUT MULTIPLE MAHASISWA ===');

  Map<String, Map<String, dynamic>> dataMahasiswa = {};

  int jumlah = 0;
  while (jumlah <= 0) {
    stdout.write('Masukkan jumlah mahasiswa: ');
    String? input = stdin.readLineSync();
    try {
      jumlah = int.parse(input!);
      if (jumlah <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid!');
    }
  }

  for (int i = 0; i < jumlah; i++) {
    print('\n--- Mahasiswa ke-${i + 1} ---');

    stdout.write('Masukkan NIM: ');
    String nim = stdin.readLineSync()!;

    stdout.write('Masukkan Nama: ');
    String nama = stdin.readLineSync()!;

    stdout.write('Masukkan Jurusan: ');
    String jurusan = stdin.readLineSync()!;

    stdout.write('Masukkan IPK: ');
    double ipk = double.parse(stdin.readLineSync()!);

    dataMahasiswa[nim] = {
      'nama': nama,
      'jurusan': jurusan,
      'ipk': ipk
    };
  }


  print('\n'); //tampilkan semua value
  print('=== SEMUA DATA MAHASISWA ===');
  dataMahasiswa.forEach((key, value) {
    print('NIM: $key -> $value');
  });

  print('Total mahasiswa: ${dataMahasiswa.length}');
}