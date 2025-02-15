// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LaporanNeracaLajur extends StatefulWidget {
  final LaporanController controller;

  const LaporanNeracaLajur({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LaporanNeracaLajur> createState() => _LaporanNeracaLajurState();
}

class _LaporanNeracaLajurState extends State<LaporanNeracaLajur> {
  @override
  Widget build(BuildContext context) {
    LaporanController controller = widget.controller;
    return Column(
      children: [
        SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: Provider.of<DrawerProvider>(context).isDrawerOpen
                  ? MediaQuery.of(context).size.width - 32 - 265
                  : MediaQuery.of(context).size.width - 32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 500,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: BaseDropdownButton<Month>(
                          sortItem: false,
                          label: "Bulan",
                          itemAsString: (item) => item.monthAsString(),
                          items: Year.fromJson(monthData).months,
                          value: Month(
                            id: controller.monthNow,
                            month: trimString(getNamaMonth(controller.monthNow)),
                          ),
                          onChanged: (value) {
                            controller.monthNow = value?.id ?? 1;
                            controller.update();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: BaseDropdownButton<int>(
                          sortItem: false,
                          label: "Tahun",
                          items: controller.yearData,
                          value: controller.yearNow,
                          itemAsString: (item) => item.toString(),
                          onChanged: (value) {
                            controller.yearNow = value ?? 2025;
                            controller.update();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      BasePrimaryButton(
                        onPressed: () {
                          controller.onSearchLaporan(controller.idLaporan);
                          controller.update();
                        },
                        text: "Lihat Data",
                        isDense: true,
                      ),
                    ],
                  ),
                ),
                BaseSecondaryButton(
                  onPressed: controller.hasData
                      ? () {
                          doGenerateLaporanNeracaLajur(controller: controller);
                        }
                      : null,
                  text: "Cetak Laporan",
                  suffixIcon: iconPrint,
                  isDense: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        FutureBuilder(
          future: controller.dataFutureNeracaLajur,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ContainerLoadingRole();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const ContainerError();
              } else if (snapshot.hasData) {
                LaporanNeracaLajurModel result = snapshot.data;
                DataNeraca dataNeraca = result.data?.dataNeraca ?? DataNeraca();
                TotalNeraca dataTotal = result.data?.totalNeraca ?? TotalNeraca();

                if (result.data != null) {
                  double rowHeight = 47.5;

                  List<PlutoColumn> columns = [
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      width: 400,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      title: 'URAIAN',
                      field: 'uraian',
                      textAlign: PlutoColumnTextAlign.left,
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "D",
                      field: 'neraca_awal_d',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "K",
                      field: 'neraca_awal_k',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "D",
                      field: 'neraca_mutasi_d',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "K",
                      field: 'neraca_mutasi_k',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "D",
                      field: 'neraca_percobaan_d',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "K",
                      field: 'neraca_percobaan_k',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "D",
                      field: 'neraca_saldo_d',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "K",
                      field: 'neraca_saldo_k',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "D",
                      field: 'neraca_hasil_usaha_d',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "K",
                      field: 'neraca_hasil_usaha_k',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "D",
                      field: 'neraca_akhir_d',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: "K",
                      field: 'neraca_akhir_k',
                      type: PlutoColumnType.number(
                        locale: "id",
                      ),
                    ),
                  ];

                  List<PlutoRow> rows = [
                    //A
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'KAS'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.kas?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.kas?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(value: dataNeraca.kas?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(value: dataNeraca.kas?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.kas?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.kas?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.kas?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.kas?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d': PlutoCell(value: dataNeraca.kas?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k': PlutoCell(value: dataNeraca.kas?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.kas?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.kas?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BANK BRI'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.bankBri?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.bankBri?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(value: dataNeraca.bankBri?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(value: dataNeraca.bankBri?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.bankBri?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.bankBri?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.bankBri?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.bankBri?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bankBri?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.bankBri?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.bankBri?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.bankBri?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PIUTANG DAGANG'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.piutangDagang?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.piutangDagang?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.piutangDagang?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PERSEDIAAN'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.persediaan?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.persediaan?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.persediaan?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.persediaan?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.persediaan?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.persediaan?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.persediaan?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.persediaan?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.persediaan?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.persediaan?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.persediaan?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.persediaan?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGHAPUSAN PERSEDIAAN'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(
                          value: dataNeraca.penghapusanPersediaan?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.penghapusanPersediaan?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.penghapusanPersediaan?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'INVENTARIS'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.inventaris?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.inventaris?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.inventaris?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.inventaris?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.inventaris?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.inventaris?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.inventaris?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.inventaris?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.inventaris?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.inventaris?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.inventaris?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.inventaris?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'AKUM. PENY. INVENTARIS'),
                      'neraca_awal_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanInventaris?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'GEDUNG'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.gedung?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.gedung?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(value: dataNeraca.gedung?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(value: dataNeraca.gedung?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.gedung?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.gedung?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.gedung?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.gedung?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.gedung?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.gedung?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.gedung?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.gedung?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'AKUM. PENY. GEDUNG'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.akumulasiPenyusutanGedung?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.akumulasiPenyusutanGedung?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(
                          value: dataNeraca.akumulasiPenyusutanGedung?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UTANG DAGANG'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.utangDagang?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.utangDagang?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.utangDagang?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.utangDagang?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.utangDagang?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UTANG DARI SP'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.utangSp?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.utangSp?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(value: dataNeraca.utangSp?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(value: dataNeraca.utangSp?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.utangSp?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.utangSp?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.utangSp?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.utangSp?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.utangSp?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.utangSp?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.utangSp?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.utangSp?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL TIDAK TETAP (R/C)'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.modalTidakTetap?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL DISETOR'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.modalDisetor?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.modalDisetor?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.modalDisetor?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.modalDisetor?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'USAHA LAIN-LAIN TOKO'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.usahaLainToko?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.usahaLainToko?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.usahaLainToko?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL UNIT TOKO'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.modalUnitToko?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.modalUnitToko?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.modalUnitToko?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'SHU TH. 2023'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2023?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2023?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.shuTh2023?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.shuTh2023?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.shuTh2023?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.shuTh2023?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.shuTh2023?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.shuTh2023?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.shuTh2023?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.shuTh2023?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.shuTh2023?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.shuTh2023?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'SHU TH. 2024'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2024?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2024?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.shuTh2024?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.shuTh2024?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.shuTh2024?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.shuTh2024?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.shuTh2024?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.shuTh2024?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.shuTh2024?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.shuTh2024?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.shuTh2024?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.shuTh2024?.neracaAkhir?.kredit),
                    }),
                    if (dataNeraca.shuTh2025 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2025?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2025?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2025?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2025?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2025?.neracaAkhir?.kredit),
                      }),

                    if (dataNeraca.shuTh2026 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2026?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2026?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2026?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2026?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2026?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2027 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2027?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2027?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2027?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2027?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2027?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2028 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2028?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2028?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2028?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2028?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2028?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2029 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2029?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2029?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2029?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2029?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2029?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2030 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2030?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2030?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2030?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2030?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2030?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2031 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2031?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2031?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2031?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2031?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2031?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2032 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2032?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2032?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2032?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2032?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2032?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2033 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2033?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2033?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2033?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2033?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2033?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2034 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2034?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2034?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2034?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2034?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2034?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2035 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2035?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2035?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2035?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2035?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2035?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2036 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2036?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2036?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2036?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2036?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2036?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2037 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2037?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2037?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2037?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2037?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2037?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2038 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2038?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2038?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2038?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2038?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2038?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2039 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2039?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2039?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2039?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2039?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2039?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2040 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2040?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2040?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2040?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2040?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2040?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2041 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2041?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2041?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2041?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2041?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2041?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2042 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2042?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2042?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2042?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2042?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2042?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2043 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2043?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2043?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2043?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2043?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2043?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2044 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2044?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2044?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2044?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2044?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2044?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2045 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2045?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2045?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2045?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2045?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2045?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2046 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2046?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2046?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2046?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2046?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2046?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2047 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2047?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2047?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2047?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2047?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2047?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2048 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2048?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2048?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2048?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2048?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2048?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2049 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2049?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2049?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2049?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2049?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2049?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2050 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2050?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2050?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2050?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2050?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2050?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2051 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2051?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2051?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2051?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2051?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2051?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2052 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2052?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2052?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2052?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2052?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2052?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2053 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2053?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2053?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2053?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2053?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2053?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2054 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2054?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2054?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2054?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2054?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2054?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2055 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2055?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2055?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2055?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2055?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2055?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2056 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2056?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2056?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2056?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2056?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2056?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2057 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2057?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2057?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2057 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2057?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2057?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2057?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2058 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2058?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2058?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2058?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2058?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2058?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2059 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2059?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2059?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2059?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2059?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2059?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2060 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2060?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2060?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2060?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2060?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2060?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2061 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2061?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2061?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2061?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2061?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2061?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2062 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2062?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2062?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2062?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2062?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2062?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2063 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2063?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2063?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2063?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2063?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2063?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2064 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2064?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2064?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2064?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2064?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2064?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2065 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2065?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2065?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2065?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2065?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2065?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2066 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2066?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2066?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2066?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2066?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2066?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2067 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2067?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2067?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2067?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2067?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2067?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2068 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2068?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2068?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2068?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2068?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2068?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2069 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2069?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2069?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2069?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2069?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2069?.neracaAkhir?.kredit),
                      }),
                    if (dataNeraca.shuTh2070 != null)
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'SHU TH. 2025'),
                        'neraca_awal_d': PlutoCell(value: dataNeraca.shuTh2070?.neracaAwal?.debit),
                        'neraca_awal_k': PlutoCell(value: dataNeraca.shuTh2070?.neracaAwal?.kredit),
                        'neraca_mutasi_d':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaMutasi?.debit),
                        'neraca_mutasi_k':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaMutasi?.kredit),
                        'neraca_percobaan_d':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaPercobaan?.debit),
                        'neraca_percobaan_k':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaPercobaan?.kredit),
                        'neraca_saldo_d':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaSaldo?.debit),
                        'neraca_saldo_k':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaSaldo?.kredit),
                        'neraca_hasil_usaha_d':
                            PlutoCell(value: dataNeraca.shuTh2070?.hasilUsaha?.debit),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: dataNeraca.shuTh2070?.hasilUsaha?.kredit),
                        'neraca_akhir_d':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaAkhir?.debit),
                        'neraca_akhir_k':
                            PlutoCell(value: dataNeraca.shuTh2070?.neracaAkhir?.kredit),
                      }),

                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENJUALAN TUNAI'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.penjualanTunai?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.penjualanTunai?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.penjualanTunai?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENJUALAN KREDIT'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.penjualanKredit?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.penjualanKredit?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.penjualanKredit?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENJUALAN QRIS'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.penjualanQris?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.penjualanQris?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.penjualanQris?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENDAPATAN SEWA'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pendapatanSewa?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENDAPATAN LAIN-LAIN'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pendapatanLain?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pendapatanLain?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pendapatanLain?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMBELIAN TUNAI'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pembelianTunai?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pembelianTunai?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pembelianTunai?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMBELIAN KREDIT'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pembelianKredit?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pembelianKredit?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pembelianKredit?.neracaAkhir?.kredit),
                    }),

                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'RETUR PEMBELIAN'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.bankBri?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.bankBri?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(value: dataNeraca.bankBri?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(value: dataNeraca.bankBri?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.bankBri?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.bankBri?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.bankBri?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.bankBri?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bankBri?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.bankBri?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.bankBri?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.bankBri?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN GAJI'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.bebanGaji?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.bebanGaji?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.bebanGaji?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.bebanGaji?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.bebanGaji?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.bebanGaji?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.bebanGaji?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.bebanGaji?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bebanGaji?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.bebanGaji?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.bebanGaji?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.bebanGaji?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UANG MAKAN'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.uangMakan?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.uangMakan?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.uangMakan?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.uangMakan?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.uangMakan?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.uangMakan?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataNeraca.uangMakan?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataNeraca.uangMakan?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.uangMakan?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.uangMakan?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataNeraca.uangMakan?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataNeraca.uangMakan?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'THR KARYAWAN'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.thrKaryawan?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataNeraca.thrKaryawan?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.thrKaryawan?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.thrKaryawan?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.thrKaryawan?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN ADM. & UMUM'),
                      'neraca_awal_d': PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.bebanAdmUmum?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN PERLENGKAPAN TOKO'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.bebanPerlengkapan?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN PENY. INVENTARIS'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanInventaris?.neracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanInventaris?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.hasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanInventaris?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN PENY. GEDUNG'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(
                          value: dataNeraca.bebanPenyusutanGedung?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.bebanPenyusutanGedung?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.bebanPenyusutanGedung?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMELIHARAAN INVENTARIS'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(
                          value: dataNeraca.pemeliharaanInventaris?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.pemeliharaanInventaris?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pemeliharaanInventaris?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMELIHARAAN GEDUNG'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pemeliharaanGedung?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGELUARAN LAIN-LAIN'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pengeluaranLain?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGELUARAN PUSAT LAIN'),
                      'neraca_awal_d':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaAwal?.debit),
                      'neraca_awal_k':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaAwal?.kredit),
                      'neraca_mutasi_d':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaMutasi?.debit),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaMutasi?.kredit),
                      'neraca_percobaan_d':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaPercobaan?.debit),
                      'neraca_percobaan_k': PlutoCell(
                          value: dataNeraca.pengeluaranPusatLain?.neracaPercobaan?.kredit),
                      'neraca_saldo_d':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaSaldo?.debit),
                      'neraca_saldo_k':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaSaldo?.kredit),
                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.hasilUsaha?.debit),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.hasilUsaha?.kredit),
                      'neraca_akhir_d':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaAkhir?.debit),
                      'neraca_akhir_k':
                          PlutoCell(value: dataNeraca.pengeluaranPusatLain?.neracaAkhir?.kredit),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'TOTAL'),
                      'neraca_awal_d': PlutoCell(value: dataTotal.totalNeracaAwal?.debit),
                      'neraca_awal_k': PlutoCell(value: dataTotal.totalNeracaAwal?.kredit),
                      'neraca_mutasi_d': PlutoCell(value: dataTotal.totalNeracaMutasi?.debit),
                      'neraca_mutasi_k': PlutoCell(value: dataTotal.totalNeracaMutasi?.kredit),
                      'neraca_percobaan_d': PlutoCell(value: dataTotal.totalNeracaPercobaan?.debit),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataTotal.totalNeracaPercobaan?.kredit),
                      'neraca_saldo_d': PlutoCell(value: dataTotal.totalNeracaSaldo?.debit),
                      'neraca_saldo_k': PlutoCell(value: dataTotal.totalNeracaSaldo?.kredit),
                      'neraca_hasil_usaha_d': PlutoCell(value: dataTotal.totalHasilUsaha?.debit),
                      'neraca_hasil_usaha_k': PlutoCell(value: dataTotal.totalHasilUsaha?.kredit),
                      'neraca_akhir_d': PlutoCell(value: dataTotal.totalNeracaAkhir?.debit),
                      'neraca_akhir_k': PlutoCell(value: dataTotal.totalNeracaAkhir?.kredit),
                    }),
                  ];

                  List<PlutoColumnGroup> columnsGroup = [
                    PlutoColumnGroup(
                      backgroundColor: primaryColor,
                      title: "NERACA AWAL",
                      fields: [
                        "neraca_awal_d",
                        "neraca_awal_k",
                      ],
                    ),
                    PlutoColumnGroup(
                      backgroundColor: primaryColor,
                      title: "NERACA MUTASI",
                      fields: [
                        "neraca_mutasi_d",
                        "neraca_mutasi_k",
                      ],
                    ),
                    PlutoColumnGroup(
                      backgroundColor: primaryColor,
                      title: "NERACA PERCOBAAN",
                      fields: [
                        "neraca_percobaan_d",
                        "neraca_percobaan_k",
                      ],
                    ),
                    PlutoColumnGroup(
                      backgroundColor: primaryColor,
                      title: "NERACA SALDO",
                      fields: [
                        "neraca_saldo_d",
                        "neraca_saldo_k",
                      ],
                    ),
                    PlutoColumnGroup(
                      backgroundColor: primaryColor,
                      title: "NERACA HASIL USAHA",
                      fields: [
                        "neraca_hasil_usaha_d",
                        "neraca_hasil_usaha_k",
                      ],
                    ),
                    PlutoColumnGroup(
                      backgroundColor: primaryColor,
                      title: "NERACA AKHIR",
                      fields: [
                        "neraca_akhir_d",
                        "neraca_akhir_k",
                      ],
                    ),
                  ];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Neraca Lajur",
                              textAlign: TextAlign.center,
                              style: myTextTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '${getNamaMonth(controller.monthNow).toUpperCase()} - ${controller.yearNow}',
                        style: myTextTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            292,
                        child: PlutoGrid(
                          noRowsWidget: SizedBox(
                            height: MediaQuery.of(context).size.height -
                                AppBar().preferredSize.height -
                                224,
                            child: const ContainerTidakAda(
                              entity: 'Laporan Neraca Lajur',
                            ),
                          ),
                          onLoaded: (event) {
                            if (rows.isNotEmpty) {
                              controller.hasData = true;
                              controller.update();
                            }
                          },
                          mode: PlutoGridMode.select,
                          configuration: PlutoGridConfiguration(
                            columnSize: const PlutoGridColumnSizeConfig(
                              autoSizeMode: PlutoAutoSizeMode.scale,
                            ),
                            style: PlutoGridStyleConfig(
                              rowHeight: 47.5,
                              columnTextStyle:
                                  myTextTheme.titleSmall?.copyWith(color: neutralWhite) ??
                                      const TextStyle(),
                              gridBorderColor: blueGray50,
                              gridBorderRadius: BorderRadius.circular(8),
                            ),
                            localeText: configLocale,
                          ),
                          columnGroups: columnsGroup,
                          columns: columns,
                          rows: rows,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const ContainerTidakAdaLaporan();
                }
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 224,
                  child: const ContainerError(),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 224,
                child: const ContainerTidakAda(
                  entity: 'Laporan Neraca Lajur',
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
