import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_take_model.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take/view/stock_take_view.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take_divisi/controller/stock_take_divisi_controller.dart';
import 'package:ksu_budidaya/module/stock_opname/stock_take_divisi/widget/generate_stocktake.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class StockTakeDivisiView extends StatefulWidget {
  const StockTakeDivisiView({Key? key}) : super(key: key);

  Widget build(context, StockTakeDivisiController controller) {
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
                              BaseSecondaryButton(
                                onPressed: () async {
                                  controller.dataFuture = controller.cariDataStockOpname();
                                  controller.update();
                                },
                                text: "Refresh Data",
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
                                            controller.listRoleView[index] == "selisih_harga_jual")
                                        ? PlutoColumnType.number(
                                            locale: "id",
                                          )
                                        : PlutoColumnType.text(),
                                    footerRenderer: (rendererContext) {
                                      switch (controller.listRoleView[index]) {
                                        case "id_divisi":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "TOTAL",
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "nm_divisi":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "",
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "stock":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatMoney(
                                                    result.data?.totalData?.totalStock ?? 0),
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "stock_take":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatMoney(
                                                    result.data?.totalData?.totalStockTake ?? 0),
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "selisih":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatMoney(
                                                    result.data?.totalData?.totalSelisih ?? 0),
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "total_harga_jual_stock":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatMoney(
                                                    result.data?.totalData?.totalHargaJualStock ??
                                                        0),
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "total_harga_jual_stocktake":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatMoney(result
                                                        .data?.totalData?.totalHargaJualStocktake ??
                                                    0),
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        case "selisih_harga_jual":
                                          return Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: gray100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatMoney(
                                                    result.data?.totalData?.totalSelisihHargaJual ??
                                                        0),
                                                style: myTextTheme.displayLarge?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );

                                        default:
                                          return Container();
                                      }
                                    },
                                  );
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
                                  Map<String, dynamic> dataRow = rendererContext.row.toJson();
                                  return BaseSecondaryButton(
                                    onPressed: () {
                                      Get.to(
                                        StockTakeView(
                                          idDivisi: trimString(dataRow["id_divisi"]),
                                          nmDivisi: trimString(dataRow["nm_divisi"]),
                                        ),
                                      );
                                    },
                                    text: "Detail",
                                    suffixIcon: iconChevronDown,
                                  );
                                },
                                footerRenderer: (rendererContext) {
                                  return Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: gray100,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "",
                                        style: myTextTheme.displayLarge,
                                      ),
                                    ),
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
  State<StockTakeDivisiView> createState() => StockTakeDivisiController();
}
