import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/aktivitas_stock_model.dart';
import 'package:ksu_budidaya/module/stock_opname/aktivitas_stock/controller/aktivitas_stock_controller.dart';
import 'package:ksu_budidaya/module/stock_opname/aktivitas_stock/widget/generate_aktivitas_stock.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class AktivitasStockView extends StatefulWidget {
  const AktivitasStockView({Key? key}) : super(key: key);

  Widget build(context, AktivitasStockController controller) {
    controller.view = this;

    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aktivitas Stock",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 250,
                                child: SearchForm(
                                  label: "ID Product",
                                  enabled: true,
                                  suffixIcon: iconBarcodeScanner,
                                  textEditingController: controller.supplierNameController,
                                  items: (search) => controller.getDetailSuggestions(
                                    search,
                                    ProductDatabase.productResult.data?.dataProduct,
                                  ),
                                  itemBuilder: (context, dataPembelian) {
                                    return ListTile(
                                      title: Text(
                                          "${trimString(dataPembelian.idProduct)} - ${trimString(dataPembelian.nmProduct)}"),
                                    );
                                  },
                                  onChanged: (value) {
                                    controller.update();
                                  },
                                  onEditComplete: () async {
                                    var data = ProductDatabase.productResult.data?.dataProduct;
                                    for (var i = 0; i < (data?.length ?? 0); i++) {
                                      if (trimString(data?[i].idProduct) ==
                                          trimString(controller.supplierNameController.text)) {
                                        controller.update();
                                      }
                                    }
                                  },
                                  onSelected: (data) async {
                                    controller.supplierNameController.text =
                                        trimString(data.idProduct);
                                    controller.update();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              BasePrimaryButton(
                                onPressed: () {
                                  controller.page = "1";
                                  controller.field = null;
                                  controller.dataFuture = controller.cariDataStockOpname();
                                  controller.update();

                                  controller.update();
                                },
                                text: "Cari Data",
                                isDense: true,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                            ],
                          ),
                          BaseSecondaryButton(
                            onPressed: () {
                              generatePdfAktivitasStock(controller: controller);
                            },
                            text: "Cetak",
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
                    future: controller.dataFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ContainerLoadingRole();
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const ContainerError();
                        } else if (snapshot.hasData) {
                          AktivitasStockModel result = snapshot.data;
                          controller.dataStockOpname = result.data ?? DataAktivitasStock();
                          List<dynamic> listData =
                              controller.dataStockOpname.toJson()["data_aktivitas"] ?? [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            columns.addAll(
                              List.generate(
                                controller.listRoleView.length,
                                (index) {
                                  if (controller.listRoleView[index] == "aktivitas") {
                                    return PlutoColumn(
                                        backgroundColor: primaryColor,
                                        filterHintText: "Cari ${controller.listRoleView[index]}",
                                        title: convertTitle(
                                          controller.listRoleView[index],
                                        ),
                                        field: controller.listRoleView[index],
                                        type: (controller.listRoleView[index] == "tg_aktivitas" ||
                                                controller.listRoleView[index] ==
                                                    "tg_update_aktivitas")
                                            ? PlutoColumnType.date(
                                                format: 'dd/MM/yyyy HH:mm:ss',
                                              )
                                            : PlutoColumnType.text(),
                                        renderer: (rendererContext) {
                                          return CardLabel(
                                            cardColor: rendererContext
                                                        .row
                                                        .cells[controller.listRoleView[index]]
                                                        ?.value ==
                                                    "Penjualan"
                                                ? red50
                                                : rendererContext
                                                            .row
                                                            .cells[controller.listRoleView[index]]
                                                            ?.value ==
                                                        "Pembelian"
                                                    ? green50
                                                    : blue50,
                                            cardTitle: convertTitle(
                                              rendererContext
                                                  .row.cells[controller.listRoleView[index]]?.value,
                                            ),
                                            cardTitleColor: rendererContext
                                                        .row
                                                        .cells[controller.listRoleView[index]]
                                                        ?.value ==
                                                    "Penjualan"
                                                ? red900
                                                : rendererContext
                                                            .row
                                                            .cells[controller.listRoleView[index]]
                                                            ?.value ==
                                                        "Pembelian"
                                                    ? green900
                                                    : blue900,
                                            cardBorderColor: rendererContext
                                                        .row
                                                        .cells[controller.listRoleView[index]]
                                                        ?.value ==
                                                    "Penjualan"
                                                ? red900
                                                : rendererContext
                                                            .row
                                                            .cells[controller.listRoleView[index]]
                                                            ?.value ==
                                                        "Pembelian"
                                                    ? green900
                                                    : blue900,
                                          );
                                        });
                                  } else {
                                    return PlutoColumn(
                                      backgroundColor: primaryColor,
                                      filterHintText: "Cari ${controller.listRoleView[index]}",
                                      title: convertTitle(
                                        controller.listRoleView[index],
                                      ),
                                      field: controller.listRoleView[index],
                                      type: (controller.listRoleView[index] == "tg_aktivitas" ||
                                              controller.listRoleView[index] ==
                                                  "tg_update_aktivitas")
                                          ? PlutoColumnType.date(
                                              format: 'dd/MM/yyyy HH:mm:ss',
                                            )
                                          : PlutoColumnType.text(),
                                    );
                                  }
                                },
                              ),
                            );

                            columns.add(
                              PlutoColumn(
                                width: 150,
                                backgroundColor: primaryColor,
                                frozen: PlutoColumnFrozen.end,
                                title: "AKSI",
                                field: "Aksi",
                                filterHintText: "",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  Map<String, dynamic> dataRow = rendererContext.row.cells
                                      .map((key, value) => MapEntry(key, value.value));
                                  return BaseSecondaryButton(
                                    onPressed: () {
                                      Map<String, dynamic> dataRow = rendererContext.row.toJson();

                                      if (rendererContext.row.cells['aktivitas']?.value ==
                                          "Penjualan") {
                                        router.push(
                                          Uri(
                                            path: "/stock-opname/aktivitas-stock/detail",
                                            queryParameters: {
                                              'id': trimString(dataRow["id_aktivitas"].toString())
                                            },
                                          ).toString(),
                                        );
                                      }
                                    },
                                    text: "Detail",
                                    isDense: true,
                                    suffixIcon: iconChevronDown,
                                  );
                                },
                              ),
                            );

                            List<dynamic> listDataWithIndex =
                                List.generate(listData.length, (index) {
                              return {
                                ...listData[index],
                                'persistentIndex': index + 1,
                              };
                            });
                            rows = listDataWithIndex.map((item) {
                              Map<String, PlutoCell> cells = {};
                              cells['Aksi'] = PlutoCell(
                                value: null,
                              );

                              for (String column in controller.listRoleView) {
                                if (item.containsKey(column)) {
                                  cells[column] = PlutoCell(
                                    value: trimStringStrip(item[column]),
                                  );
                                }
                              }

                              return PlutoRow(cells: cells);
                            }).toList();

                            return SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  144 -
                                  16,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: 'Aktivitas Stock',
                                ),
                                mode: PlutoGridMode.select,
                                onLoaded: (event) {
                                  event.stateManager.setShowColumnFilter(true);
                                },
                                onSorted: (event) {
                                  if (event.column.field != "Aksi") {
                                    controller.isAsc = !controller.isAsc;
                                    controller.field = event.column.field;
                                    controller.update();
                                    controller.dataFuture = controller.cariDataStockOpname(
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
                                createFooter: (stateManager) {
                                  return FooterTableWidget(
                                    page: controller.page,
                                    itemPerpage: controller.size,
                                    maxPage: controller.dataStockOpname.paging?.totalPage ?? 0,
                                    onChangePage: (value) {
                                      controller.page = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataStockOpname(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataStockOpname(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    totalRow: controller.dataStockOpname.paging?.totalItem ?? 0,
                                    onPressLeft: () {
                                      if (int.parse(controller.page) > 1) {
                                        controller.page =
                                            (int.parse(controller.page) - 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.cariDataStockOpname(
                                          isAsc: controller.isAsc,
                                          field: controller.field,
                                        );
                                        controller.update();
                                      }
                                    },
                                    onPressRight: () {
                                      if (int.parse(controller.page) <
                                          (result.data?.paging?.totalPage ?? 0)) {
                                        controller.page =
                                            (int.parse(controller.page) + 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.cariDataStockOpname(
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
                              entity: 'Aktivitas Stock',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Aktivitas Stock",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<AktivitasStockView> createState() => AktivitasStockController();
}
