# Gooner Store Mobile
Aplikasi mobile simpel terinspirasi dari tim sepak bola Arsenal FC yang dibuat untuk Tugas Individu Mata Kuliah Pemrograman Berbasis Platform (PBP) 2025/2026 di Fakultas Ilmu Komputer Universitas Indonesia.

## Daftar Isi
- [Tugas 7](#tugas-7)
- [Tugas 8](#tugas-8)

## Tugas 7

### 1) Apa itu widget tree dan hubungan parent-child?
Widget tree adalah struktur hierarki semua widget yang menyusun UI Flutter. Setiap widget punya parent (induk) dan bisa punya beberapa child (anak). Parent menentukan bagaimana child ditata/dirender (misal lewat layout seperti Column/Row/Padding). Pada proyek ini, urutannya kurang lebih:
runApp → MyApp → MaterialApp → MyHomePage → Scaffold → AppBar/Body → Center → Column → (Text, Text, SizedBox, Padding → ElevatedButton.icon, ...), dst.

### 2) Widget yang digunakan dan fungsinya
- runApp: Menjalankan aplikasi Flutter dengan widget root.
- MyApp (StatelessWidget): Widget root kustom aplikasi.
- MaterialApp: Menyediakan struktur dan konfigurasi material design (tema, routing, dsb).
- ThemeData: Konfigurasi tema (warna, typography) untuk MaterialApp.
- ColorScheme: Skema warna yang dipakai ThemeData.
- MyHomePage (StatefulWidget): Halaman utama yang menyimpan state counter.
- Scaffold: Kerangka dasar halaman (AppBar, body, FAB, dsb).
- AppBar: Bilah aplikasi di atas.
- Center: Meposisikan child di tengah.
- Column: Menyusun anak secara vertikal.
- Text: Menampilkan teks.
- SizedBox: Spasi/ukuran kosong.
- Padding: Memberikan jarak dalam di sekitar child.
- ElevatedButton.icon (ElevatedButton): Tombol berikon dengan gaya material.
- Icon: Menampilkan ikon material.
- FloatingActionButton: Tombol aksi melayang bulat.
- SnackBar: Komponen notifikasi singkat di bawah layar.
- ScaffoldMessenger: Menampilkan SnackBar pada Scaffold aktif.

Catatan: ThemeData, ColorScheme, dan ScaffoldMessenger bukan “widget visual” yang tampil, tapi bagian penting dari konfigurasi/host untuk widget lain.

### 3) Fungsi MaterialApp dan kenapa sering jadi root
MaterialApp adalah pembungkus aplikasi berbasis Material Design. Ia men-setup:
- Tema (ThemeData/ColorScheme)
- Navigator/routing
- Localizations
- Struktur dasar material (scaffold, animasi, dsb)

Dipakai sebagai root karena memudahkan konsistensi tampilan dan akses ke fitur material di seluruh widget tree.

### 4) Perbedaan StatelessWidget vs StatefulWidget
- StatelessWidget: Tidak punya state internal yang berubah. Build sekali lalu hanya rebuild jika input (props) berubah. Contoh: MyApp.
- StatefulWidget: Punya state yang bisa berubah saat runtime dan memicu rebuild via setState. Contoh: MyHomePage dengan counter.

Pilih Stateless kalau UI hanya bergantung pada data yang tidak berubah di dalam widget. Pilih Stateful kalau perlu menyimpan/ubah state (counter, form input, loading state, dsb).

### 5) Apa itu BuildContext dan kenapa penting?
BuildContext adalah “pointer” ke posisi widget di dalam widget tree. Dipakai untuk:
- Mengakses inherited widget (Theme.of(context), MediaQuery.of(context))
- Menampilkan SnackBar lewat ScaffoldMessenger.of(context)
- Navigasi (Navigator.of(context))

Di metode build, context diberikan agar widget bisa membaca dependensi/tema dan berinteraksi dengan lingkungan UI-nya.

Contoh di proyek:
- Theme.of(context).textTheme.headlineMedium untuk gaya teks.
- ScaffoldMessenger.of(context).showSnackBar(...) untuk menampilkan SnackBar.

### 6) Hot reload vs hot restart
- Hot reload: Menyuntikkan perubahan kode ke VM dan rebuild widget tree tanpa menghapus state. Cepat untuk iterasi UI/logic ringan.
- Hot restart: Me-restart aplikasi dari awal (state hilang), menjalankan ulang main(). Dipakai kalau perubahan tidak terdeteksi hot reload atau ingin state bersih.

## Tugas 8

### 1) Perbedaan `Navigator.push()` dan `Navigator.pushReplacement()`

**Navigator.push()**
- Menambahkan route baru ke stack navigasi
- Halaman sebelumnya tetap ada di memori
- User bisa kembali ke halaman sebelumnya dengan tombol back
- Contoh: Navigasi dari Home ke Form Add Product

**Navigator.pushReplacement()**
- Mengganti route saat ini dengan route baru
- Halaman sebelumnya dihapus dari stack
- User tidak bisa kembali ke halaman sebelumnya
- Contoh: Navigasi dari drawer menu ke halaman utama

**Penggunaan di Gooner Store:**
- `Navigator.push()`: Digunakan saat membuka form Add Product dari home atau drawer, karena user mungkin ingin kembali
- `Navigator.pushReplacement()`: Digunakan di drawer saat pindah ke Home, agar tidak menumpuk halaman yang sama

### 2) Pemanfaatan Hierarchy Widget untuk Konsistensi

**Scaffold**
- Digunakan sebagai struktur dasar di semua halaman ([menu.dart](lib/screens/menu.dart), [productlist_form.dart](lib/screens/productlist_form.dart))
- Menyediakan kerangka konsisten dengan AppBar, Drawer, dan Body

**AppBar**
- Tampil di semua halaman dengan warna dan style yang sama (merah Arsenal)
- Title konsisten menggunakan font bold dan warna putih

**Drawer (LeftDrawer)**
- Widget terpisah di [left_drawer.dart](lib/widgets/left_drawer.dart)
- Dipakai di semua halaman utama untuk navigasi yang konsisten
- Header dan menu items sama di seluruh aplikasi

Dengan pendekatan ini, user mendapat pengalaman navigasi yang familiar di setiap halaman.

### 3) Kelebihan Layout Widget untuk Form

**Padding**
- Memberikan jarak antar elemen form agar tidak sumpek
- Di [productlist_form.dart](lib/screens/productlist_form.dart): `Padding(padding: const EdgeInsets.all(8.0))` untuk setiap field

**SingleChildScrollView**
- Memungkinkan form di-scroll saat konten panjang atau keyboard muncul
- Mencegah overflow error pada layar kecil
- Implementasi: Membungkus seluruh Form di [productlist_form.dart](lib/screens/productlist_form.dart)

**ListView** (di Drawer)
- Menampilkan menu items secara vertikal dengan scrolling otomatis
- Efisien untuk daftar yang bisa bertambah panjang

Contoh di form:
```dart
SingleChildScrollView(
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(...), // Product Name
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(...), // Price
      ),
      // dst...
    ],
  ),
)