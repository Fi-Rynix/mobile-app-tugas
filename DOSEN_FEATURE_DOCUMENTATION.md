# Dokumentasi Fitur Dosen

Dokumentasi ini menjelaskan keseluruhan alur data *Dosen* di aplikasi: mulai dari **model**, **repository (API)**, hingga **widget tampilan**.

---

## 1. Struktur Data (Model)

### 1.1 `DosenModel` + `AddressModel`
File: `lib/features/dosen/data/models/dosen_model.dart`

`DosenModel` merepresentasikan data dosen yang digunakan di UI dan state management.
`AddressModel` adalah bagian dari `DosenModel` yang mengambil data `address` dari API.

Keduanya memiliki:
- `factory ... fromJson(Map<String, dynamic> json)` → untuk parsing JSON ke objek Dart
- `Map<String, dynamic> toJson()` → untuk konversi objek ke JSON (opsional)

#### Field `DosenModel`
- `int id`
- `String name`
- `String username`
- `String email`
- `AddressModel address`

#### Field `AddressModel`
- `String street`
- `String suite`
- `String city`
- `String zipcode`

---

## 2. Pengambilan Data (Repository / API)

### 2.1 `DosenRepository`
File: `lib/features/dosen/data/repositories/dosen_repository.dart`

Tugas repository:
1. **Memanggil API** (via `http.get`)
2. **Mengecek status response**
3. **Mengkonversi JSON** menjadi `List<DosenModel>`
4. **Menangani error** jika status bukan 200

```
Future<List<DosenModel>> getDosenList() async {
  final response = await http.get(...);
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => DosenModel.fromJson(json)).toList();
  } else {
    throw Exception('Gagal memuat data dosen: ${response.statusCode}');
  }
}
```

### 2.2 Alur Pemanggilan (Flow)
1. UI -> provider/notifier memanggil `getDosenList`
2. `DosenRepository` melakukan request ke endpoint API
3. Response diterima dalam bentuk JSON
4. JSON di-parse ke model Dart (`DosenModel`) via `fromJson`
5. List model diteruskan ke UI untuk ditampilkan

---

## 3. UI (Widget) untuk Menampilkan Dosen

### 3.1 `DosenListView`
File: `lib/features/dosen/presentation/widgets/dosen_widget.dart`

`DosenListView` merupakan widget utama untuk menampilkan list dosen:
- Menerima `List<DosenModel>`
- Menampilkan list menggunakan `ModernDosenCard` (default)
- Bila list kosong, menampilkan `DosenEmptyState`
- Mendukung `onRefresh` (pull-to-refresh)

### 3.2 `ModernDosenCard`
Menampilkan detail dosen dalam desain modern (gradient + animasi tap). Data yang ditampilkan:
- Nama (`dosen.name`)
- Username (`@dosen.username`)
- Email
- Lokasi (`address.street`, `address.city`)

### 3.3 Variasi: `DosenCard`
Versi sederhana (Card + InkWell) untuk menampilkan dosen.

---

## 4. Perbandingan: Sebelum vs Sesudah Menggunakan API

| Aspek | Sebelum (Dummy Hard-coded) | Sesudah (API) |
|------|----------------------------|----------------|
| Sumber data | Data dibuat manual di repository (hard-coded list) | Data diambil dari server (HTTP GET) |
| Kecepatan / Dependency | Langsung, tanpa network | Bergantung jaringan, butuh `http` package |
| Dinamis | Tidak pernah berubah kecuali dikode ulang | Bisa berubah sesuai backend |
| Keandalan / Error | Sukar diuji (selalu berhasil) | Butuh error handling (HTTP, parsing) |

---

## 5. Tips Debugging (Jika Data Tidak Muncul)

1. Pastikan URL API benar (`https://jsonplaceholder.typicode.com/users`).
2. Pastikan `DosenModel.fromJson()` cocok dengan struktur JSON.
3. Cek apakah `response.statusCode` 200 (OK).
4. Jika parsing error, coba `print(response.body)` lalu bandingkan dengan field model.

---

## 6. Langkah Selanjutnya (Opsional)
Jika ingin memperluas fitur, beberapa tambahan yang bisa dilakukan:
- Tambahkan **Detail Page**: klik card → buka halaman detail dosen
- Tambahkan **cache lokal** (shared_preferences / hive) agar bisa offline
- Buat **error UI lebih lengkap** (misal: tampilan khusus untuk No Internet)
- Tambah field pada `DosenModel` seperti `phone`, `website`, `company` sesuai API

---

## 7. Kode Penting (Baris / Bagian yang Harus Dipahami)
Ini adalah potongan kode yang benar-benar "menggerakkan" fitur Dosen (API → UI).

### 7.1 Model (Parsing JSON)
**File:** `lib/features/dosen/data/models/dosen_model.dart`

Kunci: `fromJson()` dan `AddressModel.fromJson()` yang mengubah JSON jadi objek Dart.

```dart
factory DosenModel.fromJson(Map<String, dynamic> json) {
  return DosenModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    address: AddressModel.fromJson(json['address'] ?? {}),
  );
}
```

### 7.2 Repository (HTTP + Parsing)
**File:** `lib/features/dosen/data/repositories/dosen_repository.dart`

Kunci: request ke API (`http.get`) + parsing (`jsonDecode`) + mapping ke `DosenModel`.

```dart
final response = await http.get(
  Uri.parse('https://jsonplaceholder.typicode.com/users'),
  headers: {'Accept': 'application/json'},
);

if (response.statusCode == 200) {
  final List<dynamic> data = jsonDecode(response.body);
  return data.map((json) => DosenModel.fromJson(json)).toList();
} else {
  throw Exception('Gagal memuat data dosen: ${response.statusCode}');
}
```

### 7.3 Provider / State Management (Fetch + State)
**File:** `lib/features/dosen/presentation/providers/dosen_provider.dart`

Kunci: memanggil repository, menyimpan state `loading/data/error`.

```dart
final dosenRepositoryProvider = Provider((ref) {
  return DosenRepository();
});

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  Future<void> _loadDosen() async {
    try {
      state = const AsyncValue.loading();
      final dosenList = await repository.getDosenList();
      state = AsyncValue.data(dosenList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
```

### 7.4 Widget (Render UI)
**File:** `lib/features/dosen/presentation/widgets/dosen_widget.dart`

Kunci: `DosenListView` menerima list `DosenModel` dari provider, lalu render:
- `ModernDosenCard` (default)
- `DosenCard` (alternatif)

Contoh penting untuk rendering data:

```dart
Text(widget.dosen.name, ...);
_buildInfoRow(Icons.account_circle_outlined, '@${widget.dosen.username}');
_buildInfoRow(Icons.location_on_outlined, '${widget.dosen.address.street}, ${widget.dosen.address.city}');
```

---

Dokumentasi ini dibuat berdasarkan struktur kode saat ini di `lib/features/dosen/`.
