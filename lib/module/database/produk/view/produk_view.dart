import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ProdukView extends StatefulWidget {
  const ProdukView({Key? key}) : super(key: key);

  Widget build(context, ProdukController controller) {
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
                    "Product",
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
                                child: BaseForm(
                                  textEditingController: controller.productNameController,
                                  onChanged: (value) {},
                                  hintText: "Pencarian",
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasePrimaryButton(
                                      onPressed: () {
                                        controller.dataFuture = controller.cariDataProduct();
                                        controller.update();
                                      },
                                      text: "Cari",
                                      suffixIcon: iconSearch,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              BaseSecondaryButton(
                                onPressed: () {
                                  controller.dataFuture = controller.cariDataProduct();
                                  controller.update();
                                },
                                text: "Refresh",
                                suffixIcon: iconCached,
                                isDense: true,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              // BaseSecondaryButton(
                              //   onPressed: () {
                              //     // controller.dataFuture =
                              //     //     controller.cariDataProduct();
                              //     // controller.update();
                              //   },
                              //   text: "Filter",
                              //   suffixIcon: iconFilterAlt,
                              //   isDense: true,
                              // ),
                              // const SizedBox(
                              //   width: 16.0,
                              // ),
                            ],
                          ),
                          if (UserDatabase.userDatabase.data?.roleData?.idRole != "ROLE002")
                            BasePrimaryButton(
                              onPressed: () {
                                showDialogBase(
                                  width: 700,
                                  content: DialogTambahProduk(
                                    isDetail: false,
                                    data: DataDetailProduct(),
                                  ),
                                );
                              },
                              text: "Tambah Product",
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
                  StepStatusProduk(
                    step1: controller.step1,
                    onTapStep1: () {
                      controller.onSwitchStep("1");
                      controller.dataFuture = controller.cariDataProduct();
                      controller.update();
                    },
                    textStep1: "Aktif",
                    step2: controller.step2,
                    onTapStep2: () {
                      controller.onSwitchStep("2");
                      controller.dataFuture = controller.cariDataProduct();
                      controller.update();
                    },
                    textStep2: "Nonaktif",
                  ),
                  const SizedBox(
                    height: 8.0,
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
                          ProductResult result = snapshot.data;
                          controller.dataProduct = result.data ?? DataProduct();
                          List<dynamic> listSource =
                              controller.dataProduct.toJson()["data_product"] ?? [];

                          List<dynamic> listData = [];
                          if (controller.step1) {
                            listData.clear();

                            for (var element in listSource) {
                              if (element["status_product"] == true) {
                                listData.add(element);
                              }
                            }
                          } else {
                            listData.clear();
                            for (var element in listSource) {
                              if (element["status_product"] == false) {
                                listData.add(element);
                              }
                            }
                          }

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            columns.add(
                              PlutoColumn(
                                width: 60,
                                backgroundColor: primaryColor,
                                title: "No.",
                                suppressedAutoSize: true,
                                field: "no",
                                filterHintText: "Cari ",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  final rowIndex = rendererContext.rowIdx + 1;

                                  return Text(
                                    rendererContext.cell.value.toString(),
                                    style: myTextTheme.bodyMedium,
                                  );
                                },
                                footerRenderer: (context) {
                                  return Container(
                                    width: MediaQuery.of(globalContext).size.width,
                                    decoration: const BoxDecoration(
                                      color: gray100,
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: blueGray50,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );

                            columns.addAll(
                              List.generate(
                                controller.listProdukView.length,
                                (index) {
                                  return PlutoColumn(
                                    footerRenderer: (context) {
                                      if (controller.listProdukView[index] == "id_divisi") {
                                        return SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: SizedBox(
                                            height: 68,
                                            width: MediaQuery.of(globalContext).size.width,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Jumlah",
                                                    style: myTextTheme.titleSmall?.copyWith(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Total",
                                                    style: myTextTheme.titleSmall?.copyWith(
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (controller.listProdukView[index] == "jumlah") {
                                        return SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: SizedBox(
                                            height: 68,
                                            width: MediaQuery.of(globalContext).size.width,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: PlutoAggregateColumnFooter(
                                                    rendererContext: context,
                                                    locale: "id",
                                                    type: PlutoAggregateColumnType.sum,
                                                    titleSpanBuilder: (text) {
                                                      return [
                                                        TextSpan(
                                                          text: text,
                                                          style: myTextTheme.bodyMedium,
                                                        ),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    formatCurrency(
                                                      trimString(result
                                                          .data?.totalKeseluruhan?.totalJumlah
                                                          .toString()),
                                                    ),
                                                    style: myTextTheme.bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (controller.listProdukView[index] == "total_jual") {
                                        return SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: SizedBox(
                                            height: 68,
                                            width: MediaQuery.of(globalContext).size.width,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: PlutoAggregateColumnFooter(
                                                    locale: "id",
                                                    rendererContext: context,
                                                    type: PlutoAggregateColumnType.sum,
                                                    titleSpanBuilder: (text) {
                                                      return [
                                                        TextSpan(
                                                          text: text,
                                                          style: myTextTheme.bodyMedium,
                                                        ),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    formatCurrency(
                                                      trimString(result
                                                          .data?.totalKeseluruhan?.totalJual
                                                          .toString()),
                                                    ),
                                                    style: myTextTheme.bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (controller.listProdukView[index] == "total_beli") {
                                        return SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: SizedBox(
                                            height: 68,
                                            width: MediaQuery.of(globalContext).size.width,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: PlutoAggregateColumnFooter(
                                                    locale: "id",
                                                    rendererContext: context,
                                                    type: PlutoAggregateColumnType.sum,
                                                    titleSpanBuilder: (text) {
                                                      return [
                                                        TextSpan(
                                                          text: text,
                                                          style: myTextTheme.bodyMedium,
                                                        ),
                                                      ];
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: gray100,
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: blueGray50,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    formatCurrency(
                                                      trimString(result
                                                          .data?.totalKeseluruhan?.totalBeli
                                                          .toString()),
                                                    ),
                                                    style: myTextTheme.bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 34,
                                                width: MediaQuery.of(globalContext).size.width,
                                                decoration: BoxDecoration(
                                                  color: gray100,
                                                  border: Border.all(
                                                    width: 1.0,
                                                    color: blueGray50,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 34,
                                                width: MediaQuery.of(globalContext).size.width,
                                                decoration: BoxDecoration(
                                                  color: gray100,
                                                  border: Border.all(
                                                    width: 1.0,
                                                    color: blueGray50,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    backgroundColor: primaryColor,
                                    filterHintText:
                                        "Cari ${controller.listProdukView[index] == "id_divisi" ? "divisi" : controller.listProdukView[index] == "id_supplier" ? "supplier" : controller.listProdukView[index] == "jumlah" ? "stock" : controller.listProdukView[index]}",
                                    title: controller.listProdukView[index] == "id_divisi"
                                        ? "DIVISI"
                                        : controller.listProdukView[index] == "id_supplier"
                                            ? "SUPPLIER"
                                            : controller.listProdukView[index] == "jumlah"
                                                ? "STOCK"
                                                : convertTitle(
                                                    controller.listProdukView[index],
                                                  ),
                                    field: controller.listProdukView[index],
                                    type: controller.typeField(
                                      controller.listProdukView[index],
                                    ),
                                  );
                                },
                              ),
                            );

                            columns.add(
                              PlutoColumn(
                                width: 110,
                                suppressedAutoSize: true,
                                backgroundColor: primaryColor,
                                frozen: PlutoColumnFrozen.end,
                                title: "AKSI",
                                field: "Aksi",
                                filterHintText: "",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                footerRenderer: (context) {
                                  return Container(
                                    width: MediaQuery.of(globalContext).size.width,
                                    decoration: const BoxDecoration(
                                      color: gray100,
                                    ),
                                  );
                                },
                                renderer: (rendererContext) {
                                  final rowIndex = rendererContext.rowIdx;
                                  Map<String, dynamic> dataRow = rendererContext.row.toJson();

                                  dataRow.update("harga_jual", (value) => value.toString());
                                  dataRow.update("harga_beli", (value) => value.toString());

                                  DataDetailProduct data = controller.dataProduct.dataProduct
                                          ?.firstWhere((element) =>
                                              trimString(element.idProduct) ==
                                              trimString(dataRow["id_product"])) ??
                                      DataDetailProduct();

                                  return DropdownAksi(
                                    text: "Aksi",
                                    listItem: [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(iconMiscInfo),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Detail Data',
                                                style: myTextTheme.bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (UserDatabase.userDatabase.data?.roleData?.idRole !=
                                          "ROLE002")
                                        PopupMenuItem(
                                          value: 2,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(iconEditSquare),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  'Edit Data',
                                                  style: myTextTheme.bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (UserDatabase.userDatabase.data?.roleData?.idRole !=
                                          "ROLE002")
                                        PopupMenuItem(
                                          value: 3,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                iconDelete,
                                                colorFilter: colorFilter(color: red600),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Hapus',
                                                style: myTextTheme.bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                    onChange: (value) {
                                      if (value == 1) {
                                        showDialogBase(
                                          width: 1000,
                                          content: DialogDetailProduk(
                                            data: DataDetailProduct.fromJson(
                                              dataRow,
                                            ),
                                          ),
                                        );
                                      } else if (value == 2) {
                                        showDialogBase(
                                          width: 700,
                                          content: DialogTambahProduk(
                                            isDetail: true,
                                            data: data,
                                          ),
                                        );
                                      } else if (value == 3) {
                                        showDialogBase(
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda yakin ingin Menghapus Product",
                                            onConfirm: () async {
                                              controller.postRemoveProduct(
                                                trimString(
                                                  dataRow["id_product"],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
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

                              cells['no'] = PlutoCell(
                                value: item['persistentIndex'].toString(),
                              );

                              cells['Aksi'] = PlutoCell(
                                value: null,
                              );

                              for (String column in controller.listProdukView) {
                                if (item.containsKey(column)) {
                                  cells[column] = PlutoCell(
                                    value: column == "id_divisi"
                                        ? getNamaDivisi(
                                            idDivisi: trimString(
                                              item[column].toString(),
                                            ),
                                          )
                                        : column == "id_supplier"
                                            ? getNamaSupplier(
                                                idSupplier: trimString(
                                                  item[column].toString(),
                                                ),
                                              )
                                            : trimStringStrip(item[column].toString()),
                                  );
                                }
                              }

                              return PlutoRow(cells: cells);
                            }).toList();

                            return SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  144 -
                                  36 -
                                  16,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: 'Product',
                                ),
                                mode: PlutoGridMode.select,
                                onLoaded: (event) {
                                  event.stateManager.setShowColumnFilter(true);
                                  event.stateManager.columnFooterHeight = 68;

                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "nm_product")
                                      .suppressedAutoSize = true;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "nm_product")
                                      .width = 400;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "jumlah")
                                      .suppressedAutoSize = true;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "jumlah")
                                      .width = 75;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "harga_jual")
                                      .suppressedAutoSize = true;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "harga_jual")
                                      .width = 150;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "harga_beli")
                                      .suppressedAutoSize = true;
                                  event.stateManager.columns
                                      .firstWhere((element) => element.field == "harga_beli")
                                      .width = 150;
                                },
                                onSorted: (event) {
                                  if (event.column.field != "Aksi") {
                                    controller.isAsc = !controller.isAsc;
                                    controller.update();
                                    controller.dataFuture = controller.cariDataProduct(
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
                                    cellTextStyle: myTextTheme.bodyMedium?.copyWith(
                                            color: controller.step1 ? gray900 : red700) ??
                                        const TextStyle(),
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
                                    maxPage: controller.dataProduct.paging?.totalPage ?? 0,
                                    onChangePage: (value) {
                                      controller.page = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataProduct();
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataProduct();
                                      controller.update();
                                    },
                                    totalRow: controller.dataProduct.paging?.totalItem ?? 0,
                                    onPressLeft: () {
                                      if (int.parse(controller.page) > 1) {
                                        controller.page =
                                            (int.parse(controller.page) - 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.cariDataProduct();
                                        controller.update();
                                      }
                                    },
                                    onPressRight: () {
                                      if (int.parse(controller.page) <
                                          (result.data?.paging?.totalPage ?? 0)) {
                                        controller.page =
                                            (int.parse(controller.page) + 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.cariDataProduct();
                                        controller.update();
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const ContainerTidakAda(
                              entity: 'Product',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Product",
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
  State<ProdukView> createState() => ProdukController();
}
