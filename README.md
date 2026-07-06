# Buku KP PENS LaTeX

Template LaTeX untuk **Laporan Kerja Praktik (KP)** Politeknik Elektronika Negeri Surabaya (PENS),
sesuai pedoman **BIMA.PENS.KP Rev.02** Pasal 4.2.2.

> 📘 Butuh template untuk **Proyek Akhir (PA)**? → [jhiven/buku-pa-pens-latex](https://github.com/jhiven/buku-pa-pens-latex)

## Format Dokumen

| Aspek | Spesifikasi (BIMA.PENS.KP Rev.02) | Status |
|---|---|---|
| Kertas | A5 (148 mm × 210 mm), HVS 70/80 gram | ✅ |
| Font tubuh | Times New Roman 10pt normal | ✅ |
| Font judul BAB | Times New Roman 12pt bold, kapital | ✅ |
| Spasi | 1 spasi (single spacing) | ✅ |
| Cetak | Bolak-balik (twoside), halaman ganjil = depan | ✅ |
| Indentasi awal paragraf | 1 cm (1 tab) | ✅ |
| Setiap bab baru | Mulai halaman ganjil, halaman genap dikosongkan | ✅ |
| Penomoran gambar/tabel | Per bab (contoh: Gambar 2.1, Tabel 3.2) | ✅ |
| Penomoran halaman awal | Romawi kecil (i, ii, ...), posisi bawah-tengah | ✅ |
| Penomoran halaman isi | Arab (1, 2, ...), posisi bawah-tengah | ✅ |

### Margin (Mirror — sesuai spec jilid)

| Sisi | Jarak |
|---|---|
| Atas | 2,5 cm |
| Bawah | 2,0 cm |
| Inner (sisi jilid) | 2,5 cm |
| Outer (sisi luar) | 2,0 cm |

### Catatan Belum Otomatis (Perlu Diisi Manual)

> Spec pedoman yang tidak bisa diotomasi oleh template — perlu diperhatikan saat menulis konten:

- **Font caption tabel**: judul tabel 10pt normal, isi tabel minimal 6pt normal, sumber di bawah 8pt → atur di tiap `\caption{}` secara manual
- **Font caption gambar**: judul gambar 10pt bold, sumber 8pt → atur di tiap `\caption{}` secara manual
- **Sumber tabel/gambar**: format `Sumber: NamaPengarang, Judul Buku, TahunTerbit, Hal.` ditulis manual di bawah `\caption{}`
- **Jarak 2 spasi (24pt) antara judul BAB dan teks/subbab pertama**: saat ini diset 12pt di `config/formatting.tex` (baris `\titlespacing`) — ubah ke `24pt` jika ingin mengikuti pedoman secara ketat

## Struktur Project

```
buku-kp-pens-latex/
|-- main_buku.tex                # Runner utama
|-- config/
|   |-- variables.tex            # Identitas mahasiswa & KP (edit ini!)
|   |-- packages.tex             # Package LaTeX
|   |-- formatting.tex           # Aturan formatting shared
|-- formats/
|   |-- format_buku.tex          # Geometri A5, single spacing
|   |-- cover_buku.tex           # Cover berwarna (orange)
|   |-- halaman_judul.tex        # Halaman judul dalam
|   |-- pengesahan_internal.tex  # Lembar pengesahan PENS
|   |-- pengesahan_instansi.tex  # Lembar pengesahan perusahaan
|-- chapters/
|   |-- bab1.tex                 # Bab I: Pendahuluan
|   |-- bab2.tex                 # Bab II: Gambaran Perusahaan
|   |-- bab3.tex                 # Bab III: Landasan Teori
|   |-- bab4.tex                 # Bab IV: Rancangan dan Implementasi Sistem
|   |-- bab5.tex                 # Bab V: Penutup
|-- pages/
|   |-- abstrak.tex
|   |-- kata_pengantar.tex
|   |-- lampiran.tex
|   |-- sistematika_kp.tex
|-- refs/
|   |-- references.bib           # Daftar pustaka
|   |-- IEEEtranN.bst            # Gaya sitasi IEEE
|-- assets/pens/                 # Logo institusi
|-- Makefile
|-- .latexmkrc
```

## Setup VS Code (Auto-Build)

Project ini mendukung *auto-build* via ekstensi **LaTeX Workshop** setiap kali file `.tex` disimpan.

### Mengapa perlu setup manual?

Setting LaTeX Workshop (`latex.tools`, `latex.recipes`, `latex.outDir`) bersifat **window-scoped** - tidak bisa berbeda per-folder. File `.vscode/settings.json` di dalam project ini **tidak akan aktif** jika VS Code dibuka dari folder parent. Satu-satunya solusi yang bekerja di semua kondisi (parent folder maupun langsung) adalah menaruhnya di **User Settings** global.

### Langkah Setup (satu kali saja)

1. Buka `Ctrl+Shift+P` → ketik **"Preferences: Open User Settings (JSON)"** → Enter.
2. Tambahkan konfigurasi berikut:

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-pdf",
        "-outdir=build",
        "-auxdir=build",
        "-interaction=nonstopmode",
        "-synctex=1",
        "%DOC%"
      ]
    }
  ],
  "latex-workshop.latex.recipes": [
    { "name": "latexmk (build/)", "tools": ["latexmk"] }
  ],
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.latex.autoClean.run": "never",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.view.pdf.ref.viewer": "auto",
  "latex-workshop.latex.outDir": "build"
}
```

### Setelah setup

- `Ctrl+S` → *auto-build* berjalan otomatis
- `Ctrl+Alt+V` → buka PDF viewer di tab VS Code
- File intermediate masuk ke `build/`, bukan root folder
- Berlaku apapun cara membuka project (parent folder maupun langsung)

> Semua project PENS LaTeX ini konsisten menggunakan folder `build/` sebagai output, sehingga satu config User Settings ini cukup untuk semua.

## Penggunaan

### 1. Isi Identitas di `config/variables.tex`

```latex
% Mahasiswa 1 (wajib diisi)
\newcommand{\NamaMahasiswaSatu}{Nama Mahasiswa}
\newcommand{\NRPSatu}{31XXXXXXXXX}

% Mahasiswa 2 (kosongkan jika tidak ada)
\newcommand{\NamaMahasiswaDua}{}
\newcommand{\NRPDua}{}

% Mahasiswa 3 (kosongkan jika tidak ada)
\newcommand{\NamaMahasiswaTiga}{}
\newcommand{\NRPTiga}{}
```

> Mendukung 1, 2, atau 3 mahasiswa per buku. Cukup kosongkan variabel `NamaMahasiswaDua`/`NamaMahasiswaTiga` jika tidak digunakan.

### 2. Kompilasi

```bash
# Kompilasi buku KP
make buku
```

Output PDF final tersimpan di folder `output/` dengan nama otomatis:
`Buku_KP_<Nama>_<NRP>_<Timestamp>.pdf`

File intermediate (`.aux`, `.log`, dll.) tersimpan di `build/`.

### 3. Bersihkan File Build

```bash
make clean      # hapus build/ saja
make cleanall   # hapus build/ + output/
```

## Pilihan Gaya Layout (Header/Footer)

Template ini menyediakan 2 macam gaya header dan footer yang bisa Anda pilih. 
Untuk mengubahnya, buka file `config/variables.tex` lalu ubah angka pada variabel `\StyleHeaderFooter`:

```latex
% -- Gaya Header & Footer (Pilih salah satu) -------------------
% 1 = Simple (Laporan kerja praktik, tengah)
% 2 = PENS (Logo PENS, Nama Perusahaan, dll)
\newcommand{\StyleHeaderFooter}{1}
```

### Gaya 1 (Simple)
Gaya standar yang sederhana dengan posisi teks di tengah.

**Header:**  
![Header Gaya 1](assets/layout/header1.png)

**Footer:**  
![Footer Gaya 1](assets/layout/footer1.png)

### Gaya 2 (PENS)
Gaya dengan logo PENS di bagian header, serta nama perusahaan di footer.

**Header:**  
![Header Gaya 2](assets/layout/header2.png)

**Footer:**  
![Footer Gaya 2](assets/layout/footer2.png)

## Jumlah Mahasiswa

File `config/variables.tex` mendukung 1 sampai 3 mahasiswa per buku:

- **1 mahasiswa**: isi `NamaMahasiswaSatu` + `NRPSatu`, kosongkan yang lain
- **2 mahasiswa**: isi `NamaMahasiswaSatu` + `NamaMahasiswaDua`, kosongkan `NamaMahasiswaTiga`
- **3 mahasiswa**: isi semua

Nama yang dikosongkan tidak akan muncul di cover, halaman judul, maupun lembar pengesahan.

## Ucapan Terima Kasih

Terima kasih kepada **[Jhiven Agnar Fuad](https://github.com/jhiven)** yang telah menginisialisasi penerapan LaTeX sebagai standar penulisan dokumen akademik di lingkungan PENS melalui template [buku-pa-pens-latex](https://github.com/jhiven/buku-pa-pens-latex)-nya. Template KP ini terinspirasi dan mengikuti pendekatan yang beliau rintis.
