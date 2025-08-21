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
  List<PlutoRow> buildRowsActiva(
      DetailLaporanNeraca? current, DetailLaporanNeraca? previous) {
    final List<PlutoRow> rows = [];
    // ACTIVA LANCAR
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'ACTIVA LANCAR'),
      'current_month': PlutoCell(value: null),
      'last_month': PlutoCell(value: null),
    }));
    if (current?.aktivaLancar != null) {
      current!.aktivaLancar!.forEach((key, value) {
        rows.add(PlutoRow(cells: {
          'uraian': PlutoCell(
              value: key.toString().toUpperCase().replaceAll("_", " ")),
          'current_month': PlutoCell(value: value),
          'last_month': PlutoCell(value: previous?.aktivaLancar?[key]),
        }));
      });
      // rows.add(PlutoRow(cells: {
      //   'uraian': PlutoCell(value: 'JUMLAH'),
      //   'current_month': PlutoCell(value: current.aktivaLancar?['jumlah']),
      //   'last_month': PlutoCell(value: previous?.aktivaLancar?['jumlah']),
      // }));
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // ACTIVA TETAP
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'ACTIVA TETAP'),
      'current_month': PlutoCell(value: null),
      'last_month': PlutoCell(value: null),
    }));
    if (current?.aktivaTetap != null) {
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'INVENTARIS'),
        'current_month': PlutoCell(value: current?.aktivaTetap?.inventaris),
        'last_month': PlutoCell(value: previous?.aktivaTetap?.inventaris),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'GEDUNG'),
        'current_month': PlutoCell(value: current?.aktivaTetap?.gedung),
        'last_month': PlutoCell(value: previous?.aktivaTetap?.gedung),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'JUMLAH'),
        'current_month': PlutoCell(value: current?.aktivaTetap?.jumlah),
        'last_month': PlutoCell(value: previous?.aktivaTetap?.jumlah),
      }));
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // AKUMULASI PENYUSUTAN
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'AKUMULASI PENYUSUTAN'),
      'current_month': PlutoCell(value: null),
      'last_month': PlutoCell(value: null),
    }));
    if (current?.akumPenyusutan != null) {
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'INVENTARIS'),
        'current_month': PlutoCell(value: current?.akumPenyusutan?.inventaris),
        'last_month': PlutoCell(value: previous?.akumPenyusutan?.inventaris),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'GEDUNG'),
        'current_month': PlutoCell(value: current?.akumPenyusutan?.gedung),
        'last_month': PlutoCell(value: previous?.akumPenyusutan?.gedung),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'JUMLAH'),
        'current_month': PlutoCell(value: current?.akumPenyusutan?.jumlah),
        'last_month': PlutoCell(value: previous?.akumPenyusutan?.jumlah),
      }));
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // NILAI BUKU ACTIVA TETAP
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'NILAI BUKU ACTIVA TETAP'),
      'current_month': PlutoCell(value: current?.nilaiBukuAktiva),
      'last_month': PlutoCell(value: previous?.nilaiBukuAktiva),
    }));
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // ACTIVA LAIN
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'ACTIVA LAIN'),
      'current_month': PlutoCell(value: null),
      'last_month': PlutoCell(value: null),
    }));
    if (current?.aktivaLain != null) {
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'JUMLAH'),
        'current_month': PlutoCell(value: current?.aktivaLain?.jumlah),
        'last_month': PlutoCell(value: previous?.aktivaLain?.jumlah),
      }));
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // TOTAL ACTIVA
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'TOTAL ACTIVA'),
      'current_month': PlutoCell(value: current?.totalAktiva),
      'last_month': PlutoCell(value: previous?.totalAktiva),
    }));
    return rows;
  }

  List<PlutoRow> buildRowsPassiva(
      DetailLaporanNeraca? current, DetailLaporanNeraca? previous) {
    final List<PlutoRow> rows = [];
    // HUTANG LANCAR
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'HUTANG LANCAR'),
      'current_month': PlutoCell(value: null),
      'last_month': PlutoCell(value: null),
    }));
    if (current?.hutangLancar != null) {
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'HUTANG DAGANG'),
        'current_month': PlutoCell(value: current?.hutangLancar?.hutangDagang),
        'last_month': PlutoCell(value: previous?.hutangLancar?.hutangDagang),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'MODAL TIDAK TETAP'),
        'current_month':
            PlutoCell(value: current?.hutangLancar?.modalTidakTetap),
        'last_month': PlutoCell(value: previous?.hutangLancar?.modalTidakTetap),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'JUMLAH'),
        'current_month': PlutoCell(value: current?.hutangLancar?.jumlah),
        'last_month': PlutoCell(value: previous?.hutangLancar?.jumlah),
      }));
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // UTANG TOKO KE SP
    if (current?.utangDariSp != null) {
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'UTANG TOKO KE SP'),
        'current_month': PlutoCell(value: current?.utangDariSp?.utangDariSp),
        'last_month': PlutoCell(value: previous?.utangDariSp?.utangDariSp),
      }));
      rows.add(PlutoRow(cells: {
        'uraian': PlutoCell(value: 'JUMLAH'),
        'current_month': PlutoCell(value: current?.utangDariSp?.jumlah),
        'last_month': PlutoCell(value: previous?.utangDariSp?.jumlah),
      }));
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // DANA, MODAL, & SHU
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'DANA, MODAL, & SHU'),
      'current_month': PlutoCell(value: null),
      'last_month': PlutoCell(value: null),
    }));
    if (current?.danaModalShu != null) {
      current!.danaModalShu!.forEach((key, value) {
        rows.add(PlutoRow(cells: {
          'uraian': PlutoCell(
              value: key.toString().toUpperCase().replaceAll("_", " ")),
          'current_month': PlutoCell(value: value),
          'last_month': PlutoCell(value: previous?.danaModalShu?[key]),
        }));
      });
    }
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: ''),
      'current_month': PlutoCell(value: ''),
      'last_month': PlutoCell(value: ''),
    }));
    // TOTAL PASSIVA
    rows.add(PlutoRow(cells: {
      'uraian': PlutoCell(value: 'TOTAL PASSIVA'),
      'current_month': PlutoCell(value: current?.totalPasiva),
      'last_month': PlutoCell(value: previous?.totalPasiva),
    }));
    return rows;
  }

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
                            controller.dataFutureNeraca = null;
                            controller.hasData = false;
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
                            controller.dataFutureNeraca = null;
                            controller.hasData = false;
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
                LaporanNeracaModel result = snapshot.data;

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

                  // Build rows dynamically from API
                  List<PlutoRow> rowsActiva = buildRowsActiva(
                      result.data?.current, result.data?.previous);
                  List<PlutoRow> rowsPassiva = buildRowsPassiva(
                      result.data?.current, result.data?.previous);

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
