# Buku KP PENS LaTeX

Template LaTeX untuk **Laporan Kerja Praktik (KP)** Politeknik Elektronika Negeri Surabaya (PENS),
mengacu pada **Pedoman Pelaksanaan Kerja Praktek PENS (BIMA.PENS.KP Rev.02, Januari 2018)**,
Pasal **4.2.1 Susunan Laporan** dan **4.2.2 Ketentuan Penulisan Laporan Kerja Praktek** (hal. 21-26).

> 📘 Butuh template untuk **Proyek Akhir (PA)**? → [jhiven/buku-pa-pens-latex](https://github.com/jhiven/buku-pa-pens-latex)

> 📄 **Sumber pedoman:** [Pedoman Kerja Praktek PENS 2018 (PDF)](https://rengga.lecturer.pens.ac.id/KP/Pedoman%20Kerja%20Praktek%20PENS%202018%20v260118.pdf).
> Salinan ini ada di situs dosen PENS (sampul tertulis "Rev.01", isi dan header tertulis "Rev.02").
> Selalu konfirmasi versi terbaru ke Koordinator KP prodi Anda.

## Caption, Isi Tabel & Sumber

| Elemen | Hasil | Diatur di |
|---|---|---|
| Judul tabel | **Tabel 2.1:** Judul tabel (di atas, menjorok 1 cm) | `\captionsetup[table]` di `config/formatting.tex` (juga `longtblr`) |
| Judul gambar | **Gambar 2.1: Judul gambar** (di bawah, menjorok 1 cm) | `\captionsetup[figure]` di `config/formatting.tex` |
| Isi tabel (`tblr`/`longtblr`) | `\small` (±9pt), spasi 1 | hook otomatis di `config/formatting.tex` |
| Sumber gambar/tabel | 8pt | macro `\FontSumber` di `config/fonts.tex` |

Contoh penulisan sumber di bawah tabel atau setelah judul gambar:

```latex
{\FontSumber Sumber: NamaPengarang, Judul Buku, TahunTerbit, Hal.\par}
```

## Struktur Project

```
buku-kp-pens-latex/
|-- main_buku.tex                # Runner utama
|-- config/
|   |-- variables.tex            # Identitas mahasiswa & KP (edit ini!)
|   |-- toggles.tex              # Opsi: sisip PDF pengesahan bertanda tangan
|   |-- fonts.tex                # Semua ukuran font (satu macro per peruntukan)
|   |-- packages.tex             # Package LaTeX
|   |-- formatting.tex           # Aturan formatting shared
|-- formats/
|   |-- format_buku.tex          # Geometri A5, single spacing
|   |-- cover_buku.tex           # Cover berwarna kuning PENS (Lampiran 3 pedoman)
|   |-- halaman_judul.tex        # Halaman judul dalam
|   |-- pengesahan_internal.tex  # Lembar pengesahan PENS
|   |-- pengesahan_instansi.tex  # Lembar pengesahan perusahaan
|-- chapters/
|   |-- bab1.tex                 # Bab 1: Pendahuluan
|   |-- bab2.tex                 # Bab 2: Gambaran Perusahaan
|   |-- bab3.tex                 # Bab 3: Landasan Teori
|   |-- bab4.tex                 # Bab 4: Rancangan dan Implementasi Sistem
|   |-- bab5.tex                 # Bab 5: Penutup
|-- pages/
|   |-- abstrak.tex
|   |-- kata_pengantar.tex
|   |-- daftar_lampiran.tex      # Daftar Lampiran (urutan sama dengan lampiran.tex)
|   |-- lampiran.tex
|   |-- sistematika_kp.tex
|-- refs/
|   |-- references.bib           # Daftar pustaka
|   |-- IEEEtranN.bst            # Gaya IEEE (tidak dipakai lagi; pustaka memakai apalike)
|-- assets/pens/                 # Logo institusi
|-- Makefile
|-- .latexmkrc
|-- LICENSE                      # Lisensi MIT (template)
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

# Compile ulang otomatis setiap file .tex disimpan (tanpa LaTeX Workshop)
make watch      # PDF di build/main_buku.pdf, hentikan dengan Ctrl+C
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
Pada kedua gaya, **nomor halaman selalu di bawah tengah**, satu-satunya aturan
header/footer di pedoman KP (Pasal 4.2.2 poin 4a & 4c). Pedoman tidak mengatur isi
header, jadi logo PENS dan nama perusahaan di Gaya 2 bersifat **opsional**.

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
Gaya dengan logo PENS di kiri header, diikuti nama institusi dan baris
"LAPORAN KERJA PRAKTIK - nama perusahaan". Nomor halaman di bawah tengah.

**Header:**  
![Header Gaya 2](assets/layout/header2.png)

**Footer:**  
![Footer Gaya 2](assets/layout/footer2.png)

## Lembar Pengesahan Bertanda Tangan (Opsional)

Setelah Lembar Pengesahan Internal (PENS) dan Lembar Pengesahan Instansi
ditandatangani (dan distempel perusahaan), scan ke PDF lalu aktifkan di
`main_buku.tex`:

```latex
% \pengesahaninternalpdftrue  % pages/pengesahan_internal_ttd.pdf
% \pengesahaninstansipdftrue  % pages/pengesahan_instansi_ttd.pdf
```

Halaman hasil LaTeX akan diganti dengan PDF tersebut. Nama file bisa diubah
lewat `\FilePengesahanInternalPDF` / `\FilePengesahanInstansiPDF` di
`config/toggles.tex`.

## Ukuran Font (`config/fonts.tex`)

Semua ukuran font ditulis sekali di `config/fonts.tex`, satu macro per
peruntukan. Jika ada revisi ukuran, cukup ubah satu baris:

```latex
\newcommand{\FontPengesahanIsi}{\fontsize{10}{13}\selectfont}  % -> misal {9}{12}
```

Macro dibedakan per peran, bukan per angka: misalnya isi cover, halaman
judul, dan lembar pengesahan sama-sama 10pt, tetapi masing-masing punya macro
sendiri sehingga bisa diubah terpisah.

## Jumlah Mahasiswa

File `config/variables.tex` mendukung 1 sampai 3 mahasiswa per buku:

- **1 mahasiswa**: isi `NamaMahasiswaSatu` + `NRPSatu`, kosongkan yang lain
- **2 mahasiswa**: isi `NamaMahasiswaSatu` + `NamaMahasiswaDua`, kosongkan `NamaMahasiswaTiga`
- **3 mahasiswa**: isi semua

Nama yang dikosongkan tidak akan muncul di cover, halaman judul, maupun lembar pengesahan.

## Ucapan Terima Kasih

Terima kasih kepada **[Jhiven Agnar Fuad](https://github.com/jhiven)** yang telah menginisialisasi penerapan LaTeX sebagai standar penulisan dokumen akademik di lingkungan PENS melalui template [buku-pa-pens-latex](https://github.com/jhiven/buku-pa-pens-latex)-nya. Template KP ini terinspirasi dan mengikuti pendekatan yang beliau rintis.


## Referensi

- **Pedoman Pelaksanaan Kerja Praktek PENS**, BIMA.PENS.KP Rev.02 (sampul tertulis Rev.01), Januari 2018.
  [PDF](https://rengga.lecturer.pens.ac.id/KP/Pedoman%20Kerja%20Praktek%20PENS%202018%20v260118.pdf)
  - Pasal yang dipakai: **4.2.1 Susunan Laporan Kerja Praktek** (hal. 21-23) dan
    **4.2.2 Ketentuan Penulisan Laporan Kerja Praktek** (hal. 23-26).
  - Catatan: salinan ini berada di situs dosen PENS, bukan halaman resmi BIMA. Konfirmasi
    versi terbaru ke Koordinator KP program studi Anda.

## Lisensi

Kode template ini dirilis dengan **MIT License** (lihat file [`LICENSE`](LICENSE)).

**Catatan untuk mahasiswa:** lisensi MIT hanya berlaku untuk **file struktur
template** (file `.tex` kerangka, konfigurasi, Makefile, dan sejenisnya).
**Isi laporan KP Anda tetap milik Anda**: teks, data, gambar, dan hasil kerja
yang Anda tulis dengan template ini adalah karya Anda sendiri (atau milik
kampus/perusahaan, sesuai ketentuan masing-masing). Memakai template ini tidak
mewajibkan Anda membagikan laporan KP Anda secara publik.
