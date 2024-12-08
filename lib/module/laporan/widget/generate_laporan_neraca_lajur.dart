import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

doGenerateLaporanNeracaLajur({required LaporanController controller}) async {
  showCircleDialogLoading();
  try {
    final pdf = pw.Document();

    DataNeracaLajur data =
        controller.resultNeracaLajur.data ?? DataNeracaLajur();

    DataNeraca dataNeraca = data.dataNeraca ?? DataNeraca();
    TotalNeraca dataTotal = data.totalNeraca ?? TotalNeraca();

    List<RowLaporanNeracaLajur> rows = [
      RowLaporanNeracaLajur(
        uraian: 'KAS',
        neracaAwalD: (dataNeraca.kas?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.kas?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.kas?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.kas?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD: (dataNeraca.kas?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK: (dataNeraca.kas?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.kas?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.kas?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD: (dataNeraca.kas?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK: (dataNeraca.kas?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.kas?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.kas?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'BANK BRI',
        neracaAwalD: (dataNeraca.bankBri?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.bankBri?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.bankBri?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.bankBri?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bankBri?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bankBri?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.bankBri?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.bankBri?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD: (dataNeraca.bankBri?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK: (dataNeraca.bankBri?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.bankBri?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.bankBri?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PIUTANG DAGANG',
        neracaAwalD: (dataNeraca.piutangDagang?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.piutangDagang?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.piutangDagang?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.piutangDagang?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.piutangDagang?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.piutangDagang?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.piutangDagang?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.piutangDagang?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.piutangDagang?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.piutangDagang?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.piutangDagang?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.piutangDagang?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PERSEDIAAN',
        neracaAwalD: (dataNeraca.persediaan?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.persediaan?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.persediaan?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.persediaan?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.persediaan?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.persediaan?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.persediaan?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.persediaan?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.persediaan?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.persediaan?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.persediaan?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.persediaan?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENGHAPUSAN PERSEDIAAN',
        neracaAwalD:
            (dataNeraca.penghapusanPersediaan?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.penghapusanPersediaan?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.penghapusanPersediaan?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.penghapusanPersediaan?.neracaMutasi?.kredit)
            ?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.penghapusanPersediaan?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.penghapusanPersediaan?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD:
            (dataNeraca.penghapusanPersediaan?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.penghapusanPersediaan?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.penghapusanPersediaan?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.penghapusanPersediaan?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.penghapusanPersediaan?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.penghapusanPersediaan?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'INVENTARIS',
        neracaAwalD: (dataNeraca.inventaris?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.inventaris?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.inventaris?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.inventaris?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.inventaris?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.inventaris?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.inventaris?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.inventaris?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.inventaris?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.inventaris?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.inventaris?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.inventaris?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'AKUM. PENY. INVENTARIS',
        neracaAwalD:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaAwal?.debit)
                ?.toDouble(),
        neracaAwalK:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaAwal?.kredit)
                ?.toDouble(),
        neracaMutasiD:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaMutasi?.debit)
                ?.toDouble(),
        neracaMutasiK:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaMutasi?.kredit)
                ?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaSaldo?.debit)
                ?.toDouble(),
        neracaSaldoK:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaSaldo?.kredit)
                ?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.akumulasiPenyusutanInventaris?.hasilUsaha?.debit)
                ?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.akumulasiPenyusutanInventaris?.hasilUsaha?.kredit)
                ?.toDouble(),
        neracaAkhirD:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaAkhir?.debit)
                ?.toDouble(),
        neracaAkhirK:
            (dataNeraca.akumulasiPenyusutanInventaris?.neracaAkhir?.kredit)
                ?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'GEDUNG',
        neracaAwalD: (dataNeraca.gedung?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.gedung?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.gedung?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.gedung?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.gedung?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.gedung?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.gedung?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.gedung?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD: (dataNeraca.gedung?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK: (dataNeraca.gedung?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.gedung?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.gedung?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'AKUM. PENY. GEDUNG',
        neracaAwalD: (dataNeraca.akumulasiPenyusutanGedung?.neracaAwal?.debit)
            ?.toDouble(),
        neracaAwalK: (dataNeraca.akumulasiPenyusutanGedung?.neracaAwal?.kredit)
            ?.toDouble(),
        neracaMutasiD:
            (dataNeraca.akumulasiPenyusutanGedung?.neracaMutasi?.debit)
                ?.toDouble(),
        neracaMutasiK:
            (dataNeraca.akumulasiPenyusutanGedung?.neracaMutasi?.kredit)
                ?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.akumulasiPenyusutanGedung?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.akumulasiPenyusutanGedung?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD: (dataNeraca.akumulasiPenyusutanGedung?.neracaSaldo?.debit)
            ?.toDouble(),
        neracaSaldoK:
            (dataNeraca.akumulasiPenyusutanGedung?.neracaSaldo?.kredit)
                ?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.akumulasiPenyusutanGedung?.hasilUsaha?.debit)
                ?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.akumulasiPenyusutanGedung?.hasilUsaha?.kredit)
                ?.toDouble(),
        neracaAkhirD: (dataNeraca.akumulasiPenyusutanGedung?.neracaAkhir?.debit)
            ?.toDouble(),
        neracaAkhirK:
            (dataNeraca.akumulasiPenyusutanGedung?.neracaAkhir?.kredit)
                ?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'UTANG DAGANG',
        neracaAwalD: (dataNeraca.utangDagang?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.utangDagang?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.utangDagang?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.utangDagang?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.utangDagang?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.utangDagang?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.utangDagang?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.utangDagang?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.utangDagang?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.utangDagang?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.utangDagang?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.utangDagang?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'UTANG DARI SP',
        neracaAwalD: (dataNeraca.utangSp?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.utangSp?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.utangSp?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.utangSp?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.utangSp?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.utangSp?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.utangSp?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.utangSp?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD: (dataNeraca.utangSp?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK: (dataNeraca.utangSp?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.utangSp?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.utangSp?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'MODAL TIDAK TETAP (R/C),',
        neracaAwalD:
            (dataNeraca.modalTidakTetap?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.modalTidakTetap?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.modalTidakTetap?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.modalTidakTetap?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.modalTidakTetap?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.modalTidakTetap?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.modalTidakTetap?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.modalTidakTetap?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.modalTidakTetap?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.modalTidakTetap?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.modalTidakTetap?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.modalTidakTetap?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'MODAL DISETOR',
        neracaAwalD: (dataNeraca.modalDisetor?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.modalDisetor?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.modalDisetor?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.modalDisetor?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.modalDisetor?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.modalDisetor?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.modalDisetor?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.modalDisetor?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.modalDisetor?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.modalDisetor?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.modalDisetor?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.modalDisetor?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'USAHA LAIN-LAIN TOKO',
        neracaAwalD: (dataNeraca.usahaLainToko?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.usahaLainToko?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.usahaLainToko?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.usahaLainToko?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.usahaLainToko?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.usahaLainToko?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.usahaLainToko?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.usahaLainToko?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.usahaLainToko?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.usahaLainToko?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.usahaLainToko?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.usahaLainToko?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'MODAL UNIT TOKO',
        neracaAwalD: (dataNeraca.modalUnitToko?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.modalUnitToko?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.modalUnitToko?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.modalUnitToko?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.modalUnitToko?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.modalUnitToko?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.modalUnitToko?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.modalUnitToko?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.modalUnitToko?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.modalUnitToko?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.modalUnitToko?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.modalUnitToko?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'SHU TH. 2023',
        neracaAwalD: (dataNeraca.shuTh2023?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.shuTh2023?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.shuTh2023?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.shuTh2023?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.shuTh2023?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.shuTh2023?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.shuTh2023?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.shuTh2023?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.shuTh2023?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.shuTh2023?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.shuTh2023?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.shuTh2023?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'SHU TH. 2024',
        neracaAwalD: (dataNeraca.shuTh2024?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.shuTh2024?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.shuTh2024?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.shuTh2024?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.shuTh2024?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.shuTh2024?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.shuTh2024?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.shuTh2024?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.shuTh2024?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.shuTh2024?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.shuTh2024?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.shuTh2024?.neracaAkhir?.kredit)?.toDouble(),
      ),
      if (dataNeraca.shuTh2025 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2025?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2025?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2025?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2025?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2025?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2025?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2025?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2025?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2025?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2025?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2025?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2025?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2026 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2026?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2026?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2026?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2026?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2026?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2026?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2026?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2026?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2026?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2026?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2026?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2026?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2027 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2027?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2027?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2027?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2027?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2027?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2027?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2027?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2027?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2027?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2027?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2027?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2027?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2028 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2028?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2028?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2028?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2028?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2028?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2028?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2028?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2028?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2028?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2028?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2028?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2028?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2029 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2029?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2029?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2029?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2029?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2029?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2029?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2029?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2029?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2029?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2029?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2029?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2029?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2030 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2030?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2030?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2030?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2030?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2030?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2030?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2030?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2030?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2030?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2030?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2030?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2030?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2031 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2031?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2031?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2031?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2031?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2031?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2031?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2031?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2031?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2031?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2031?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2031?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2031?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2032 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2032?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2032?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2032?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2032?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2032?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2032?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2032?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2032?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2032?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2032?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2032?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2032?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2033 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2033?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2033?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2033?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2033?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2033?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2033?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2033?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2033?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2033?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2033?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2033?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2033?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2034 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2034?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2034?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2034?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2034?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2034?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2034?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2034?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2034?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2034?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2034?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2034?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2034?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2035 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2035?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2035?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2035?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2035?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2035?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2035?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2035?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2035?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2035?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2035?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2035?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2035?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2036 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2036?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2036?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2036?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2036?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2036?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2036?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2036?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2036?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2036?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2036?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2036?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2036?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2037 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2037?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2037?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2037?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2037?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2037?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2037?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2037?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2037?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2037?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2037?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2037?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2037?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2038 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2038?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2038?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2038?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2038?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2038?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2038?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2038?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2038?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2038?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2038?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2038?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2038?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2039 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2039?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2039?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2039?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2039?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2039?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2039?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2039?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2039?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2039?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2039?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2039?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2039?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2040 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2040?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2040?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2040?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2040?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2040?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2040?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2040?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2040?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2040?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2040?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2040?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2040?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2041 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2041?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2041?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2041?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2041?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2041?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2041?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2041?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2041?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2041?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2041?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2041?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2041?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2042 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2042?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2042?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2042?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2042?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2042?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2042?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2042?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2042?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2042?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2042?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2042?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2042?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2043 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2043?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2043?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2043?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2043?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2043?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2043?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2043?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2043?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2043?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2043?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2043?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2043?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2044 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2044?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2044?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2044?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2044?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2044?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2044?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2044?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2044?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2044?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2044?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2044?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2044?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2045 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2045?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2045?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2045?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2045?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2045?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2045?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2045?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2045?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2045?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2045?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2045?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2045?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2046 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2046?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2046?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2046?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2046?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2046?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2046?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2046?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2046?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2046?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2046?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2046?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2046?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2047 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2047?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2047?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2047?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2047?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2047?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2047?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2047?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2047?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2047?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2047?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2047?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2047?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2048 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2048?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2048?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2048?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2048?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2048?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2048?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2048?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2048?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2048?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2048?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2048?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2048?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2049 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2049?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2049?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2049?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2049?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2049?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2049?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2049?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2049?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2049?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2049?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2049?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2049?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2050 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2050?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2050?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2050?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2050?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2050?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2050?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2050?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2050?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2050?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2050?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2050?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2050?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2051 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2051?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2051?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2051?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2051?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2051?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2051?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2051?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2051?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2051?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2051?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2051?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2051?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2052 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2052?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2052?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2052?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2052?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2052?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2052?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2052?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2052?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2052?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2052?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2052?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2052?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2053 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2053?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2053?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2053?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2053?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2053?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2053?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2053?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2053?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2053?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2053?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2053?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2053?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2054 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2054?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2054?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2054?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2054?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2054?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2054?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2054?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2054?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2054?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2054?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2054?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2054?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2055 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2055?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2055?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2055?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2055?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2055?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2055?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2055?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2055?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2055?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2055?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2055?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2055?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2056 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2056?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2056?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2056?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2056?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2056?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2056?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2056?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2056?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2056?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2056?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2056?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2056?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2057 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2057?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2057?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2057?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2057?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2057?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2057?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2057?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2057?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2057?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2057?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2057?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2057?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2057 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2057?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2057?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2057?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2057?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2057?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2057?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2057?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2057?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2057?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2057?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2057?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2057?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2058 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2058?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2058?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2058?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2058?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2058?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2058?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2058?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2058?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2058?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2058?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2058?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2058?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2059 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2059?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2059?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2059?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2059?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2059?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2059?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2059?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2059?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2059?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2059?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2059?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2059?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2060 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2060?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2060?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2060?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2060?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2060?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2060?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2060?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2060?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2060?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2060?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2060?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2060?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2061 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2061?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2061?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2061?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2061?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2061?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2061?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2061?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2061?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2061?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2061?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2061?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2061?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2062 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2062?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2062?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2062?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2062?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2062?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2062?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2062?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2062?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2062?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2062?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2062?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2062?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2063 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2063?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2063?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2063?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2063?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2063?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2063?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2063?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2063?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2063?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2063?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2063?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2063?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2064 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2064?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2064?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2064?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2064?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2064?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2064?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2064?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2064?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2064?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2064?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2064?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2064?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2065 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2065?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2065?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2065?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2065?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2065?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2065?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2065?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2065?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2065?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2065?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2065?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2065?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2066 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2066?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2066?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2066?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2066?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2066?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2066?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2066?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2066?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2066?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2066?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2066?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2066?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2067 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2067?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2067?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2067?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2067?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2067?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2067?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2067?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2067?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2067?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2067?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2067?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2067?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2068 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2068?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2068?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2068?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2068?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2068?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2068?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2068?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2068?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2068?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2068?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2068?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2068?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2069 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2069?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2069?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2069?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2069?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2069?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2069?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2069?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2069?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2069?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2069?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2069?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2069?.neracaAkhir?.kredit)?.toDouble(),
        ),
      if (dataNeraca.shuTh2070 != null)
        RowLaporanNeracaLajur(
          uraian: 'SHU TH. 2025',
          neracaAwalD: (dataNeraca.shuTh2070?.neracaAwal?.debit)?.toDouble(),
          neracaAwalK: (dataNeraca.shuTh2070?.neracaAwal?.kredit)?.toDouble(),
          neracaMutasiD:
              (dataNeraca.shuTh2070?.neracaMutasi?.debit)?.toDouble(),
          neracaMutasiK:
              (dataNeraca.shuTh2070?.neracaMutasi?.kredit)?.toDouble(),
          neracaPercobaanD:
              (dataNeraca.shuTh2070?.neracaPercobaan?.debit)?.toDouble(),
          neracaPercobaanK:
              (dataNeraca.shuTh2070?.neracaPercobaan?.kredit)?.toDouble(),
          neracaSaldoD: (dataNeraca.shuTh2070?.neracaSaldo?.debit)?.toDouble(),
          neracaSaldoK: (dataNeraca.shuTh2070?.neracaSaldo?.kredit)?.toDouble(),
          neracaHasilUsahaD:
              (dataNeraca.shuTh2070?.hasilUsaha?.debit)?.toDouble(),
          neracaHasilUsahaK:
              (dataNeraca.shuTh2070?.hasilUsaha?.kredit)?.toDouble(),
          neracaAkhirD: (dataNeraca.shuTh2070?.neracaAkhir?.debit)?.toDouble(),
          neracaAkhirK: (dataNeraca.shuTh2070?.neracaAkhir?.kredit)?.toDouble(),
        ),
      RowLaporanNeracaLajur(
        uraian: 'PENJUALAN TUNAI',
        neracaAwalD: (dataNeraca.penjualanTunai?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.penjualanTunai?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.penjualanTunai?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.penjualanTunai?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.penjualanTunai?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.penjualanTunai?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.penjualanTunai?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.penjualanTunai?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.penjualanTunai?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.penjualanTunai?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.penjualanTunai?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.penjualanTunai?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENJUALAN KREDIT',
        neracaAwalD:
            (dataNeraca.penjualanKredit?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.penjualanKredit?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.penjualanKredit?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.penjualanKredit?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.penjualanKredit?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.penjualanKredit?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.penjualanKredit?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.penjualanKredit?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.penjualanKredit?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.penjualanKredit?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.penjualanKredit?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.penjualanKredit?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENJUALAN QRIS',
        neracaAwalD: (dataNeraca.penjualanQris?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.penjualanQris?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.penjualanQris?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.penjualanQris?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.penjualanQris?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.penjualanQris?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.penjualanQris?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.penjualanQris?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.penjualanQris?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.penjualanQris?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.penjualanQris?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.penjualanQris?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENDAPATAN SEWA',
        neracaAwalD: (dataNeraca.pendapatanSewa?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pendapatanSewa?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pendapatanSewa?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pendapatanSewa?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pendapatanSewa?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pendapatanSewa?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pendapatanSewa?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pendapatanSewa?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pendapatanSewa?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pendapatanSewa?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pendapatanSewa?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pendapatanSewa?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENDAPATAN LAIN-LAIN',
        neracaAwalD: (dataNeraca.pendapatanLain?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pendapatanLain?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pendapatanLain?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pendapatanLain?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pendapatanLain?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pendapatanLain?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pendapatanLain?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pendapatanLain?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pendapatanLain?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pendapatanLain?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pendapatanLain?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pendapatanLain?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PEMBELIAN TUNAI',
        neracaAwalD: (dataNeraca.pembelianTunai?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pembelianTunai?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pembelianTunai?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pembelianTunai?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pembelianTunai?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pembelianTunai?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pembelianTunai?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pembelianTunai?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pembelianTunai?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pembelianTunai?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pembelianTunai?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pembelianTunai?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PEMBELIAN KREDIT',
        neracaAwalD:
            (dataNeraca.pembelianKredit?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pembelianKredit?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pembelianKredit?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pembelianKredit?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pembelianKredit?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pembelianKredit?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pembelianKredit?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pembelianKredit?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pembelianKredit?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pembelianKredit?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pembelianKredit?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pembelianKredit?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'RETUR PEMBELIAN',
        neracaAwalD: (dataNeraca.bankBri?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.bankBri?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.bankBri?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.bankBri?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bankBri?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bankBri?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.bankBri?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.bankBri?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD: (dataNeraca.bankBri?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK: (dataNeraca.bankBri?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.bankBri?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.bankBri?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'BEBAN GAJI',
        neracaAwalD: (dataNeraca.bebanGaji?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.bebanGaji?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.bebanGaji?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.bebanGaji?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bebanGaji?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bebanGaji?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.bebanGaji?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.bebanGaji?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.bebanGaji?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.bebanGaji?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.bebanGaji?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.bebanGaji?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'UANG MAKAN',
        neracaAwalD: (dataNeraca.uangMakan?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.uangMakan?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.uangMakan?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.uangMakan?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.uangMakan?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.uangMakan?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.uangMakan?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.uangMakan?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.uangMakan?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.uangMakan?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.uangMakan?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.uangMakan?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'THR KARYAWAN',
        neracaAwalD: (dataNeraca.thrKaryawan?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.thrKaryawan?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.thrKaryawan?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.thrKaryawan?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.thrKaryawan?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.thrKaryawan?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.thrKaryawan?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.thrKaryawan?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.thrKaryawan?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.thrKaryawan?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.thrKaryawan?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.thrKaryawan?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'BEBAN ADM. & UMUM',
        neracaAwalD: (dataNeraca.bebanAdmUmum?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataNeraca.bebanAdmUmum?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.bebanAdmUmum?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.bebanAdmUmum?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bebanAdmUmum?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bebanAdmUmum?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataNeraca.bebanAdmUmum?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.bebanAdmUmum?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.bebanAdmUmum?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.bebanAdmUmum?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataNeraca.bebanAdmUmum?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.bebanAdmUmum?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'BEBAN PERLENGKAPAN TOKO',
        neracaAwalD:
            (dataNeraca.bebanPerlengkapan?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.bebanPerlengkapan?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.bebanPerlengkapan?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.bebanPerlengkapan?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bebanPerlengkapan?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bebanPerlengkapan?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.bebanPerlengkapan?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.bebanPerlengkapan?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.bebanPerlengkapan?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.bebanPerlengkapan?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.bebanPerlengkapan?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.bebanPerlengkapan?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'BEBAN PENY. INVENTARIS',
        neracaAwalD: (dataNeraca.bebanPenyusutanInventaris?.neracaAwal?.debit)
            ?.toDouble(),
        neracaAwalK: (dataNeraca.bebanPenyusutanInventaris?.neracaAwal?.kredit)
            ?.toDouble(),
        neracaMutasiD:
            (dataNeraca.bebanPenyusutanInventaris?.neracaMutasi?.debit)
                ?.toDouble(),
        neracaMutasiK:
            (dataNeraca.bebanPenyusutanInventaris?.neracaMutasi?.kredit)
                ?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bebanPenyusutanInventaris?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bebanPenyusutanInventaris?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD: (dataNeraca.bebanPenyusutanInventaris?.neracaSaldo?.debit)
            ?.toDouble(),
        neracaSaldoK:
            (dataNeraca.bebanPenyusutanInventaris?.neracaSaldo?.kredit)
                ?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.bebanPenyusutanInventaris?.hasilUsaha?.debit)
                ?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.bebanPenyusutanInventaris?.hasilUsaha?.kredit)
                ?.toDouble(),
        neracaAkhirD: (dataNeraca.bebanPenyusutanInventaris?.neracaAkhir?.debit)
            ?.toDouble(),
        neracaAkhirK:
            (dataNeraca.bebanPenyusutanInventaris?.neracaAkhir?.kredit)
                ?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'BEBAN PENY. GEDUNG',
        neracaAwalD:
            (dataNeraca.bebanPenyusutanGedung?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.bebanPenyusutanGedung?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.bebanPenyusutanGedung?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataNeraca.bebanPenyusutanGedung?.neracaMutasi?.kredit)
            ?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.bebanPenyusutanGedung?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.bebanPenyusutanGedung?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD:
            (dataNeraca.bebanPenyusutanGedung?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.bebanPenyusutanGedung?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.bebanPenyusutanGedung?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.bebanPenyusutanGedung?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.bebanPenyusutanGedung?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.bebanPenyusutanGedung?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PEMELIHARAAN INVENTARIS',
        neracaAwalD:
            (dataNeraca.pemeliharaanInventaris?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pemeliharaanInventaris?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataNeraca.pemeliharaanInventaris?.neracaMutasi?.debit)
            ?.toDouble(),
        neracaMutasiK: (dataNeraca.pemeliharaanInventaris?.neracaMutasi?.kredit)
            ?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pemeliharaanInventaris?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pemeliharaanInventaris?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pemeliharaanInventaris?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataNeraca.pemeliharaanInventaris?.neracaSaldo?.kredit)
            ?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pemeliharaanInventaris?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pemeliharaanInventaris?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pemeliharaanInventaris?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataNeraca.pemeliharaanInventaris?.neracaAkhir?.kredit)
            ?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PEMELIHARAAN GEDUNG',
        neracaAwalD:
            (dataNeraca.pemeliharaanGedung?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pemeliharaanGedung?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pemeliharaanGedung?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pemeliharaanGedung?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pemeliharaanGedung?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pemeliharaanGedung?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pemeliharaanGedung?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pemeliharaanGedung?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pemeliharaanGedung?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pemeliharaanGedung?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pemeliharaanGedung?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pemeliharaanGedung?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENGELUARAN LAIN-LAIN',
        neracaAwalD:
            (dataNeraca.pengeluaranLain?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pengeluaranLain?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pengeluaranLain?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pengeluaranLain?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pengeluaranLain?.neracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pengeluaranLain?.neracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pengeluaranLain?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pengeluaranLain?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pengeluaranLain?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pengeluaranLain?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pengeluaranLain?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pengeluaranLain?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'PENGELUARAN PUSAT LAIN',
        neracaAwalD:
            (dataNeraca.pengeluaranPusatLain?.neracaAwal?.debit)?.toDouble(),
        neracaAwalK:
            (dataNeraca.pengeluaranPusatLain?.neracaAwal?.kredit)?.toDouble(),
        neracaMutasiD:
            (dataNeraca.pengeluaranPusatLain?.neracaMutasi?.debit)?.toDouble(),
        neracaMutasiK:
            (dataNeraca.pengeluaranPusatLain?.neracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD:
            (dataNeraca.pengeluaranPusatLain?.neracaPercobaan?.debit)
                ?.toDouble(),
        neracaPercobaanK:
            (dataNeraca.pengeluaranPusatLain?.neracaPercobaan?.kredit)
                ?.toDouble(),
        neracaSaldoD:
            (dataNeraca.pengeluaranPusatLain?.neracaSaldo?.debit)?.toDouble(),
        neracaSaldoK:
            (dataNeraca.pengeluaranPusatLain?.neracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD:
            (dataNeraca.pengeluaranPusatLain?.hasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK:
            (dataNeraca.pengeluaranPusatLain?.hasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD:
            (dataNeraca.pengeluaranPusatLain?.neracaAkhir?.debit)?.toDouble(),
        neracaAkhirK:
            (dataNeraca.pengeluaranPusatLain?.neracaAkhir?.kredit)?.toDouble(),
      ),
      RowLaporanNeracaLajur(
        uraian: 'TOTAL',
        neracaAwalD: (dataTotal.totalNeracaAwal?.debit)?.toDouble(),
        neracaAwalK: (dataTotal.totalNeracaAwal?.kredit)?.toDouble(),
        neracaMutasiD: (dataTotal.totalNeracaMutasi?.debit)?.toDouble(),
        neracaMutasiK: (dataTotal.totalNeracaMutasi?.kredit)?.toDouble(),
        neracaPercobaanD: (dataTotal.totalNeracaPercobaan?.debit)?.toDouble(),
        neracaPercobaanK: (dataTotal.totalNeracaPercobaan?.kredit)?.toDouble(),
        neracaSaldoD: (dataTotal.totalNeracaSaldo?.debit)?.toDouble(),
        neracaSaldoK: (dataTotal.totalNeracaSaldo?.kredit)?.toDouble(),
        neracaHasilUsahaD: (dataTotal.totalHasilUsaha?.debit)?.toDouble(),
        neracaHasilUsahaK: (dataTotal.totalHasilUsaha?.kredit)?.toDouble(),
        neracaAkhirD: (dataTotal.totalNeracaAkhir?.debit)?.toDouble(),
        neracaAkhirK: (dataTotal.totalNeracaAkhir?.kredit)?.toDouble(),
      ),
    ];

    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(
            orientation: pw.PageOrientation.landscape,
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.all(16),
          ),
          header: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      "LAPORAN NERACA LAJUR",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Center(
                    child: pw.Text(
                      '${getNamaMonth(controller.monthNow).toUpperCase()} - ${controller.yearNow}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: boldFont,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                ],
              ),
          build: (pw.Context context) => [
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    color: PdfColors.white,
                    fontSize: 10,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF017260),
                  ),
                  headerAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                    6: pw.Alignment.center,
                  },
                  columnWidths: {
                    0: const pw.FlexColumnWidth(11),
                    1: const pw.FlexColumnWidth(10),
                    2: const pw.FlexColumnWidth(10),
                    3: const pw.FlexColumnWidth(10),
                    4: const pw.FlexColumnWidth(10),
                    5: const pw.FlexColumnWidth(10),
                    6: const pw.FlexColumnWidth(10),
                  },
                  headers: [
                    '',
                    'NERACA AWAL',
                    'NERACA MUTASI',
                    'NERACA PERCOBAAN',
                    'NERACA SALDO',
                    'NERACA HASIL USAHA',
                    'NERACA AKHIR',
                  ],
                  data: [],
                ),
                pw.TableHelper.fromTextArray(
                  headerAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                    6: pw.Alignment.center,
                    7: pw.Alignment.center,
                    8: pw.Alignment.center,
                    9: pw.Alignment.center,
                    10: pw.Alignment.center,
                    11: pw.Alignment.center,
                    12: pw.Alignment.center,
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                    6: pw.Alignment.centerRight,
                    7: pw.Alignment.centerRight,
                    8: pw.Alignment.centerRight,
                    9: pw.Alignment.centerRight,
                    10: pw.Alignment.centerRight,
                    11: pw.Alignment.centerRight,
                    12: pw.Alignment.centerRight,
                  },
                  headers: [
                    "URAIAN",
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                    'D',
                    "K",
                  ],
                  data: rows
                      .map((row) => [
                            row.uraian ?? '',
                            formatMoney(row.neracaAwalD?.toString() ?? ''),
                            formatMoney(row.neracaAwalK?.toString() ?? ''),
                            formatMoney(row.neracaMutasiD?.toString() ?? ''),
                            formatMoney(row.neracaMutasiK?.toString() ?? ''),
                            formatMoney(row.neracaPercobaanD?.toString() ?? ''),
                            formatMoney(row.neracaPercobaanK?.toString() ?? ''),
                            formatMoney(row.neracaSaldoD?.toString() ?? ''),
                            formatMoney(row.neracaSaldoK?.toString() ?? ''),
                            formatMoney(
                                row.neracaHasilUsahaD?.toString() ?? ''),
                            formatMoney(
                                row.neracaHasilUsahaK?.toString() ?? ''),
                            formatMoney(row.neracaAkhirD?.toString() ?? ''),
                            formatMoney(row.neracaAkhirK?.toString() ?? ''),
                          ])
                      .toList(),
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    font: boldFont,
                    color: PdfColors.white,
                    fontSize: 10,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF017260),
                  ),
                  cellStyle: pw.TextStyle(
                    font: regularFont,
                    fontSize: 8,
                  ),
                  cellHeight: 30,
                  columnWidths: {
                    0: const pw.FlexColumnWidth(11),
                    1: const pw.FlexColumnWidth(5),
                    2: const pw.FlexColumnWidth(5),
                    3: const pw.FlexColumnWidth(5),
                    4: const pw.FlexColumnWidth(5),
                    5: const pw.FlexColumnWidth(5),
                    6: const pw.FlexColumnWidth(5),
                    7: const pw.FlexColumnWidth(5),
                    8: const pw.FlexColumnWidth(5),
                    9: const pw.FlexColumnWidth(5),
                    10: const pw.FlexColumnWidth(5),
                    11: const pw.FlexColumnWidth(5),
                    12: const pw.FlexColumnWidth(5),
                  },
                ),
              ]),
    );
    Uint8List pdfData = await pdf.save();

    String fileName =
        'Laporan_Neraca_Lajur_${controller.monthNow}_${controller.yearNow}.pdf';

    // await Printing.sharePdf(
    //   bytes: pdfData,
    //   filename: fileName,
    // );
    await Printing.layoutPdf(
      format: PdfPageFormat.a4,
      name: fileName,
      onLayout: (PdfPageFormat format) async => pdfData,
    );
  } catch (e) {
    Get.back();
    showInfoDialog(e.toString(), null);
  }

  Get.back();
}
