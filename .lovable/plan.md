

## Rencana: Fase 3 — Keuangan Lengkap

Berdasarkan analisis blueprint vs kode yang ada, berikut item Fase 3 yang belum selesai:

| Item | Status |
|------|--------|
| Kuitansi Pembayaran (PDF/print) | ⚠️ Partial — ada dialog, belum proper print layout |
| Laporan Bayar per Siswa | ✅ Sudah ada (LaporanBayarSiswa.tsx) |
| Laporan Bayar per Kelas | ❌ Belum |
| Laporan Tunggak per Kelas | ⚠️ Partial — TunggakanPembayaran ada tapi belum format per-kelas |
| Rekap Keuangan Harian | ❌ Belum |
| Pembayaran Calon Siswa | ❌ Belum |
| Tutup Buku | ❌ Belum |

### Yang Akan Dibangun

#### 1. Kuitansi Pembayaran (Perbaikan Print)
- Buat komponen `PrintKuitansi` dengan layout proper untuk cetak (kop sekolah, terbilang, tanda tangan)
- Gunakan `@media print` CSS untuk layout cetak yang rapi
- Dipanggil dari dialog kuitansi di `InputPembayaran`

#### 2. Laporan Bayar per Kelas
- **File:** `src/pages/keuangan/LaporanBayarKelas.tsx`
- **Route:** `/keuangan/laporan-kelas`
- Filter: lembaga → kelas → jenis pembayaran → bulan range
- Tabel: nama siswa, NIS, status per bulan (lunas/belum), total bayar
- Export Excel

#### 3. Rekap Keuangan Harian
- **File:** `src/pages/keuangan/RekapHarian.tsx`
- **Route:** `/keuangan/rekap-harian`
- Filter: tanggal, lembaga
- Tabel: semua transaksi penerimaan + pengeluaran hari itu
- Ringkasan: total masuk, total keluar, saldo hari ini

#### 4. Pembayaran Calon Siswa (PSB)
- **File:** `src/pages/keuangan/PembayaranPSB.tsx`
- **Route:** `/keuangan/pembayaran-psb`
- Input pembayaran untuk siswa berstatus `calon` dari tabel siswa
- Jenis bayar khusus PSB (pendaftaran, uang pangkal, dll)

#### 5. Tutup Buku
- **File:** `src/pages/keuangan/TutupBuku.tsx`
- **Route:** `/keuangan/tutup-buku`
- Pilih tahun buku yang akan ditutup
- Hitung saldo akhir semua akun → jadikan saldo awal tahun berikutnya
- Generate jurnal penutup otomatis
- Lock data keuangan tahun yang sudah ditutup

### Perubahan File

- **`src/App.tsx`** — Tambah 4 route baru
- **`src/pages/Keuangan.tsx`** — Tambah link ke halaman baru
- **`src/pages/keuangan/InputPembayaran.tsx`** — Perbaikan komponen print kuitansi
- **`src/components/layout/AppSidebar.tsx`** — Tambah menu baru
- **4 file halaman baru** di `src/pages/keuangan/`

### Database
Tidak perlu migrasi baru — semua tabel yang dibutuhkan sudah ada (`pembayaran`, `pengeluaran`, `jurnal`, `akun_rekening`, `siswa`, `kelas_siswa`).

Saya akan implementasi satu per satu, dimulai dari Kuitansi Print → Laporan per Kelas → Rekap Harian → Pembayaran PSB → Tutup Buku.

