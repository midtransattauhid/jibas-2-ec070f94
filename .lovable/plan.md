

## Rencana: Unit Test + Manual Browser Test

### 1. Unit Test (Vitest)

Setup testing sudah ada (`vitest.config.ts`, `src/test/setup.ts`, dependencies). Saya akan membuat unit test untuk komponen-komponen utama:

**File test yang akan dibuat:**

- **`src/components/auth/ProtectedRoute.test.tsx`** — Test bahwa user tanpa login di-redirect ke `/login`, dan user dengan role salah di-redirect ke `/unauthorized`
- **`src/pages/Login.test.tsx`** — Test render form login, validasi email/password, tampil error message
- **`src/components/shared/StatusBadge.test.tsx`** — Test render badge dengan berbagai status
- **`src/components/shared/StatsCard.test.tsx`** — Test render stats card dengan props berbeda

Semua test akan mock Supabase client dan AuthContext agar tidak butuh koneksi database.

### 2. Manual Browser Test

Setelah unit test selesai, saya akan menggunakan browser tools untuk mengecek halaman-halaman utama di preview:
- Navigasi ke beberapa route utama (Dashboard, Akademik, Keuangan, Kepegawaian)
- Verifikasi tidak ada blank screen atau crash
- Cek interaksi dasar (klik menu, buka modal)

### Estimasi
- 4 file test baru
- 1 sesi browser testing manual

