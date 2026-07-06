#============================================================
# Makefile: PENS Buku Kerja Praktik LaTeX Template
#
# Usage:
#   make buku      -> kompilasi Buku KP
#   make clean     -> hapus folder build/ (aux sementara)
#   make cleanall  -> hapus build/ + output/
#============================================================

BUILD  = build
OUTPUT = output

# Ambil nama mahasiswa pertama dan NRP dari config/variables.tex
NAMA := $(shell awk -F'[{}]' '/\\NamaMahasiswaSatu/ {gsub(/ /, "_", $$4); print $$4}' config/variables.tex)
NRP  := $(shell awk -F'[{}]' '/\\NRPSatu/ {print $$4}' config/variables.tex)
DATETIME := $(shell date +%Y%m%d_%H%M%S)

.PHONY: all buku clean cleanall

all: buku

buku:
	@echo "==> Kompilasi Buku KP..."
	@mkdir -p $(BUILD) $(OUTPUT)
	latexmk -pdf main_buku.tex
	@rm -f main_buku.fdb_latexmk main_buku.fls
	@cp $(BUILD)/main_buku.pdf "$(OUTPUT)/Buku_KP_$(NAMA)_$(NRP)_$(DATETIME).pdf"
	@echo "==> Output: $(OUTPUT)/Buku_KP_$(NAMA)_$(NRP)_$(DATETIME).pdf"

clean:
	@rm -rf $(BUILD)
	@rm -f main_buku.aux main_buku.log main_buku.pdf \
	       main_buku.fdb_latexmk main_buku.fls main_buku.synctex.gz \
	       main_buku.bbl main_buku.blg main_buku.out \
	       main_buku.toc main_buku.lof main_buku.lot
	@echo "==> Folder build/ dan file sementara di root dihapus."

cleanall: clean
	@rm -rf $(OUTPUT)
	@echo "==> Folder output/ juga dihapus."
