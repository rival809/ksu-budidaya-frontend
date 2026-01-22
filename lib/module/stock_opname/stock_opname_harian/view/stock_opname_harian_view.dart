import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class StockOpnameHarianView extends StatefulWidget {
  final String? stocktakeType;

  const StockOpnameHarianView({super.key, this.stocktakeType});

  Widget build(BuildContext context, StockOpnameHarianController controller) {
    controller.view = this;
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => StockOpnameMobileContent(
        controller: controller,
      ),
      desktop: (BuildContext context) => _buildDesktopView(context, controller),
    );
  }

  Widget _buildDesktopView(BuildContext context, StockOpnameHarianController controller) {
    return BodyContainer(
      contentBody: Container(
        color: neutralWhite,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (context.canPop())
                      BackButton(
                        onPressed: () {
                          if (context.canPop()) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    const SizedBox(width: 16),
                    Text(
                      controller.stocktakeType == "BULANAN"
                          ? "Stock Opname Bulanan"
                          : "Stock Opname Harian",
                      style: myTextTheme.headlineLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Summary Cards
                FutureBuilder(
                  future: controller.itemsFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    double total = controller.sessionData?.statistics?.totalItems ?? 0;
                    double sudahSO = controller.sessionData?.statistics?.countedItems ?? 0;
                    double belumSO = controller.sessionData?.statistics?.pendingItems ?? 0;

                    return Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: blue600,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total",
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    total.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: myTextTheme.headlineLarge?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sudah SO",
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    sudahSO.toString(),
                                    style: myTextTheme.headlineLarge?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: red600,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Belum SO",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    belumSO.toString(),
                                    style: myTextTheme.headlineLarge?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16.0),
                        // Action Buttons
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE001" ||
                                  UserDatabase.userDatabase.data?.roleData?.idRole ==
                                      "ROLE004") ...[
                                BaseSecondaryButton(
                                  onPressed: () {
                                    generatePdfStockOpname(controller: controller);
                                  },
                                  text: "Print",
                                  suffixIcon: iconPrint,
                                  isDense: true,
                                ),
                                if (!["COMPLETED", "CANCELLED"]
                                    .contains(controller.sessionData?.status))
                                  const SizedBox(width: 16),
                                if (!["COMPLETED", "CANCELLED"]
                                    .contains(controller.sessionData?.status))
                                  BaseSecondaryButton(
                                    onPressed: () {
                                      controller.navigateToReviewCekUlang();
                                    },
                                    text: "Cek Ulang",
                                    isDense: true,
                                  ),
                                if (!["COMPLETED", "CANCELLED"]
                                    .contains(controller.sessionData?.status))
                                  const SizedBox(width: 16),
                                if (!["COMPLETED", "CANCELLED"]
                                    .contains(controller.sessionData?.status))
                                  BaseDangerButton(
                                    onPressed: () {
                                      showDialogBase(
                                        content: DialogAlasan(onConfirm: (String alasan) async {
                                          await controller.cancleSo(reason: alasan);
                                        }),
                                      );
                                    },
                                    text: "Batalkan SO",
                                    isDense: true,
                                  ),
                                if (!["COMPLETED", "CANCELLED"]
                                    .contains(controller.sessionData?.status))
                                  const SizedBox(width: 16),
                              ],
                              if (!["COMPLETED", "CANCELLED"]
                                  .contains(controller.sessionData?.status))
                                BasePrimaryButton(
                                  onPressed: () {
                                    showDialogBase(
                                      content: DialogSubmit(onConfirm: (String alasan) async {
                                        if (UserDatabase.userDatabase.data?.roleData?.idRole ==
                                                "ROLE001" ||
                                            UserDatabase.userDatabase.data?.roleData?.idRole ==
                                                "ROLE004") {
                                          await controller.submitSoManager(reason: alasan);
                                        } else {
                                          await controller.submitSo(reason: alasan);
                                        }
                                      }),
                                    );
                                  },
                                  text: "Simpan Data SO",
                                  isDense: true,
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                // Table
                FutureBuilder(
                  future: controller.itemsFuture,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ContainerLoadingRole();
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const ContainerError();
                      } else if (snapshot.hasData) {
                        ListStocktakeItemsModel result = snapshot.data;
                        controller.itemsData = result.data ?? DataListStocktakeItems();
                        List<DetailListStocktakeItemsilDataListStocktakeItems>? listData =
                            controller.itemsData.data ?? [];

                        if (listData.isNotEmpty) {
                          List<PlutoRow> rows = [];
                          List<PlutoColumn> columns = [];

                          // Calculate totals
                          double totalStokSistemJml = 0;
                          double totalStokSistemHarga = 0;
                          double totalStokFisikJml = 0;
                          double totalStokFisikHarga = 0;
                          double totalSelisihJml = 0;
                          double totalSelisihHarga = 0;

                          for (var item in listData) {
                            totalStokSistemJml += item.stokSistem ?? 0;
                            totalStokSistemHarga += item.valuasi?.valuasiSistemJual ?? 0;
                            totalStokFisikJml += item.stokFisik ?? 0;
                            totalStokFisikHarga += item.valuasi?.valuasiFisikJual ?? 0;
                            totalSelisihJml += item.selisih ?? 0;
                            totalSelisihHarga += item.valuasi?.valuasiSelisihJual ?? 0;
                          }

                          // Create columns
                          columns.addAll([
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "ID Produk",
                              field: "id_product",
                              type: PlutoColumnType.text(),
                              width: 150,
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Nama Produk",
                              field: "nm_product",
                              type: PlutoColumnType.text(),
                              width: 200,
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Divisi",
                              field: "nm_divisi",
                              type: PlutoColumnType.text(),
                              width: 120,
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Jml",
                              field: "stok_sistem_jml",
                              type: PlutoColumnType.number(),
                              width: 80,
                              footerRenderer: (rendererContext) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  color: primaryColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    formatMoney(totalStokSistemJml.toStringAsFixed(0)),
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Harga Jual",
                              field: "stok_sistem_harga",
                              type: PlutoColumnType.number(format: "#,###"),
                              width: 120,
                              footerRenderer: (rendererContext) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  color: primaryColor,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formatMoney(totalStokSistemHarga.toInt()),
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Jml",
                              field: "stok_fisik_jml",
                              type: PlutoColumnType.number(),
                              width: 80,
                              footerRenderer: (rendererContext) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  color: primaryColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    formatMoney(totalStokFisikJml.toStringAsFixed(0)),
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Harga Jual",
                              field: "stok_fisik_harga",
                              type: PlutoColumnType.number(format: "#,###"),
                              width: 120,
                              footerRenderer: (rendererContext) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  color: primaryColor,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formatMoney(totalStokFisikHarga.toInt()),
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Jml",
                              field: "selisih_jml",
                              type: PlutoColumnType.number(),
                              width: 80,
                              footerRenderer: (rendererContext) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  color: primaryColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    formatMoney(totalSelisihJml.toStringAsFixed(0)),
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Harga Jual",
                              field: "selisih_harga",
                              type: PlutoColumnType.number(format: "#,###"),
                              width: 120,
                              footerRenderer: (rendererContext) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  color: primaryColor,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formatMoney(totalSelisihHarga.toInt()),
                                    style: myTextTheme.titleSmall?.copyWith(
                                      color: neutralWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PlutoColumn(
                              backgroundColor: primaryColor,
                              title: "Keterangan",
                              field: "notes",
                              type: PlutoColumnType.text(),
                              width: 100,
                              enableEditingMode: false,
                              renderer: (rendererContext) {
                                bool isCounted =
                                    rendererContext.row.cells['is_counted']?.value ?? false;

                                if (!isCounted) {
                                  return const CardLabel(
                                    cardColor: red50,
                                    cardTitle: "Belum SO",
                                    cardTitleColor: red600,
                                    cardBorderColor: red600,
                                  );
                                } else {
                                  return const CardLabel(
                                    cardColor: green50,
                                    cardTitle: "Sudah SO",
                                    cardTitleColor: primaryGreen,
                                    cardBorderColor: primaryGreen,
                                  );
                                }
                              },
                            ),
                            if (!["COMPLETED", "CANCELLED"]
                                .contains(controller.sessionData?.status)) ...[
                              PlutoColumn(
                                width: 150,
                                backgroundColor: primaryColor,
                                frozen: PlutoColumnFrozen.end,
                                title: "Aksi",
                                field: "aksi",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  bool isCounted =
                                      rendererContext.row.cells['is_counted']?.value ?? false;
                                  int stokFisik =
                                      rendererContext.row.cells['stok_fisik_jml']?.value ?? 0;

                                  if (!isCounted) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: blue500,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: BaseSecondaryButton(
                                        onPressed: () {
                                          String namaProduk =
                                              rendererContext.row.cells['nm_product']?.value ?? '';
                                          String idItem = rendererContext
                                                  .row.cells['id_stocktake_item']?.value ??
                                              '';
                                          controller.showDialogSO(
                                            namaProduk: namaProduk,
                                            idItem: idItem,
                                          );
                                        },
                                        text: "Lakukan SO",
                                        isDense: true,
                                      ),
                                    );
                                  } else if (stokFisik == 0) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: red500,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: BaseSecondaryButton(
                                        onPressed: () {
                                          String namaProduk =
                                              rendererContext.row.cells['nm_product']?.value ?? '';
                                          String idItem = rendererContext
                                                  .row.cells['id_stocktake_item']?.value ??
                                              '';
                                          String notes =
                                              rendererContext.row.cells['notes_value']?.value ?? '';
                                          controller.showDialogSO(
                                            namaProduk: namaProduk,
                                            idItem: idItem,
                                            initialStokFisik: stokFisik.toString(),
                                            initialNotes: notes,
                                          );
                                        },
                                        text: "Edit Data SO",
                                        isDense: true,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: primaryGreen,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: BaseSecondaryButton(
                                        onPressed: () {
                                          String namaProduk =
                                              rendererContext.row.cells['nm_product']?.value ?? '';
                                          String idItem = rendererContext
                                                  .row.cells['id_stocktake_item']?.value ??
                                              '';
                                          String notes =
                                              rendererContext.row.cells['notes_value']?.value ?? '';
                                          controller.showDialogSO(
                                            namaProduk: namaProduk,
                                            idItem: idItem,
                                            initialStokFisik: stokFisik.toString(),
                                            initialNotes: notes,
                                          );
                                        },
                                        text: "Edit Data SO",
                                        isDense: true,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ]);

                          // Create rows
                          rows = listData.map((item) {
                            Map<String, PlutoCell> cells = {};

                            cells['id_stocktake_item'] =
                                PlutoCell(value: item.idStocktakeItem?.toString() ?? '');
                            cells['id_product'] = PlutoCell(value: trimString(item.idProduct));
                            cells['nm_product'] = PlutoCell(value: trimString(item.nmProduct));
                            cells['nm_divisi'] = PlutoCell(value: trimString(item.nmDivisi));
                            cells['stok_sistem_jml'] = PlutoCell(value: item.stokSistem ?? 0);
                            cells['stok_sistem_harga'] = PlutoCell(
                              value: item.valuasi?.valuasiSistemJual ?? 0,
                            );
                            cells['stok_fisik_jml'] = PlutoCell(value: item.stokFisik ?? 0);
                            cells['stok_fisik_harga'] = PlutoCell(
                              value: item.valuasi?.valuasiFisikJual ?? 0,
                            );
                            cells['selisih_jml'] = PlutoCell(value: item.selisih ?? 0);
                            cells['selisih_harga'] = PlutoCell(
                              value: item.valuasi?.valuasiSelisihJual ?? 0,
                            );
                            cells['notes'] = PlutoCell(value: trimString(item.notes));
                            cells['notes_value'] = PlutoCell(value: trimString(item.notes));
                            cells['is_counted'] = PlutoCell(value: item.isCounted ?? false);
                            if (!["COMPLETED", "CANCELLED"]
                                .contains(controller.sessionData?.status)) {
                              cells['aksi'] = PlutoCell(value: null);
                            }

                            return PlutoRow(cells: cells);
                          }).toList();

                          return SizedBox(
                            height: MediaQuery.of(context).size.height -
                                AppBar().preferredSize.height -
                                200,
                            child: PlutoGrid(
                              noRowsWidget: const ContainerTidakAda(
                                entity: 'Data Stock Opname',
                              ),
                              mode: PlutoGridMode.select,
                              onLoaded: (event) {
                                event.stateManager.setShowColumnFilter(true);
                              },
                              onSorted: (event) {
                                if (event.column.field != "aksi") {
                                  controller.isAsc = !controller.isAsc;
                                  controller.field = event.column.field;
                                  controller.update();
                                  controller.itemsFuture = controller.fetchStocktakeItems(
                                    isAsc: controller.isAsc,
                                    field: event.column.field,
                                  );
                                  controller.update();
                                }
                              },
                              configuration: PlutoGridConfiguration(
                                columnSize: const PlutoGridColumnSizeConfig(
                                  autoSizeMode: PlutoAutoSizeMode.scale,
                                ),
                                style: PlutoGridStyleConfig(
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
                              columnGroups: [
                                PlutoColumnGroup(
                                  title: 'Stock Sistem',
                                  backgroundColor: primaryColor,
                                  fields: ['stok_sistem_jml', 'stok_sistem_harga'],
                                ),
                                PlutoColumnGroup(
                                  title: 'Stock Fisik',
                                  backgroundColor: primaryColor,
                                  fields: ['stok_fisik_jml', 'stok_fisik_harga'],
                                ),
                                PlutoColumnGroup(
                                  title: 'Selisih',
                                  backgroundColor: primaryColor,
                                  fields: ['selisih_jml', 'selisih_harga'],
                                ),
                              ],
                              createFooter: (stateManager) {
                                return FooterTableWidget(
                                  page: controller.page,
                                  itemPerpage: controller.size,
                                  maxPage: controller.itemsData.pagination?.totalPages ?? 0,
                                  onChangePage: (value) {
                                    controller.page = trimString(value);
                                    controller.update();
                                    controller.itemsFuture = controller.fetchStocktakeItems(
                                      isAsc: controller.isAsc,
                                      field: controller.field,
                                    );
                                    controller.update();
                                  },
                                  onChangePerPage: (value) {
                                    controller.page = "1";
                                    controller.size = trimString(value);
                                    controller.update();
                                    controller.itemsFuture = controller.fetchStocktakeItems(
                                      isAsc: controller.isAsc,
                                      field: controller.field,
                                    );
                                    controller.update();
                                  },
                                  totalRow: controller.itemsData.pagination?.total ?? 0,
                                  onPressLeft: () {
                                    if (int.parse(controller.page) > 1) {
                                      controller.page = (int.parse(controller.page) - 1).toString();
                                      controller.update();
                                      controller.itemsFuture = controller.fetchStocktakeItems(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    }
                                  },
                                  onPressRight: () {
                                    if (int.parse(controller.page) <
                                        (controller.itemsData.pagination?.totalPages ?? 0)) {
                                      controller.page = (int.parse(controller.page) + 1).toString();
                                      controller.update();
                                      controller.itemsFuture = controller.fetchStocktakeItems(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const ContainerTidakAda(
                            entity: 'Data Stock Opname',
                          );
                        }
                      } else {
                        return const ContainerError();
                      }
                    } else {
                      return const ContainerTidakAda(
                        entity: "Data Stock Opname",
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StockOpnameHarianView> createState() => StockOpnameHarianController();
}
