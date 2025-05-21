import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_take_model.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take/controller/stock_take_controller.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take/widget/generate_stocktake.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class StockTakeView extends StatefulWidget {
  const StockTakeView({Key? key}) : super(key: key);

  Widget build(context, StockTakeController controller) {
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
                    "Stocktake",
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
                            children: [
                              SizedBox(
                                width: 250,
                                child: BaseDropdownButton(
                                  itemAsString: (value) => value,
                                  sortItem: false,
                                  items: const ["SEMUA", "SELISIH", "SEIMBANG"],
                                  value: controller.dropdown,
                                  onChanged: (value) {
                                    if (value == "SEMUA") {
                                      controller.isSelisih = null;
                                      controller.update();
                                    } else if (value == "SELISIH") {
                                      controller.isSelisih = true;
                                      controller.update();
                                    } else {
                                      controller.isSelisih = false;
                                      controller.update();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              BasePrimaryButton(
                                onPressed: () async {
                                  controller.dataFuture = controller.cariDataStockOpname();
                                  controller.update();
                                },
                                text: "Lihat Data",
                                isDense: true,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                            ],
                          ),
                          BaseSecondaryButton(
                            onPressed: () {
                              generatePdfStockTake(controller: controller);
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
                          StockTakeResult result = snapshot.data;
                          controller.dataStockOpname = result.data ?? DataStockTake();
                          List<dynamic> listData =
                              controller.dataStockOpname.toJson()["data_stock"] ?? [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            columns.addAll(
                              List.generate(
                                controller.listRoleView.length,
                                (index) {
                                  if (controller.listRoleView[index] == "is_selisih") {
                                    return PlutoColumn(
                                      width: 75,
                                      backgroundColor: primaryColor,
                                      filterHintText: "Cari Keterangan",
                                      title: "Keterangan",
                                      field: controller.listRoleView[index],
                                      type: PlutoColumnType.text(),
                                      renderer: (rendererContext) {
                                        Map<String, dynamic> dataRow = rendererContext.row.toJson();

                                        if (dataRow["is_selisih"] == true) {
                                          return const CardLabel(
                                            cardColor: red50,
                                            cardTitle: "Selisih",
                                            cardTitleColor: red900,
                                            cardBorderColor: red50,
                                          );
                                        } else {
                                          return const CardLabel(
                                            cardColor: green50,
                                            cardTitle: "Seimbang",
                                            cardTitleColor: green900,
                                            cardBorderColor: green50,
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    return PlutoColumn(
                                      backgroundColor: primaryColor,
                                      filterHintText: "Cari ${controller.listRoleView[index]}",
                                      title: convertTitle(
                                        controller.listRoleView[index],
                                      ),
                                      field: controller.listRoleView[index],
                                      type: (controller.listRoleView[index] == "stock" ||
                                              controller.listRoleView[index] == "selisih" ||
                                              controller.listRoleView[index] == "stock_take" ||
                                              controller.listRoleView[index] ==
                                                  "total_harga_jual_stock" ||
                                              controller.listRoleView[index] ==
                                                  "total_harga_jual_stocktake" ||
                                              controller.listRoleView[index] ==
                                                  "selisih_harga_jual")
                                          ? PlutoColumnType.number(
                                              locale: "id",
                                            )
                                          : PlutoColumnType.text(),
                                    );
                                  }
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

                              for (String column in controller.listRoleView) {
                                if (item.containsKey(column)) {
                                  if (column == "is_selisih") {
                                    cells[column] = PlutoCell(
                                      value: item[column],
                                    );
                                  } else {
                                    cells[column] = PlutoCell(
                                      value: trimStringStrip(item[column]),
                                    );
                                  }
                                }
                              }

                              return PlutoRow(cells: cells);
                            }).toList();

                            List<PlutoColumnGroup>? columnGroups = [
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "Stock",
                                fields: [
                                  "stock",
                                  "total_harga_jual_stock",
                                ],
                              ),
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "Stocktake",
                                fields: [
                                  "stock_take",
                                  "total_harga_jual_stocktake",
                                ],
                              ),
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "Selisih",
                                fields: [
                                  "selisih",
                                  "selisih_harga_jual",
                                ],
                              ),
                            ];

                            return SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  144 -
                                  16,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: 'Stocktake',
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
                                    // controller.dataFuture = controller.cariDataStockOpname(
                                    //   isAsc: controller.isAsc,
                                    //   field: event.column.field,
                                    // );
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
                                columnGroups: columnGroups,
                                rows: rows,
                                createFooter: (stateManager) {
                                  return FooterTableWidget(
                                    page: controller.page,
                                    hasDropdown: false,
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
                              entity: 'Stocktake',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Stocktake",
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
  State<StockTakeView> createState() => StockTakeController();
}
