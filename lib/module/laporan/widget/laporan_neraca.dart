// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LaporanNeraca extends StatefulWidget {
  final LaporanController controller;

  const LaporanNeraca({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LaporanNeraca> createState() => _LaporanNeracaState();
}

class _LaporanNeracaState extends State<LaporanNeraca> {
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
                          doGenerateLaporanNeraca(controller: controller);
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
          future: controller.dataFutureNeraca,
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
                      renderer: (rendererContext) {
                        var data = rendererContext.row.toJson();
                        return Text(
                          trimString(data["uraian"]),
                          style: TextStyle(
                            fontWeight: boldCheckerNeraca(data["uraian"])
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        );
                      },
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.right,
                      title:
                          '${getNamaMonth(controller.monthNow)} -   ${controller.yearNow}',
                      field: 'current_month',
                      type: PlutoColumnType.text(),
                      renderer: (rendererContext) {
                        var data = rendererContext.row.toJson();
                        return Text(
                          formatMoney(data["current_month"]),
                          style: TextStyle(
                            fontWeight: boldCheckerNeraca(data["uraian"])
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
                      title: subtractOneMonth(
                          controller.monthNow, controller.yearNow),
                      field: 'last_month',
                      type: PlutoColumnType.text(),
                      renderer: (rendererContext) {
                        var data = rendererContext.row.toJson();
                        return Text(
                          formatMoney(data["last_month"]),
                          style: TextStyle(
                            fontWeight: boldCheckerNeraca(data["uraian"])
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                          textAlign: TextAlign.end,
                        );
                      },
                    ),
                  ];

                  List<PlutoRow> rowsActiva = [
                    //A
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'ACTIVA LANCAR'),
                      'current_month': PlutoCell(value: null),
                      'last_month': PlutoCell(value: null),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'KAS'),
                      'current_month': PlutoCell(value: 12000),
                      'last_month': PlutoCell(value: 12000),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'BRI 1'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PIUTANG ANGGOTA'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PERSEDIAAN BARANG'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'PENGHAPUSAN PERSEDIAAN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'ACTIVA TETAP'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'INVENTARIS'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'GEDUNG'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'AKUMULASI PENYUSUTAN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'INVENTARIS'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'GEDUNG'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'NILAI BUKU ACTIVA TETAP'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'ACTIVA LAIN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'TOTAL ACTIVA'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                  ];
                  List<PlutoRow> rowsPassiva = [
                    //A
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'HUTANG LANCAR'),
                      'current_month': PlutoCell(value: null),
                      'last_month': PlutoCell(value: null),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'HUTANG DAGANG'),
                      'current_month': PlutoCell(value: 12000),
                      'last_month': PlutoCell(value: 12000),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL TIDAK TETAP'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'UTANG TOKO KE SP'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'DANA, MODAL, & SHU'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'DANA USAHA LAIN-LAIN'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL DISETOR'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'MODAL UNIT TOKO'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'SHU TH. 2023'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'SHU TH. 2024'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'HUTANG DAGANG'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'JUMLAH'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: ''),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
                    }),
                    PlutoRow(cells: {
                      'uraian': PlutoCell(value: 'TOTAL PASSIVA'),
                      'current_month': PlutoCell(value: ''),
                      'last_month': PlutoCell(value: ''),
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
                              "Neraca",
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
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  292,
                              child: PlutoGrid(
                                noRowsWidget: SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      AppBar().preferredSize.height -
                                      224,
                                  child: const ContainerTidakAda(
                                    entity: 'Laporan Neraca',
                                  ),
                                ),
                                onLoaded: (event) {
                                  if (rowsActiva.isNotEmpty) {
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
                                    oddRowColor: neutralWhite,
                                    evenRowColor: gray50,
                                    columnTextStyle: myTextTheme.titleSmall
                                            ?.copyWith(color: neutralWhite) ??
                                        const TextStyle(),
                                    gridBorderColor: blueGray50,
                                    gridBorderRadius: BorderRadius.circular(8),
                                  ),
                                  localeText: configLocale,
                                ),
                                columns: columns,
                                rows: rowsActiva,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  292,
                              child: PlutoGrid(
                                noRowsWidget: SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      AppBar().preferredSize.height -
                                      224,
                                  child: const ContainerTidakAda(
                                    entity: 'Laporan Neraca',
                                  ),
                                ),
                                onLoaded: (event) {
                                  if (rowsPassiva.isNotEmpty) {
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
                                    oddRowColor: neutralWhite,
                                    evenRowColor: gray50,
                                    columnTextStyle: myTextTheme.titleSmall
                                            ?.copyWith(color: neutralWhite) ??
                                        const TextStyle(),
                                    gridBorderColor: blueGray50,
                                    gridBorderRadius: BorderRadius.circular(8),
                                  ),
                                  localeText: configLocale,
                                ),
                                columns: columns,
                                rows: rowsPassiva,
                              ),
                            ),
                          ),
                        ],
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
                  entity: 'Laporan Neraca',
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
