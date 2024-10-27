// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LaporanRealisasiPendapatan extends StatefulWidget {
  final LaporanController controller;

  const LaporanRealisasiPendapatan({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LaporanRealisasiPendapatan> createState() =>
      _LaporanRealisasiPendapatanState();
}

class _LaporanRealisasiPendapatanState
    extends State<LaporanRealisasiPendapatan> {
  @override
  Widget build(BuildContext context) {
    LaporanController controller = widget.controller;
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: Provider.of<DrawerProvider>(context).isDrawerOpen
                  ? MediaQuery.of(context).size.width - 32 - 265
                  : MediaQuery.of(context).size.width - 32,
            ),
            child: ScreenTypeLayout.builder(
              mobile: (p0) => Column(
                children: [
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
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
                          Expanded(
                            child: BasePrimaryButton(
                              onPressed: () {
                                controller
                                    .onSearchLaporan(controller.idLaporan);
                                controller.update();
                              },
                              text: "Lihat Data",
                              isDense: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  BaseSecondaryButton(
                    onPressed: controller.hasData
                        ? () {
                            doGenerateLaporanRealisasiPendapatan(
                              controller: controller,
                            );
                          }
                        : null,
                    text: "Cetak Laporan",
                    suffixIcon: iconPrint,
                    // isDense: true,
                  ),
                ],
              ),
              desktop: (p0) => SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
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
                                controller
                                    .onSearchLaporan(controller.idLaporan);
                                controller.update();
                              },
                              text: "Lihat Data",
                              isDense: true,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      BaseSecondaryButton(
                        onPressed: controller.hasData
                            ? () {
                                doGenerateLaporanRealisasiPendapatan(
                                    controller: controller);
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
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          FutureBuilder(
            future: controller.dataFutureRealisasiPendapatan,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ContainerLoadingRole();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const ContainerError();
                } else if (snapshot.hasData) {
                  LaporanRealisasiPendapatanResult result = snapshot.data;

                  if (result.data != null) {
                    double rowHeight = 47.5;

                    List<PlutoColumn> columns = [
                      PlutoColumn(
                        width: 300,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        title: 'URAIAN',
                        field: 'uraian',
                        textAlign: PlutoColumnTextAlign.left,
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();

                          return Text(
                            trimString(data["uraian"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'JAN',
                        field: 'jan',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["jan"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'FEB',
                        field: 'feb',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["feb"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'MAR',
                        field: 'mar',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["mar"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'APR',
                        field: 'apr',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["apr"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'MEI',
                        field: 'mei',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["mei"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'JUN',
                        field: 'jun',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["jun"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'JUL',
                        field: 'jul',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["jul"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'AGU',
                        field: 'agu',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["agu"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'SEP',
                        field: 'sep',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["sep"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'OKT',
                        field: 'okt',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["okt"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'NOV',
                        field: 'nov',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["nov"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'DES',
                        field: 'des',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["des"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                      PlutoColumn(
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'JUMLAH',
                        field: 'jumlah',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Text(
                            formatMoney(data["jumlah"]),
                            style: TextStyle(
                              fontWeight:
                                  boldCheckerRealisasiPendapatan(data["uraian"])
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                            ),
                            textAlign: TextAlign.end,
                          );
                        },
                      ),
                    ];

                    List<PlutoRow> rows = [
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'PENJUALAN'),
                        'jan': PlutoCell(value: ''),
                        'feb': PlutoCell(value: ''),
                        'mar': PlutoCell(value: ''),
                        'apr': PlutoCell(value: ''),
                        'mei': PlutoCell(value: ''),
                        'jun': PlutoCell(value: ''),
                        'jul': PlutoCell(value: ''),
                        'agu': PlutoCell(value: ''),
                        'sep': PlutoCell(value: ''),
                        'okt': PlutoCell(value: ''),
                        'nov': PlutoCell(value: ''),
                        'des': PlutoCell(value: ''),
                        'jumlah': PlutoCell(value: ''),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Hasil Usaha Waserda'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[0].totalNilaiJual
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[1].totalNilaiJual
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[2].totalNilaiJual
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[3].totalNilaiJual
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[4].totalNilaiJual
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[5].totalNilaiJual
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[6].totalNilaiJual
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[7].totalNilaiJual
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[8].totalNilaiJual
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[9].totalNilaiJual
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[10].totalNilaiJual
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.hasilUsahaWaserda?.data?[11].totalNilaiJual
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pendapatan?.hasilUsahaWaserda?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Pendapatan Lain-lain'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.pendapatanLainlain?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pendapatan?.pendapatanLainlain?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Retur Pembelian'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[0].totalNilaiBeli
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[1].totalNilaiBeli
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[2].totalNilaiBeli
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[3].totalNilaiBeli
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[4].totalNilaiBeli
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[5].totalNilaiBeli
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[6].totalNilaiBeli
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[7].totalNilaiBeli
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[8].totalNilaiBeli
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[9].totalNilaiBeli
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[10].totalNilaiBeli
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.returPembelian?.data?[11].totalNilaiBeli
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pendapatan?.returPembelian?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'JUMLAH'),
                        'jan': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[0]
                                .totalPendapatan
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[1]
                                .totalPendapatan
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[2]
                                .totalPendapatan
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[3]
                                .totalPendapatan
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[4]
                                .totalPendapatan
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[5]
                                .totalPendapatan
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[6]
                                .totalPendapatan
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[7]
                                .totalPendapatan
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[8]
                                .totalPendapatan
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[9]
                                .totalPendapatan
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[10]
                                .totalPendapatan
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pendapatan
                                ?.totalPendapatanPerBulan
                                ?.data?[11]
                                .totalPendapatan
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result.data?.pendapatan
                                ?.totalPendapatanPerBulan?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: ''),
                        'jan': PlutoCell(value: ''),
                        'feb': PlutoCell(value: ''),
                        'mar': PlutoCell(value: ''),
                        'apr': PlutoCell(value: ''),
                        'mei': PlutoCell(value: ''),
                        'jun': PlutoCell(value: ''),
                        'jul': PlutoCell(value: ''),
                        'agu': PlutoCell(value: ''),
                        'sep': PlutoCell(value: ''),
                        'okt': PlutoCell(value: ''),
                        'nov': PlutoCell(value: ''),
                        'des': PlutoCell(value: ''),
                        'jumlah': PlutoCell(value: ''),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'PENGELUARAN'),
                        'jan': PlutoCell(value: ''),
                        'feb': PlutoCell(value: ''),
                        'mar': PlutoCell(value: ''),
                        'apr': PlutoCell(value: ''),
                        'mei': PlutoCell(value: ''),
                        'jun': PlutoCell(value: ''),
                        'jul': PlutoCell(value: ''),
                        'agu': PlutoCell(value: ''),
                        'sep': PlutoCell(value: ''),
                        'okt': PlutoCell(value: ''),
                        'nov': PlutoCell(value: ''),
                        'des': PlutoCell(value: ''),
                        'jumlah': PlutoCell(value: ''),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Beban Gaji/ Insentif'),
                        'jan': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanGaji?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Uang Makan Karyawan'),
                        'jan': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.uangMakan?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'THR Karyawan'),
                        'jan': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.thr?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Beban Adm. & Umum'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanAdmUmum?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanAdmUmum?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Beban Perlengkapan'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPerlengkapan?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.bebanPerlengkapan?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Beban Peny. Inventaris'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanInventaris?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Beban Peny. Gedung'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.bebanPenyusutanGedung?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Pemeliharaan Inventaris'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanInventaris?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'Pemeliharaan Gedung'),
                        'jan': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[0].nominal
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[1].nominal
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[2].nominal
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[3].nominal
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[4].nominal
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[5].nominal
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[6].nominal
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[7].nominal
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[8].nominal
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[9].nominal
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[10].nominal
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.pemeliharaanGedung?.data?[11].nominal
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.pengeluaran?.pemeliharaanGedung?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'JUMLAH'),
                        'jan': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[0]
                                .totalPengeluaran
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[1]
                                .totalPengeluaran
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[2]
                                .totalPengeluaran
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[3]
                                .totalPengeluaran
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[4]
                                .totalPengeluaran
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[5]
                                .totalPengeluaran
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[6]
                                .totalPengeluaran
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[7]
                                .totalPengeluaran
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[8]
                                .totalPengeluaran
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[9]
                                .totalPengeluaran
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[10]
                                .totalPengeluaran
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result
                                .data
                                ?.pengeluaran
                                ?.totalPengeluaraanPerBulan
                                ?.data?[11]
                                .totalPengeluaran
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result.data?.pengeluaran
                                ?.totalPengeluaraanPerBulan?.jumlah
                                .toString())),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: ''),
                        'jan': PlutoCell(value: ''),
                        'feb': PlutoCell(value: ''),
                        'mar': PlutoCell(value: ''),
                        'apr': PlutoCell(value: ''),
                        'mei': PlutoCell(value: ''),
                        'jun': PlutoCell(value: ''),
                        'jul': PlutoCell(value: ''),
                        'agu': PlutoCell(value: ''),
                        'sep': PlutoCell(value: ''),
                        'okt': PlutoCell(value: ''),
                        'nov': PlutoCell(value: ''),
                        'des': PlutoCell(value: ''),
                        'jumlah': PlutoCell(value: ''),
                      }),
                      PlutoRow(cells: {
                        'uraian':
                            PlutoCell(value: 'SISA HASIL USAHA SEBELUM PAJAK'),
                        'jan': PlutoCell(value: ''),
                        'feb': PlutoCell(value: ''),
                        'mar': PlutoCell(value: ''),
                        'apr': PlutoCell(value: ''),
                        'mei': PlutoCell(value: ''),
                        'jun': PlutoCell(value: ''),
                        'jul': PlutoCell(value: ''),
                        'agu': PlutoCell(value: ''),
                        'sep': PlutoCell(value: ''),
                        'okt': PlutoCell(value: ''),
                        'nov': PlutoCell(value: ''),
                        'des': PlutoCell(value: ''),
                        'jumlah': PlutoCell(value: ''),
                      }),
                      PlutoRow(cells: {
                        'uraian': PlutoCell(value: 'JUMLAH'),
                        'jan': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[0].sisaHasilUsaha
                                .toString())),
                        'feb': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[1].sisaHasilUsaha
                                .toString())),
                        'mar': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[2].sisaHasilUsaha
                                .toString())),
                        'apr': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[3].sisaHasilUsaha
                                .toString())),
                        'mei': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[4].sisaHasilUsaha
                                .toString())),
                        'jun': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[5].sisaHasilUsaha
                                .toString())),
                        'jul': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[6].sisaHasilUsaha
                                .toString())),
                        'agu': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[7].sisaHasilUsaha
                                .toString())),
                        'sep': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[8].sisaHasilUsaha
                                .toString())),
                        'okt': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[9].sisaHasilUsaha
                                .toString())),
                        'nov': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[10].sisaHasilUsaha
                                .toString())),
                        'des': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.data?[11].sisaHasilUsaha
                                .toString())),
                        'jumlah': PlutoCell(
                            value: trimString(result
                                .data?.sisaHasilUsaha?.jumlah
                                .toString())),
                      }),
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
                                "Realisasi Anggaran Pendapatan dan Biaya",
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
                          'TAHUN ${controller.yearNow}',
                          style: myTextTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ScreenTypeLayout.builder(
                          mobile: (p0) => SizedBox(
                            height: MediaQuery.of(context).size.height -
                                AppBar().preferredSize.height -
                                292,
                            width: 1600,
                            child: PlutoGrid(
                              noRowsWidget: SizedBox(
                                height: MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height -
                                    224,
                                child: const ContainerTidakAda(
                                  entity: 'Laporan Hasil Usaha',
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
                              columns: columns,
                              rows: rows,
                            ),
                          ),
                          desktop: (p0) => SizedBox(
                            height: MediaQuery.of(context).size.height -
                                AppBar().preferredSize.height -
                                292,
                            child: PlutoGrid(
                              noRowsWidget: SizedBox(
                                height: MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height -
                                    224,
                                child: const ContainerTidakAda(
                                  entity: 'Laporan Hasil Usaha',
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
                              columns: columns,
                              rows: rows,
                            ),
                          ),
                        )
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
                    entity: 'Laporan Hasil Usaha',
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
