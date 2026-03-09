
-- Presensi KBM (per mata pelajaran)
CREATE TABLE public.presensi_kbm (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  siswa_id uuid REFERENCES public.siswa(id) ON DELETE CASCADE,
  kelas_id uuid REFERENCES public.kelas(id),
  mapel_id uuid REFERENCES public.mata_pelajaran(id),
  pegawai_id uuid REFERENCES public.pegawai(id),
  tahun_ajaran_id uuid REFERENCES public.tahun_ajaran(id),
  semester_id uuid REFERENCES public.semester(id),
  tanggal date NOT NULL,
  jam_ke integer,
  status text DEFAULT 'H',
  keterangan text
);

ALTER TABLE public.presensi_kbm ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admin_presensi_kbm_all" ON public.presensi_kbm FOR ALL TO authenticated
  USING (has_role(auth.uid(), 'admin'))
  WITH CHECK (has_role(auth.uid(), 'admin'));

CREATE POLICY "guru_presensi_kbm_manage" ON public.presensi_kbm FOR ALL TO authenticated
  USING (has_role(auth.uid(), 'guru') AND guru_teaches_mapel(auth.uid(), mapel_id))
  WITH CHECK (has_role(auth.uid(), 'guru') AND guru_teaches_mapel(auth.uid(), mapel_id));

CREATE POLICY "kepsek_presensi_kbm_select" ON public.presensi_kbm FOR SELECT TO authenticated
  USING (has_role(auth.uid(), 'kepala_sekolah'));

CREATE POLICY "siswa_presensi_kbm_select" ON public.presensi_kbm FOR SELECT TO authenticated
  USING (is_own_siswa(auth.uid(), siswa_id));

-- Komentar Rapor
CREATE TABLE public.komentar_rapor (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  siswa_id uuid REFERENCES public.siswa(id) ON DELETE CASCADE NOT NULL,
  kelas_id uuid REFERENCES public.kelas(id),
  tahun_ajaran_id uuid REFERENCES public.tahun_ajaran(id),
  semester_id uuid REFERENCES public.semester(id),
  komentar_wali text,
  komentar_kepala text,
  catatan_piket text,
  created_at timestamptz DEFAULT now(),
  UNIQUE (siswa_id, kelas_id, tahun_ajaran_id, semester_id)
);

ALTER TABLE public.komentar_rapor ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admin_komentar_all" ON public.komentar_rapor FOR ALL TO authenticated
  USING (is_admin_or_kepala(auth.uid()))
  WITH CHECK (is_admin_or_kepala(auth.uid()));

CREATE POLICY "guru_komentar_manage" ON public.komentar_rapor FOR ALL TO authenticated
  USING (has_role(auth.uid(), 'guru'))
  WITH CHECK (has_role(auth.uid(), 'guru'));

CREATE POLICY "siswa_komentar_select" ON public.komentar_rapor FOR SELECT TO authenticated
  USING (is_own_siswa(auth.uid(), siswa_id));

-- RPP (Rencana Pelaksanaan Pembelajaran)
CREATE TABLE public.rpp (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  pegawai_id uuid REFERENCES public.pegawai(id),
  mapel_id uuid REFERENCES public.mata_pelajaran(id),
  kelas_id uuid REFERENCES public.kelas(id),
  tahun_ajaran_id uuid REFERENCES public.tahun_ajaran(id),
  semester_id uuid REFERENCES public.semester(id),
  judul text NOT NULL,
  kompetensi_inti text,
  kompetensi_dasar text,
  tujuan text,
  materi text,
  metode text,
  langkah_kegiatan text,
  penilaian text,
  sumber_belajar text,
  alokasi_waktu text,
  pertemuan_ke integer,
  status text DEFAULT 'draft',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.rpp ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admin_rpp_all" ON public.rpp FOR ALL TO authenticated
  USING (is_admin_or_kepala(auth.uid()))
  WITH CHECK (is_admin_or_kepala(auth.uid()));

CREATE POLICY "guru_rpp_manage" ON public.rpp FOR ALL TO authenticated
  USING (has_role(auth.uid(), 'guru'))
  WITH CHECK (has_role(auth.uid(), 'guru'));

CREATE POLICY "auth_rpp_select" ON public.rpp FOR SELECT TO authenticated
  USING (true);
