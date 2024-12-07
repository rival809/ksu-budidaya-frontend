// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/laporan/widget/generate_laporan_neraca_lajur.dart';
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
                            month:
                                trimString(getNamaMonth(controller.monthNow)),
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
                            controller.yearNow = value ?? 2023;
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
                LaporanHasilUsahaResult result = snapshot.data;

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
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BANK BRI'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PIUTANG DAGANG'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PERSEDIAAN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGHAPUSAN PERSEDIAAN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'INVENTARIS'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'AKUM. PENY. INVENTARIS'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'GEDUNG'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'AKUM. PENY. GEDUNG'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UTANG DAGANG'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UTANG DARI SP'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL TIDAK TETAP (R/C)'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL DISETOR'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'USAHA LAIN-LAIN TOKO'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL UNIT TOKO'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'SHU TH. 2023'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'SHU TH. 2024'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENJUALAN TUNAI'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENJUALAN KREDIT'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENJUALAN QRIS'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENDAPATAN SEWA'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENDAPATAN LAIN-LAIN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMBELIAN TUNAI'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMBELIAN KREDIT'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'AKUM. PENY. INVENTARIS'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'RETUR PEMBELIAN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN GAJI'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UANG MAKAN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'THR KARYAWAN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN ADM. & UMUM'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN PERLENGKAPAN TOKO'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN PENY. INVENTARIS'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BEBAN PENY. GEDUNG'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMELIHARAAN INVENTARIS'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PEMELIHARAAN GEDUNG'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGELUARAN LAIN-LAIN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGELUARAN PUSAT LAIN'),
                      'neraca_awal_d': PlutoCell(value: ''),
                      'neraca_awal_k': PlutoCell(value: ''),
                      'neraca_mutasi_d': PlutoCell(value: ''),
                      'neraca_mutasi_k': PlutoCell(value: ''),
                      'neraca_percobaan_d': PlutoCell(value: ''),
                      'neraca_percobaan_k': PlutoCell(value: ''),
                      'neraca_saldo_d': PlutoCell(value: ''),
                      'neraca_saldo_k': PlutoCell(value: ''),
                      'neraca_hasil_usaha_d': PlutoCell(value: ''),
                      'neraca_hasil_usaha_k': PlutoCell(value: ''),
                      'neraca_akhir_d': PlutoCell(value: ''),
                      'neraca_akhir_k': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'TOTAL'),
                      'neraca_awal_d': PlutoCell(value: 1000000),
                      'neraca_awal_k': PlutoCell(value: 1000000),
                      'neraca_mutasi_d': PlutoCell(value: 1000000),
                      'neraca_mutasi_k': PlutoCell(value: 1000000),
                      'neraca_percobaan_d': PlutoCell(value: 1000000),
                      'neraca_percobaan_k': PlutoCell(value: 1000000),
                      'neraca_saldo_d': PlutoCell(value: 1000000),
                      'neraca_saldo_k': PlutoCell(value: 1000000),
                      'neraca_hasil_usaha_d': PlutoCell(value: 1000000),
                      'neraca_hasil_usaha_k': PlutoCell(value: 1000000),
                      'neraca_akhir_d': PlutoCell(value: 1000000),
                      'neraca_akhir_k': PlutoCell(value: 1000000),
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
                              columnTextStyle: myTextTheme.titleSmall
                                      ?.copyWith(color: neutralWhite) ??
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
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      224,
                  child: const ContainerError(),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    224,
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
