// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LaporanHasilUsaha extends StatefulWidget {
  final LaporanController controller;

  const LaporanHasilUsaha({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LaporanHasilUsaha> createState() => _LaporanHasilUsahaState();
}

class _LaporanHasilUsahaState extends State<LaporanHasilUsaha> {
  @override
  Widget build(BuildContext context) {
    LaporanController controller = widget.controller;
    return FutureBuilder(
      future: controller.dataFutureHasilUsaha,
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
                  title: 'NO',
                  titleTextAlign: PlutoColumnTextAlign.center,
                  field: 'no',
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  width: 0,
                  renderer: (rendererContext) {
                    var data = rendererContext.row.toJson();

                    return Text(
                      trimString(data["no"]),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                PlutoColumn(
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
                        fontWeight: boldChecker(data["uraian"])
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
                  title:
                      '${getNamaMonth(controller.monthNow)} - ${controller.yearNow}',
                  field: 'current_month',
                  type: PlutoColumnType.text(),
                  renderer: (rendererContext) {
                    var data = rendererContext.row.toJson();
                    return Text(
                      formatMoney(data["current_month"]),
                      style: TextStyle(
                        fontWeight: boldChecker(data["uraian"])
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    );
                  },
                ),
                PlutoColumn(
                  titleTextAlign: PlutoColumnTextAlign.center,
                  backgroundColor: primaryColor,
                  title:
                      subtractOneMonth(controller.monthNow, controller.yearNow),
                  field: 'last_month',
                  type: PlutoColumnType.text(),
                  textAlign: PlutoColumnTextAlign.right,
                  renderer: (rendererContext) {
                    var data = rendererContext.row.toJson();
                    return Text(
                      formatMoney(data["last_month"]),
                      style: TextStyle(
                        fontWeight: boldChecker(data["uraian"])
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    );
                  },
                ),
              ];

              List<PlutoRow> rows = [
                //A
                PlutoRow(cells: {
                  'no': PlutoCell(value: 'A'),
                  'uraian': PlutoCell(value: 'Penjualan'),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Penjualan Tunai'),
                  'current_month': PlutoCell(
                      value: result.data?.penjualan?.currentMonthCashSale),
                  'last_month': PlutoCell(
                      value: result.data?.penjualan?.lastMonthCashSale),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Penjualan Kredit'),
                  'current_month': PlutoCell(
                      value: result.data?.penjualan?.currentMonthCreditSale),
                  'last_month': PlutoCell(
                      value: result.data?.penjualan?.lastMonthCreditSale),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Penjualan Kredit'),
                  'current_month': PlutoCell(
                      value: result.data?.penjualan?.currentMonthCreditSale),
                  'last_month': PlutoCell(
                      value: result.data?.penjualan?.lastMonthCreditSale),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Penjualan QRIS'),
                  'current_month': PlutoCell(
                      value: result.data?.penjualan?.currentMonthQrisSale),
                  'last_month': PlutoCell(
                      value: result.data?.penjualan?.lastMonthQrisSale),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'TOTAL'),
                  'current_month': PlutoCell(
                      value: result.data?.penjualan?.totalCurrentMonthSale),
                  'last_month': PlutoCell(
                      value: result.data?.penjualan?.totalLastMonthSale),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: ''),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                //B
                PlutoRow(cells: {
                  'no': PlutoCell(value: 'B'),
                  'uraian': PlutoCell(value: 'Harga Pokok Penjualan'),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Persediaan Awal'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.persediaanAwal),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.persediaanAwalLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pembelian Tunai'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.pembelianTunai),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.pembelianTunaiLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pembelian Kredit'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.pembelianKredit),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.pembelianKreditLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pembelian Bersih'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.pembelianBersih),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.pembelianBersihLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Barang Siap Jual'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.barangSiapJual),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.barangSiapJualLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Persediaan Akhir'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.persediaanAkhir),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.persediaanAkhirLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Harga Pokok Penjualan'),
                  'current_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.hargaPokokPenjualan),
                  'last_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan
                          ?.hargaPokokPenjualanLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Hasil Usaha Kotor'),
                  'current_month': PlutoCell(
                      value: result.data?.hargaPokokPenjualan?.hasilUsahaKotor),
                  'last_month': PlutoCell(
                      value: result
                          .data?.hargaPokokPenjualan?.hasilUsahaKotorLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: ''),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                //C
                PlutoRow(cells: {
                  'no': PlutoCell(value: 'C'),
                  'uraian': PlutoCell(value: 'Beban Operasional'),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Beban Gaji/ Insentif'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.bebanGaji),
                  'last_month': PlutoCell(
                      value: result.data?.bebanOperasional?.bebanGajiLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Uang Makan Karyawan'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.uangMakan),
                  'last_month': PlutoCell(
                      value: result.data?.bebanOperasional?.uangMakanLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'THR Karyawan'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.thrKaryawan),
                  'last_month': PlutoCell(
                      value:
                          result.data?.bebanOperasional?.thrKaryawanLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Tunjangan Pangan'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.tunjanganPangan),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.tunjanganPanganLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Beban Adm. & Umum'),
                  'current_month':
                      PlutoCell(value: result.data?.bebanOperasional?.bebanAdm),
                  'last_month': PlutoCell(
                      value: result.data?.bebanOperasional?.bebanAdmLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Beban Perlengkapan'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.bebanPerlengkapan),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.bebanPerlengkapanLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Tunjangan Kesehatan'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.tunjanganKesehatan),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.tunjanganKesehatanLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Beban Peny. Inventaris'),
                  'current_month': PlutoCell(
                      value:
                          result.data?.bebanOperasional?.bebanPenyInventaris),
                  'last_month': PlutoCell(
                      value: result.data?.bebanOperasional
                          ?.bebanPenyInventarisLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Beban Peny. Gedung'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.bebanPenyGedung),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.bebanPenyGedungLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pemeliharaan Inventaris'),
                  'current_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.pemeliharaanInventaris),
                  'last_month': PlutoCell(
                      value: result.data?.bebanOperasional
                          ?.pemeliharaanInventarisLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pemeliharaan Gedung'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.pemeliharaanGedung),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.pemeliharaanGedungLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pengeluaran Lain-lain'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.pengeluaranLain),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.pengeluaranLainLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Total Beban Operasional'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.bebanOperasional),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.bebanOperasionalLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Hasil Usaha Bersih'),
                  'current_month': PlutoCell(
                      value: result.data?.bebanOperasional?.hasilUsahaBersih),
                  'last_month': PlutoCell(
                      value: result
                          .data?.bebanOperasional?.hasilUsahaBersihLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: ''),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                //D
                PlutoRow(cells: {
                  'no': PlutoCell(value: 'D'),
                  'uraian': PlutoCell(value: 'Pendapatan Lain-lain'),
                  'current_month': PlutoCell(value: ''),
                  'last_month': PlutoCell(value: ''),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Jasa Bank'),
                  'current_month': PlutoCell(
                      value: result.data?.pendapatanLain?.penarikanBank),
                  'last_month': PlutoCell(
                      value:
                          result.data?.pendapatanLain?.penarikanBankLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Tenant'),
                  'current_month':
                      PlutoCell(value: result.data?.pendapatanLain?.tenant),
                  'last_month': PlutoCell(
                      value: result.data?.pendapatanLain?.tenantLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Pendapatan Lain-lain'),
                  'current_month':
                      PlutoCell(value: result.data?.pendapatanLain?.lainLain),
                  'last_month': PlutoCell(
                      value: result.data?.pendapatanLain?.lainLainLastMonth),
                }),
                PlutoRow(cells: {
                  'no': PlutoCell(value: ''),
                  'uraian': PlutoCell(value: 'Total Pendapatan Lain-Lain'),
                  'current_month': PlutoCell(
                      value: result.data?.pendapatanLain?.pendapatanLain),
                  'last_month': PlutoCell(
                      value:
                          result.data?.pendapatanLain?.pendapatanLainLastMonth),
                }),
                //E
                PlutoRow(cells: {
                  'no': PlutoCell(value: 'E'),
                  'uraian': PlutoCell(value: 'Sisa Hasil Usaha'),
                  'current_month': PlutoCell(
                      value: result.data?.sisaHasilUsaha?.sisaHasilUsaha),
                  'last_month': PlutoCell(
                      value:
                          result.data?.sisaHasilUsaha?.sisaHasilUsahaLastMonth),
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
                          "LAPORAN HASIL USAHA",
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
                    '${getNamaMonth(controller.monthNow)} - ${controller.yearNow}',
                    style: myTextTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        292,
                    width: 800,
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
    );
  }
}
