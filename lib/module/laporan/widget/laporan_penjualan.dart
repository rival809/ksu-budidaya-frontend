// ignore_for_file: camel_case_types
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/laporan/laporan_penjualan_model.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LaporanPenjualan extends StatefulWidget {
  final LaporanController controller;

  const LaporanPenjualan({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LaporanPenjualan> createState() => _LaporanPenjualanState();
}

class _LaporanPenjualanState extends State<LaporanPenjualan> {
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
                            child: BaseForm(
                              label: "Tanggal",
                              textEditingController: TextEditingController(
                                  text: controller.getDateByIndex(0) == null
                                      ? null
                                      : "${formatDateSlash(controller.getDateByIndex(0))} - ${formatDateSlash(controller.getDateByIndex(1))}"),
                              hintText: "Pilih Periode",
                              suffixIcon: iconCalendarMonth,
                              readOnly: true,
                              onTap: () async {
                                controller.dates = await showCalendarDatePicker2Dialog(
                                      context: context,
                                      config: CalendarDatePicker2WithActionButtonsConfig(
                                        calendarType: CalendarDatePicker2Type.range,
                                      ),
                                      dialogSize: const Size(325, 400),
                                      borderRadius: BorderRadius.circular(15),
                                    ) ??
                                    controller.dates;
                                controller.update();
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: BaseDropdownButton<String>(
                              sortItem: false,
                              label: "Metode Pembayaran",
                              items: const ["SEMUA", "TUNAI", "QRIS", "KREDIT"],
                              value: controller.selectedMetodePembayaran,
                              itemAsString: (item) => item,
                              onChanged: (value) {
                                setState(() {
                                  controller.selectedMetodePembayaran = value ?? "SEMUA";
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
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
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: BaseSecondaryButton(
                          onPressed: controller.hasData
                              ? () {
                                  doGenerateLaporanPenjualan(
                                    controller: controller,
                                  );
                                }
                              : null,
                          text: "Cetak PDF",
                          suffixIcon: iconPrint,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: BaseSecondaryButton(
                          onPressed: controller.hasData
                              ? () {
                                  doGenerateExcelPenjualan(
                                    controller: controller,
                                  );
                                }
                              : null,
                          text: "Cetak Excel",
                          suffixIcon: iconSave,
                        ),
                      ),
                    ],
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
                        width: 800,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: BaseForm(
                                label: "Tanggal",
                                textEditingController: TextEditingController(
                                    text: controller.getDateByIndex(0) == null
                                        ? null
                                        : "${formatDateSlash(controller.getDateByIndex(0))} - ${formatDateSlash(controller.getDateByIndex(1))}"),
                                hintText: "Pilih Periode",
                                suffixIcon: iconCalendarMonth,
                                readOnly: true,
                                onTap: () async {
                                  controller.dates = await showCalendarDatePicker2Dialog(
                                        context: context,
                                        config: CalendarDatePicker2WithActionButtonsConfig(
                                          calendarType: CalendarDatePicker2Type.range,
                                        ),
                                        dialogSize: const Size(325, 400),
                                        borderRadius: BorderRadius.circular(15),
                                      ) ??
                                      controller.dates;
                                  controller.update();
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            SizedBox(
                              width: 200,
                              child: BaseDropdownButton<String>(
                                sortItem: false,
                                label: "Metode Pembayaran",
                                items: const ["SEMUA", "TUNAI", "QRIS", "KREDIT"],
                                value: controller.selectedMetodePembayaran,
                                itemAsString: (item) => item,
                                onChanged: (value) {
                                  setState(() {
                                    controller.selectedMetodePembayaran = value ?? "SEMUA";
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
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
                                    doGenerateLaporanPenjualan(controller: controller);
                                  }
                                : null,
                            text: "Cetak PDF",
                            suffixIcon: iconPrint,
                            isDense: true,
                          ),
                          const SizedBox(width: 16.0),
                          BaseSecondaryButton(
                            onPressed: controller.hasData
                                ? () {
                                    doGenerateExcelPenjualan(controller: controller);
                                  }
                                : null,
                            text: "Cetak Excel",
                            suffixIcon: iconSave,
                            isDense: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          FutureBuilder(
            future: controller.dataFuturePenjualan,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ContainerLoadingRole();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const ContainerError();
                } else if (snapshot.hasData) {
                  LaporanPenjualanModel result = snapshot.data;

                  if (result.data != null && result.data!.data != null) {
                    double rowHeight = 47.5;

                    List<PlutoColumn> columns = [
                      PlutoColumn(
                        width: 200,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        title: 'PRODUK',
                        field: 'produk',
                        textAlign: PlutoColumnTextAlign.left,
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Container(
                            alignment: Alignment.centerLeft,
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            padding: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(8.0),
                            child: Text(
                              trimString(data["produk"]),
                              style: TextStyle(
                                fontWeight: data["produk"].toString().contains("TOTAL PENJUALAN")
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          );
                        },
                      ),
                      PlutoColumn(
                        width: 150,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        title: 'METODE PEMBAYARAN',
                        field: 'metodePembayaran',
                        suppressedAutoSize: true,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          String metode = data["metodePembayaran"] ?? "";

                          Color bgColor = Colors.grey.shade100;
                          Color textColor = Colors.black;

                          if (metode == "TUNAI") {
                            bgColor = Colors.green.shade100;
                            textColor = Colors.green.shade800;
                          } else if (metode == "QRIS") {
                            bgColor = Colors.blue.shade100;
                            textColor = Colors.blue.shade800;
                          } else if (metode == "KREDIT") {
                            bgColor = Colors.orange.shade100;
                            textColor = Colors.orange.shade800;
                          }

                          return Container(
                            alignment: Alignment.center,
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            padding: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(8.0),
                            child: metode.isNotEmpty
                                ? Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      metode,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox(),
                          );
                        },
                      ),
                      PlutoColumn(
                        width: 120,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'JUMLAH',
                        field: 'jumlah',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Container(
                            alignment: Alignment.centerRight,
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            padding: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(8.0),
                            child: Text(
                              formatMoney(data["jumlah"]),
                              style: TextStyle(
                                fontWeight: data["produk"].toString().contains("TOTAL PENJUALAN")
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          );
                        },
                      ),
                      PlutoColumn(
                        width: 150,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'MODAL',
                        field: 'modal',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Container(
                            alignment: Alignment.centerRight,
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            padding: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(8.0),
                            child: Text(
                              formatMoney(data["modal"]),
                              style: TextStyle(
                                fontWeight: data["produk"].toString().contains("TOTAL PENJUALAN")
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          );
                        },
                      ),
                      PlutoColumn(
                        width: 150,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'HASIL PENJUALAN',
                        field: 'hasilPenjualan',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Container(
                            alignment: Alignment.centerRight,
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            padding: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(8.0),
                            child: Text(
                              formatMoney(data["hasilPenjualan"]),
                              style: TextStyle(
                                fontWeight: data["produk"].toString().contains("TOTAL PENJUALAN")
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          );
                        },
                      ),
                      PlutoColumn(
                        width: 150,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: 'KEUNTUNGAN',
                        field: 'keuntungan',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Container(
                            alignment: Alignment.centerRight,
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            padding: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(8.0),
                            child: Text(
                              formatMoney(data["keuntungan"]),
                              style: TextStyle(
                                fontWeight: data["produk"].toString().contains("TOTAL PENJUALAN")
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          );
                        },
                      ),
                      PlutoColumn(
                        width: 100,
                        cellPadding: EdgeInsets.zero,
                        backgroundColor: primaryColor,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.right,
                        title: '%',
                        field: 'persentase',
                        type: PlutoColumnType.text(),
                        renderer: (rendererContext) {
                          var data = rendererContext.row.toJson();
                          return Container(
                            color: data["produk"].toString().contains("TOTAL PENJUALAN")
                                ? gray100
                                : null,
                            height:
                                data["produk"].toString().contains("TOTAL PENJUALAN") ? 50 : null,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${formatMoney(data["persentase"])}%",
                              style: TextStyle(
                                fontWeight: data["produk"].toString().contains("TOTAL PENJUALAN")
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ];

                    // Create rows from data
                    List<PlutoRow> rows = [];

                    // Add product rows
                    for (var item in result.data!.data!) {
                      rows.add(PlutoRow(cells: {
                        'produk': PlutoCell(value: item.produk ?? ''),
                        'metodePembayaran': PlutoCell(value: item.metodePembayaran ?? ''),
                        'jumlah': PlutoCell(value: item.jumlah ?? 0.0),
                        'modal': PlutoCell(value: item.modal ?? 0.0),
                        'hasilPenjualan': PlutoCell(value: item.hasilPenjualan ?? 0.0),
                        'keuntungan': PlutoCell(value: item.keuntungan ?? 0.0),
                        'persentase': PlutoCell(value: item.persentase ?? 0.0),
                      }));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Report Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Laporan Penjualan",
                                style: myTextTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${formatDateSlash(result.data!.periode?.startDate)} - ${formatDateSlash(result.data!.periode?.endDate)}",
                                style: myTextTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        // Data Table
                        SizedBox(
                          height: (rows.length * rowHeight) + 300,
                          child: PlutoGrid(
                            columns: columns,
                            noRowsWidget: const ContainerTidakAda(
                              entity: 'Penjualan',
                            ),
                            mode: PlutoGridMode.select,
                            rows: rows,
                            onLoaded: (PlutoGridOnLoadedEvent event) {
                              event.stateManager.setShowColumnFilter(true);
                              if (rows.isNotEmpty) {
                                controller.hasData = true;
                                controller.update();
                              }
                            },
                            configuration: PlutoGridConfiguration(
                              columnSize: const PlutoGridColumnSizeConfig(
                                autoSizeMode: PlutoAutoSizeMode.scale,
                              ),
                              style: PlutoGridStyleConfig(
                                rowHeight: rowHeight,
                                columnTextStyle:
                                    myTextTheme.titleSmall?.copyWith(color: neutralWhite) ??
                                        const TextStyle(),
                                gridBorderColor: blueGray50,
                                gridBorderRadius: BorderRadius.circular(8),
                              ),
                              localeText: configLocale,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const ContainerTidakAdaLaporan();
                  }
                } else {
                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height - AppBar().preferredSize.height - 224,
                    child: const ContainerError(),
                  );
                }
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 224,
                  child: const ContainerTidakAda(
                    entity: 'Laporan Penjualan',
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
