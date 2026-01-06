import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/history_stock_opname_model.dart';
import 'package:ksu_budidaya/module/stock_opname/riwayat_stock_opname/controller/riwayat_stock_opname_controller.dart';
import 'package:ksu_budidaya/module/stock_opname/riwayat_stock_opname/widget/generate_riwayat_stock_opname.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class RiwayatStockOpnameView extends StatefulWidget {
  const RiwayatStockOpnameView({Key? key}) : super(key: key);

  Widget build(context, RiwayatStockOpnameController controller) {
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
                    "Riwayat Stock Opname",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Form(
                    key: controller.formKeyHistory,
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
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: BaseForm(
                                    textEditingController: controller.supplierNameController,
                                    onChanged: (value) {},
                                    hintText: "Pencarian",
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
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
                                Expanded(
                                  child: BaseDropdownButton<Month>(
                                    sortItem: false,
                                    label: "Bulan",
                                    itemAsString: (item) => item.monthAsString(),
                                    items: Year.fromJson(monthData).months,
                                    value: controller.monthNow != null
                                        ? Month(
                                            id: controller.monthNow!,
                                            month: trimString(getNamaMonth(controller.monthNow!)),
                                          )
                                        : null,
                                    onChanged: (value) {
                                      controller.monthNow = value?.id;
                                      controller.hasData = false;
                                      controller.update();
                                    },
                                    onClear: () {
                                      controller.monthNow = null;
                                      controller.yearNow = null;
                                      controller.hasData = false;
                                      controller.update();
                                    },
                                    validator: (value) {
                                      if (controller.yearNow != null && value == null) {
                                        return "Bulan harus diisi jika tahun sudah dipilih";
                                      }
                                      return null;
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
                                    itemAsString: (item) => item.toString(),
                                    items: List.generate(DateTime.now().year - 2023,
                                        (index) => DateTime.now().year - index),
                                    value: controller.yearNow,
                                    onChanged: (value) {
                                      controller.yearNow = value;
                                      controller.hasData = false;
                                      controller.update();
                                    },
                                    onClear: () {
                                      controller.monthNow = null;
                                      controller.yearNow = null;
                                      controller.hasData = false;
                                      controller.update();
                                    },
                                    validator: (value) {
                                      if (controller.monthNow != null && value == null) {
                                        return "Tahun harus diisi jika bulan sudah dipilih";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                BasePrimaryButton(
                                  onPressed: () {
                                    if (controller.formKeyHistory.currentState!.validate()) {
                                      controller.dataFuture = controller.cariDataStockOpname();

                                      controller.update();
                                    }
                                  },
                                  text: "Cari Data",
                                  isDense: true,
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                              ],
                            ),
                          ),
                          BaseSecondaryButton(
                            onPressed: () {
                              generatePdfRiwayatStockOpname(controller: controller);
                            },
                            text: "Cetak PDF",
                            suffixIcon: iconPrint,
                            isDense: true,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          BasePrimaryButton(
                            onPressed: () {
                              router.push("/stock-opname/mobile", extra: {"isFromHistory": true});
                            },
                            text: "Tambah Stock Opname",
                            suffixIcon: iconAdd,
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
                          HistoryStockOpnameModel result = snapshot.data;
                          controller.dataStockOpname = result.data ?? DataHistoryStockOpname();
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
                                    type: (controller.listRoleView[index] == "stok_awal" ||
                                            controller.listRoleView[index] == "selisih" ||
                                            controller.listRoleView[index] == "stok_akhir" ||
                                            controller.listRoleView[index] ==
                                                "total_harga_jual_stock" ||
                                            controller.listRoleView[index] ==
                                                "total_harga_jual_stocktake" ||
                                            controller.listRoleView[index] == "selisih_harga_jual")
                                        ? PlutoColumnType.number(
                                            locale: "id",
                                          )
                                        : PlutoColumnType.text(),
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

                              for (String column in controller.listRoleView) {
                                if (item.containsKey(column)) {
                                  cells[column] = PlutoCell(
                                    value: trimStringStrip(item[column]),
                                  );
                                }
                              }

                              return PlutoRow(cells: cells);
                            }).toList();

                            List<PlutoColumnGroup> columnGroups = [
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "Stock",
                                fields: [
                                  "stok_awal",
                                  "total_harga_jual_stock",
                                ],
                              ),
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "Stocktake",
                                fields: [
                                  "stok_akhir",
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
                                  entity: 'History Stock Opname',
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
                                columnGroups: columnGroups,
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
                              entity: 'History Stock Opname',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "History Stock Opname",
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
  State<RiwayatStockOpnameView> createState() => RiwayatStockOpnameController();
}
