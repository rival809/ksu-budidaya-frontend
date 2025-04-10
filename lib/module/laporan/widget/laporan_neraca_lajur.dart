// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/laporan/widget/excel/generate_excel_neraca_lajur.dart';
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
                Row(
                  children: [
                    BaseSecondaryButton(
                      onPressed: controller.hasData
                          ? () {
                              doGenerateExcelNeracaLajur(controller: controller);
                            }
                          : null,
                      text: "Unduh Excel",
                      suffixIcon: iconPrint,
                      isDense: true,
                    ),
                    const SizedBox(
                      width: 16.0,
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
                Map<String, DataNeraca?>? dataNeraca = result.data?.dataNeraca ?? {};
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
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
                        format: "#,###",
                      ),
                    ),
                  ];
                  List<PlutoRow> rows = [];

                  // Loop melalui setiap kategori dalam dataNeraca
                  dataNeraca.forEach((key, value) {
                    rows.add(
                      PlutoRow(cells: {
                        // Replace underscores in the key with spaces
                        'uraian': PlutoCell(
                            value: key.replaceAll('_', ' ').toUpperCase()), // Nama kategori

                        // Ambil data debit dan kredit dari setiap jenis neraca
                        'neraca_awal_d': PlutoCell(value: value?.neracaAwal?.debit?.toInt() ?? 0),
                        'neraca_awal_k': PlutoCell(value: value?.neracaAwal?.kredit?.toInt() ?? 0),

                        'neraca_mutasi_d':
                            PlutoCell(value: value?.neracaMutasi?.debit?.toInt() ?? 0),
                        'neraca_mutasi_k':
                            PlutoCell(value: value?.neracaMutasi?.kredit?.toInt() ?? 0),

                        'neraca_percobaan_d':
                            PlutoCell(value: value?.neracaPercobaan?.debit?.toInt() ?? 0),
                        'neraca_percobaan_k':
                            PlutoCell(value: value?.neracaPercobaan?.kredit?.toInt() ?? 0),

                        'neraca_saldo_d': PlutoCell(value: value?.neracaSaldo?.debit?.toInt() ?? 0),
                        'neraca_saldo_k':
                            PlutoCell(value: value?.neracaSaldo?.kredit?.toInt() ?? 0),

                        'neraca_hasil_usaha_d':
                            PlutoCell(value: value?.hasilUsaha?.debit?.toInt() ?? 0),
                        'neraca_hasil_usaha_k':
                            PlutoCell(value: value?.hasilUsaha?.kredit?.toInt() ?? 0),

                        'neraca_akhir_d': PlutoCell(value: value?.neracaAkhir?.debit?.toInt() ?? 0),
                        'neraca_akhir_k':
                            PlutoCell(value: value?.neracaAkhir?.kredit?.toInt() ?? 0),
                      }),
                    );
                  });

                  rows.add(
                    PlutoRow(cells: {
                      // Replace underscores in the key with spaces
                      'uraian': PlutoCell(value: "TOTAL"), // Nama kategori

                      // Ambil data debit?.toInt() dan kredit?.toInt() dari setiap jenis neraca
                      'neraca_awal_d':
                          PlutoCell(value: dataTotal.totalNeracaAwal?.debit?.toInt() ?? 0),
                      'neraca_awal_k':
                          PlutoCell(value: dataTotal.totalNeracaAwal?.kredit?.toInt() ?? 0),

                      'neraca_mutasi_d':
                          PlutoCell(value: dataTotal.totalNeracaMutasi?.debit?.toInt() ?? 0),
                      'neraca_mutasi_k':
                          PlutoCell(value: dataTotal.totalNeracaMutasi?.kredit?.toInt() ?? 0),

                      'neraca_percobaan_d':
                          PlutoCell(value: dataTotal.totalNeracaPercobaan?.debit?.toInt() ?? 0),
                      'neraca_percobaan_k':
                          PlutoCell(value: dataTotal.totalNeracaPercobaan?.kredit?.toInt() ?? 0),

                      'neraca_saldo_d':
                          PlutoCell(value: dataTotal.totalNeracaSaldo?.debit?.toInt() ?? 0),
                      'neraca_saldo_k':
                          PlutoCell(value: dataTotal.totalNeracaSaldo?.kredit?.toInt() ?? 0),

                      'neraca_hasil_usaha_d':
                          PlutoCell(value: dataTotal.totalHasilUsaha?.debit?.toInt() ?? 0),
                      'neraca_hasil_usaha_k':
                          PlutoCell(value: dataTotal.totalHasilUsaha?.kredit?.toInt() ?? 0),

                      'neraca_akhir_d':
                          PlutoCell(value: dataTotal.totalNeracaAkhir?.debit?.toInt() ?? 0),
                      'neraca_akhir_k':
                          PlutoCell(value: dataTotal.totalNeracaAkhir?.kredit?.toInt() ?? 0),
                    }),
                  );

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
