import 'dart:io';

void main() {
  print('\n'); //declare
  List<String> nama = ['Udin', 'Aralan', 'Karbit'];
  print('Nama: $nama');


  print('\n'); // tambah data list
  nama.add('Ikhsan');
  print('Nama setelah ditambahkan: $nama');


  print('\n'); //tampilkan data index tertentu
  print('Elemen pertama: ${nama[0]}');
  print('Elemen pertama: ${nama[1]}');


  print('\n'); //mengubah data index
  nama[1] = 'Alanbit';
  print('Nama setelah diubah: $nama');


  print('\n'); //hapus data tertentu
  nama.remove('Karbit');
  print('Nama setelah dihapus: $nama');


  print('\n'); //hitung jumlah data
  print('Jumlah data: ${nama.length}');


  print('\n'); //tampilkan semua data dengan looping
  print('Menampilkan setiap elemen:');
  for (String nama in nama) {
    print(nama);
  }


  print('\n'); //list dengan model input data
  List<String> dataList = [];
  print('Data list: $dataList');

  int count = 0;
  while (count <= 0 ) {
    stdout.write('Masukkan jumlah data: ');
    String? jumlah = stdin.readLineSync();
    try {
      count = int.parse(jumlah!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid! Masukkan angka yang benar');
    }
  }

  for (int i=0; i<count; i++) {
    stdout.write('Data ke-${i+1}: ');
    String data = stdin.readLineSync()!;
    dataList.add(data);
  }

  print('Data list: ');
  print(dataList);


  //tampil, ubah, hapus index tertentu

  print('\n'); //menampilkan index tertentu
  int? noTampil;
  while (true) {
    stdout.write('Masukkan nomor index yang ingin ditampilkan: ');
    String? inputTampil = stdin.readLineSync();
    try {
      noTampil = int.parse(inputTampil!);
      if (noTampil < 0) {
        print('Nomor index dimulai dari 0!');
        continue;
      }
      if (noTampil >= dataList.length) {
        print('Index melebihi jumlah data!');
        continue;
      }
      break;
    } catch (e) {
      print('Input tidak valid! Masukkan nomor index yang benar');
    }
  }

  print('Menampilkan index ke-$noTampil: ${dataList[noTampil]}');

  print('\n'); //mengubah index tertentu
  int? noUbah;
  while (true) {
    stdout.write('Masukkan nomor index yang ingin diubah: ');
    String? inputUbah = stdin.readLineSync();
    try {
      noUbah = int.parse(inputUbah!);
      if (noUbah < 0) {
        print('Nomor index dimulai dari 0!');
        continue;
      }
      if (noUbah >= dataList.length) {
        print('Index melebihi jumlah data!');
        continue;
      }
      break;
    } catch (e) {
      print('Input tidak valid! Masukkan nomor index yang benar');
    }
  }

  String? nilaiInput;
  stdout.write('Masukkan nilai baru untuk index yang dipilih: ');
  String nilaiUbah = stdin.readLineSync()!;
  dataList[noUbah] = nilaiUbah;
  print('Data list setelah diubah: ');
  print(dataList);


  print('\n'); //menghapus index tertentu
  int? noHapus;
  while (true) {
    stdout.write('Masukkan nomor index yang ingin dihapus: ');
    String? inputHapus = stdin.readLineSync();
    try {
      noHapus = int.parse(inputHapus!);
      if (noHapus < 0) {
        print('Nomor index dimulai dari 0!');
        continue;
      }
      if (noHapus >= dataList.length) {
        print('Index melebihi jumlah data!');
        continue;
      }
      break;
    } catch (e) {
      print('Input tidak valid! Masukkan nomor index yang benar');
    }
  }

  dataList.removeAt(noHapus);
  print('Data list setelah dihapus: ');
  print(dataList);

  print('=== SEMUA DATA ===');
  int banyakData = dataList.length;
  for (int i=0; i<banyakData; i++) {
    print('Index $i: ${dataList[i]}');
  }

}