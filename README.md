# capstone_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

# Proyek Capstone Siaga Gizi

Aplikasi Flutter untuk "Siaga Gizi: Sistem Deteksi Dini Stunting untuk Balita di Daerah 3T".

---

## 🚀 Cara Menjalankan Proyek

### 1. Prasyarat
- Pastikan Anda telah menginstal [Flutter SDK](https://docs.flutter.dev/get-started/install) di komputer Anda.
- Sebuah editor kode seperti [VS Code](https://code.visualstudio.com/) dengan ekstensi Flutter atau [Android Studio](https://developer.android.com/studio).
- Akun [Firebase](https://firebase.google.com/) untuk setup backend.

### 2. Setup Firebase
Aplikasi ini menggunakan Firebase untuk autentikasi dan database.

1.  **Buat Proyek Firebase:**
    - Buka [Firebase Console](https://console.firebase.google.com/) dan buat proyek baru.
2.  **Tambahkan Flutter ke Proyek Anda:**
    - Ikuti panduan resmi untuk menambahkan Firebase ke aplikasi Flutter Anda: [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup?platform=android).
    - Secara ringkas, Anda perlu menginstal Firebase CLI, login, lalu jalankan `flutterfire configure` dari root direktori proyek ini.
3.  **Aktifkan Layanan:**
    - Di Firebase Console, aktifkan layanan berikut:
        - **Authentication:** Aktifkan metode `Email/Password`.
        - **Firestore Database:** Buat database Firestore dalam mode produksi.
4.  **Update `main.dart`:**
    - Setelah konfigurasi `flutterfire`, sebuah file `lib/firebase_options.dart` akan dibuat.
    - Buka `lib/main.dart` dan hapus komentar pada baris-baris berikut untuk menginisialisasi Firebase:
      ```dart
      // import 'package:firebase_core/firebase_core.dart';
      // import 'firebase_options.dart'; // Uncomment this if you have the file

      // ...

      // void main() async {
      //   WidgetsFlutterBinding.ensureInitialized();
      //   await Firebase.initializeApp(
      //     options: DefaultFirebaseOptions.currentPlatform,
      //   );
      //   runApp(const MyApp());
      // }
      ```

### 3. Instal Dependensi
Buka terminal di root direktori proyek dan jalankan:
```sh
flutter pub get
```

### 4. Jalankan Aplikasi
Hubungkan perangkat Android atau jalankan emulator, lalu jalankan perintah berikut:
```sh
flutter run
```

---

## 📦 State Management (Provider)

Aplikasi ini menggunakan `provider` untuk state management, memisahkan UI dari logika bisnis.

- **Providers:** Terletak di `lib/providers/`. Setiap file mengelola state untuk domain tertentu (misalnya, `AuthProvider` untuk autentikasi, `ChildProvider` untuk data anak).
- **Models:** Terletak di `lib/models/`. Ini adalah kelas data murni (misalnya, `UserModel`, `ChildModel`).
- **Services:** Terletak di `lib/services/`. Kelas-kelas ini menangani komunikasi dengan layanan eksternal seperti Firebase.
- **UI (Screens):** Terletak di `lib/screens/`. Widget ini "mendengarkan" perubahan dari Provider dan memperbarui UI sesuai kebutuhan.

### Alur Kerja Provider (Contoh: Login)
1.  **UI (`login_screen.dart`):** Memanggil metode `login()` dari `AuthProvider`.
    ```dart
    Provider.of<AuthProvider>(context, listen: false).login(email, password);
    ```
2.  **Provider (`auth_provider.dart`):** Metode `login()` memanggil `AuthService` untuk berinteraksi dengan Firebase. Setelah berhasil, ia memperbarui state internal dan memanggil `notifyListeners()`.
3.  **UI (`app.dart`):** `Consumer` atau `Provider.of` yang mendengarkan `AuthProvider` akan otomatis membangun ulang UI, misalnya, mengarahkan pengguna dari `LoginScreen` ke `HomeScreen`.