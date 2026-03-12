import 'dart:io';

void main() {
  print('\n'); //set data awal
  Set<String> My = {'Hiura', 'Mpuy', 'Ruru'};
  print('Daftar my istri: $My');


  print('\n'); //tambah data dan tambah data duplicate
  Set<String> dataList = {};
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
    print('Data "$data" berhasil ditambahkan!');
  }

  print('=== SEMUA DATA ===');
  int no = 1;
  for (String item in dataList) {
    print('$no. $item');
    no++;
  }


  print('\n'); //hitung total data
  print('Total data: ${dataList.length}');


  print('\n'); //hapus data
  stdout.write('Masukkan data yang ingin dihapus: ');
  String dataHapus = stdin.readLineSync()!;
  if (dataList.contains(dataHapus)) {
    dataList.remove(dataHapus);
    print('Data "$dataHapus" berhasil dihapus!');
  } else {
    print('Data "$dataHapus" tidak ditemukan!');
  }

  print('\n'); //cek data
  stdout.write('Masukkan data yang ingin dicek: ');
  String dataCek = stdin.readLineSync()!;
  if (dataList.contains(dataCek)) {
    print('Data "$dataCek" ada di Set!');
  } else {
    print('Data "$dataCek" tidak ada di Set!');
  }






}
