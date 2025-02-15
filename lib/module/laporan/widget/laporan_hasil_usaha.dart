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
                          doGenerateLaporanHasilUsaha(controller: controller);
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
                            fontWeight:
                                boldChecker(data["uraian"]) ? FontWeight.w600 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title: '${getNamaMonth(controller.monthNow)} - ${controller.yearNow}',
                      field: 'current_month',
                      type: PlutoColumnType.text(),
                      renderer: (rendererContext) {
                        var data = rendererContext.row.toJson();
                        return Text(
                          formatMoney(data["current_month"]),
                          style: TextStyle(
                            fontWeight:
                                boldChecker(data["uraian"]) ? FontWeight.w600 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.end,
                        );
                      },
                    ),
                    PlutoColumn(
                      titleTextAlign: PlutoColumnTextAlign.center,
                      backgroundColor: primaryColor,
                      title: subtractOneMonth(controller.monthNow, controller.yearNow),
                      field: 'last_month',
                      type: PlutoColumnType.text(),
                      textAlign: PlutoColumnTextAlign.right,
                      renderer: (rendererContext) {
                        var data = rendererContext.row.toJson();
                        return Text(
                          formatMoney(data["last_month"]),
                          style: TextStyle(
                            fontWeight:
                                boldChecker(data["uraian"]) ? FontWeight.w600 : FontWeight.w400,
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
                      'uraian': PlutoCell(value: 'PENJUALAN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'TUNAI'),
                      'current_month':
                          PlutoCell(value: result.data?.penjualan?.currentMonthCashSale),
                      'last_month': PlutoCell(value: result.data?.penjualan?.lastMonthCashSale),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'KREDIT'),
                      'current_month':
                          PlutoCell(value: result.data?.penjualan?.currentMonthCreditSale),
                      'last_month': PlutoCell(value: result.data?.penjualan?.lastMonthCreditSale),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'QRIS'),
                      'current_month':
                          PlutoCell(value: result.data?.penjualan?.currentMonthQrisSale),
                      'last_month': PlutoCell(value: result.data?.penjualan?.lastMonthQrisSale),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'TOTAL'),
                      'current_month':
                          PlutoCell(value: result.data?.penjualan?.totalCurrentMonthSale),
                      'last_month': PlutoCell(value: result.data?.penjualan?.totalLastMonthSale),
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
                      'uraian': PlutoCell(value: 'HARGA POKOK PENJUALAN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PERSEDIAAN AWAL'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.persediaanAwal),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.persediaanAwalLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PEMBELIAN TUNAI'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.pembelianTunai),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.pembelianTunaiLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PEMBELIAN KREDIT'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.pembelianKredit),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.pembelianKreditLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'RETUR PEMBELIAN'),
                      'current_month': PlutoCell(value: result.data?.hargaPokokPenjualan?.retur),
                      'last_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.returLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PEMBELIAN BERSIH'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.pembelianBersih),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.pembelianBersihLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'BARANG SIAP JUAL'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.barangSiapJual),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.barangSiapJualLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PERSEDIAAN AKHIR'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.persediaanAkhir),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.persediaanAkhirLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'HARGA POKOK PENJUALAN'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.hargaPokokPenjualan),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.hargaPokokPenjualanLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'HASIL USAHA KOTOR'),
                      'current_month':
                          PlutoCell(value: result.data?.hargaPokokPenjualan?.hasilUsahaKotor),
                      'last_month': PlutoCell(
                          value: result.data?.hargaPokokPenjualan?.hasilUsahaKotorLastMonth),
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
                      'uraian': PlutoCell(value: 'BEBAN OPERASIONAL'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'BEBAN GAJI/INSENTIF'),
                      'current_month': PlutoCell(value: result.data?.bebanOperasional?.bebanGaji),
                      'last_month':
                          PlutoCell(value: result.data?.bebanOperasional?.bebanGajiLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'UANG MAKAN KARYAWAN'),
                      'current_month': PlutoCell(value: result.data?.bebanOperasional?.uangMakan),
                      'last_month':
                          PlutoCell(value: result.data?.bebanOperasional?.uangMakanLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'THR KARYAWAN'),
                      'current_month': PlutoCell(value: result.data?.bebanOperasional?.thrKaryawan),
                      'last_month':
                          PlutoCell(value: result.data?.bebanOperasional?.thrKaryawanLastMonth),
                    }),

                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'BEBAN ADM. & UMUM'),
                      'current_month': PlutoCell(value: result.data?.bebanOperasional?.bebanAdm),
                      'last_month':
                          PlutoCell(value: result.data?.bebanOperasional?.bebanAdmLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'BEBAN PERLENGKAPAN'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.bebanPerlengkapan),
                      'last_month': PlutoCell(
                          value: result.data?.bebanOperasional?.bebanPerlengkapanLastMonth),
                    }),

                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'BEBAN PENY. INVENTARIS'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.bebanPenyInventaris),
                      'last_month': PlutoCell(
                          value: result.data?.bebanOperasional?.bebanPenyInventarisLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'BEBAN PENY. GEDUNG'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.bebanPenyGedung),
                      'last_month':
                          PlutoCell(value: result.data?.bebanOperasional?.bebanPenyGedungLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PEMELIHARAAN INVENTARIS'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.pemeliharaanInventaris),
                      'last_month': PlutoCell(
                          value: result.data?.bebanOperasional?.pemeliharaanInventarisLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PEMELIHARAAN GEDUNG'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.pemeliharaanGedung),
                      'last_month': PlutoCell(
                          value: result.data?.bebanOperasional?.pemeliharaanGedungLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PENGELUARAN LAIN-LAIN'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.pengeluaranLain),
                      'last_month':
                          PlutoCell(value: result.data?.bebanOperasional?.pengeluaranLainLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'TOTAL BEBAN OPERASIONAL'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.totalBebanOperasional),
                      'last_month': PlutoCell(
                          value: result.data?.bebanOperasional?.totalBebanOperasionalLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'HASIL USAHA BERSIH'),
                      'current_month':
                          PlutoCell(value: result.data?.bebanOperasional?.hasilUsahaBersih),
                      'last_month': PlutoCell(
                          value: result.data?.bebanOperasional?.hasilUsahaBersihLastMonth),
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
                      'uraian': PlutoCell(value: 'PENDAPATAN LAIN-LAIN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),

                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'TENANT'),
                      'current_month': PlutoCell(value: result.data?.pendapatanLain?.tenant),
                      'last_month': PlutoCell(value: result.data?.pendapatanLain?.tenantLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'PENDAPATAN LAIN-LAIN'),
                      'current_month': PlutoCell(value: result.data?.pendapatanLain?.lainLain),
                      'last_month':
                          PlutoCell(value: result.data?.pendapatanLain?.lainLainLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: 'TOTAL PENDAPATAN LAIN-LAIN'),
                      'current_month':
                          PlutoCell(value: result.data?.pendapatanLain?.totalPendapatanLain),
                      'last_month': PlutoCell(
                          value: result.data?.pendapatanLain?.totalPendapatanLainLastMonth),
                    }),
                    PlutoRow(cells: {
                      'no': PlutoCell(value: ''),
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),

                    //E
                    PlutoRow(cells: {
                      'no': PlutoCell(value: 'E'),
                      'uraian': PlutoCell(value: 'Sisa Hasil Usaha'),
                      'current_month':
                          PlutoCell(value: result.data?.sisaHasilUsaha?.sisaHasilUsaha),
                      'last_month':
                          PlutoCell(value: result.data?.sisaHasilUsaha?.sisaHasilUsahaLastMonth),
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
                              columnTextStyle:
                                  myTextTheme.titleSmall?.copyWith(color: neutralWhite) ??
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
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 224,
                  child: const ContainerError(),
                );
              }
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 224,
                child: const ContainerTidakAda(
                  entity: 'Laporan Hasil Usaha',
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
