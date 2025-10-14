String mapFirebaseAuthError(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Format email tidak valid.';
    case 'user-disabled':
      return 'Akun ini dinonaktifkan. Hubungi dukungan.';
    case 'user-not-found':
      return 'Pengguna tidak ditemukan. Silakan daftar terlebih dahulu.';
    case 'wrong-password':
      return 'Password salah. Coba lagi.';
    case 'email-already-in-use':
      return 'Email sudah digunakan. Silakan gunakan email lain atau login.';
    case 'weak-password':
      return 'Password terlalu lemah. Gunakan kombinasi yang lebih kuat.';
    case 'network-request-failed':
      return 'Koneksi internet bermasalah. Periksa koneksi Anda.';
    default:
      return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
