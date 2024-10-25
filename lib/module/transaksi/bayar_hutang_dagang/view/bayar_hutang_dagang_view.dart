import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class BayarHutangDagangView extends StatefulWidget {
  const BayarHutangDagangView({Key? key}) : super(key: key);

  Widget build(context, BayarHutangDagangController controller) {
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
                    "Pelunasan Pembelian",
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
                        minWidth:
                            Provider.of<DrawerProvider>(context).isDrawerOpen
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
                                  textEditingController:
                                      controller.supplierNameController,
                                  onChanged: (value) {},
                                  hintText: "Pencarian",
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasePrimaryButton(
                                      onPressed: () {
                                        controller.dataFuture =
                                            controller.cariDataHutangDagang();
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
                                  controller.onSwitchStep(
                                    controller.step1 == true ? "1" : "2",
                                  );

                                  controller.update();
                                },
                                text: "Refresh",
                                suffixIcon: iconCached,
                                isDense: true,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                            ],
                          ),
                          BasePrimaryButton(
                            onPressed: () {
                              showDialogBase(
                                width: 700,
                                content: DialogTambahPelunasan(
                                  isPageBayarHutang: true,
                                  nominal: trimString(null),
                                  idHutangDagang: trimString(null),
                                  idTransaksi: trimString(null),
                                  idSupplier: trimString(null),
                                ),
                              );
                            },
                            text: "Tambah Data",
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
                  ProsesStep(
                    step1: controller.step1,
                    onTapStep1: () {
                      controller.onSwitchStep("1");
                    },
                    textStep1: "Daftar Hutang",
                    step2: controller.step2,
                    onTapStep2: () {
                      controller.onSwitchStep("2");
                    },
                    textStep2: "Riwayat Pelunasan",
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  controller.step1
                      ? FutureBuilder(
                          future: controller.dataFuture,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ContainerLoadingRole();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const ContainerError();
                              } else if (snapshot.hasData) {
                                HutangDagangResult result = snapshot.data;
                                controller.dataHutangDagang =
                                    result.data ?? DataHutangDagang();
                                List<dynamic> listData = controller
                                        .dataHutangDagang
                                        .toJson()["data_hutang_dagang"] ??
                                    [];

                                if (listData.isNotEmpty) {
                                  List<PlutoRow> rows = [];
                                  List<PlutoColumn> columns = [];

                                  columns.add(
                                    PlutoColumn(
                                      width: 30,
                                      backgroundColor: primaryColor,
                                      title: "No.",
                                      field: "no",
                                      filterHintText: "Cari ",
                                      type: PlutoColumnType.text(),
                                      enableEditingMode: false,
                                      renderer: (rendererContext) {
                                        final rowIndex =
                                            rendererContext.rowIdx + 1;

                                        return Text(
                                          rendererContext.cell.value.toString(),
                                          style: myTextTheme.bodyMedium,
                                        );
                                      },
                                    ),
                                  );

                                  columns.addAll(
                                    List.generate(
                                      controller.listHutangDagangView.length,
                                      (index) {
                                        return PlutoColumn(
                                          backgroundColor: primaryColor,
                                          filterHintText:
                                              "Cari ${controller.listHutangDagangView[index]}",
                                          title: convertTitle(
                                            controller
                                                .listHutangDagangView[index],
                                          ),
                                          field: controller
                                              .listHutangDagangView[index],
                                          type:
                                              (controller.listHutangDagangView[
                                                          index] ==
                                                      "nominal")
                                                  ? PlutoColumnType.number(
                                                      locale: "id",
                                                    )
                                                  : PlutoColumnType.text(),
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
                                        final rowIndex = rendererContext.rowIdx;
                                        Map<String, dynamic> dataRow =
                                            rendererContext.row.toJson();
                                        return DropdownAksi(
                                          text: "Aksi",
                                          listItem: [
                                            PopupMenuItem(
                                              value: 1,
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    iconAccountBalanceWallet,
                                                    colorFilter:
                                                        colorFilterGray600,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'Bayar Hutang',
                                                      style: myTextTheme
                                                          .bodyMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          onChange: (value) {
                                            if (value == 1) {
                                              showDialogBase(
                                                width: 700,
                                                content: DialogTambahPelunasan(
                                                  isPageBayarHutang: true,
                                                  nominal: trimString(controller
                                                      .result
                                                      .data
                                                      ?.dataHutangDagang?[
                                                          rowIndex]
                                                      .nominal),
                                                  idHutangDagang: trimString(
                                                      result
                                                          .data
                                                          ?.dataHutangDagang?[
                                                              rowIndex]
                                                          .idHutangDagang),
                                                  idTransaksi: trimString(result
                                                      .data
                                                      ?.dataHutangDagang?[
                                                          rowIndex]
                                                      .idPembelian),
                                                  idSupplier: trimString(result
                                                      .data
                                                      ?.dataHutangDagang?[
                                                          rowIndex]
                                                      .idSupplier),
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

                                    for (String column
                                        in controller.listHutangDagangView) {
                                      if (item.containsKey(column)) {
                                        cells[column] = PlutoCell(
                                          value: trimStringStrip(
                                            item[column].toString(),
                                          ),
                                        );
                                      }
                                    }

                                    return PlutoRow(cells: cells);
                                  }).toList();

                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        AppBar().preferredSize.height -
                                        144 -
                                        16 -
                                        38,
                                    child: PlutoGrid(
                                      noRowsWidget: const ContainerTidakAda(
                                        entity: 'Hutang Dagang',
                                      ),
                                      mode: PlutoGridMode.select,
                                      onLoaded: (event) {
                                        event.stateManager
                                            .setShowColumnFilter(true);
                                      },
                                      onSorted: (event) {
                                        if (event.column.field != "Aksi") {
                                          controller.isAsc = !controller.isAsc;
                                          controller.update();
                                          controller.dataFuture =
                                              controller.cariDataHutangDagang(
                                            isAsc: controller.isAsc,
                                            field: (event.column.field ==
                                                        "cash_in" ||
                                                    event.column.field ==
                                                        "cash_out")
                                                ? "nominal"
                                                : event.column.field,
                                          );
                                          controller.update();
                                        }
                                      },
                                      configuration: PlutoGridConfiguration(
                                        columnSize:
                                            const PlutoGridColumnSizeConfig(
                                          autoSizeMode: PlutoAutoSizeMode.scale,
                                        ),
                                        style: PlutoGridStyleConfig(
                                          columnTextStyle:
                                              myTextTheme.titleSmall?.copyWith(
                                                      color: neutralWhite) ??
                                                  const TextStyle(),
                                          gridBorderColor: blueGray50,
                                          gridBorderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        localeText: configLocale,
                                      ),
                                      columns: columns,
                                      rows: rows,
                                      createFooter: (stateManager) {
                                        double totalHutang = 0;
                                        for (var i = 0;
                                            i <
                                                (result.data?.dataHutangDagang
                                                        ?.length ??
                                                    0);
                                            i++) {
                                          totalHutang += double.parse(result
                                                  .data
                                                  ?.dataHutangDagang?[i]
                                                  .nominal ??
                                              "0");
                                        }
                                        return SingleChildScrollView(
                                          controller: ScrollController(),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: gray100,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Text(
                                                      "TOTAL HUTANG",
                                                      style: myTextTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Text(
                                                      formatMoney(totalHutang),
                                                      style: myTextTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FooterTableWidget(
                                                page: controller.page,
                                                itemPerpage: controller.size,
                                                maxPage: controller
                                                        .dataHutangDagang
                                                        .paging
                                                        ?.totalPage ??
                                                    0,
                                                onChangePage: (value) {
                                                  controller.page =
                                                      trimString(value);
                                                  controller.update();
                                                  controller.dataFuture =
                                                      controller
                                                          .cariDataHutangDagang();
                                                  controller.update();
                                                },
                                                onChangePerPage: (value) {
                                                  controller.page = "1";
                                                  controller.size =
                                                      trimString(value);
                                                  controller.update();
                                                  controller.dataFuture =
                                                      controller
                                                          .cariDataHutangDagang();
                                                  controller.update();
                                                },
                                                totalRow: controller
                                                        .dataHutangDagang
                                                        .paging
                                                        ?.totalItem ??
                                                    0,
                                                onPressLeft: () {
                                                  if (int.parse(
                                                          controller.page) >
                                                      1) {
                                                    controller.page =
                                                        (int.parse(controller
                                                                    .page) -
                                                                1)
                                                            .toString();
                                                    controller.update();
                                                    controller.dataFuture =
                                                        controller
                                                            .cariDataHutangDagang();
                                                    controller.update();
                                                  }
                                                },
                                                onPressRight: () {
                                                  if (int.parse(
                                                          controller.page) <
                                                      (result.data?.paging
                                                              ?.totalPage ??
                                                          0)) {
                                                    controller.page =
                                                        (int.parse(controller
                                                                    .page) +
                                                                1)
                                                            .toString();
                                                    controller.update();
                                                    controller.dataFuture =
                                                        controller
                                                            .cariDataHutangDagang();
                                                    controller.update();
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const ContainerTidakAda(
                                    entity: 'Hutang Dagang',
                                  );
                                }
                              } else {
                                return const ContainerError();
                              }
                            } else {
                              return const ContainerTidakAda(
                                entity: "Hutang Dagang",
                              );
                            }
                          },
                        )
                      : FutureBuilder(
                          future: controller.dataFutureHistory,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ContainerLoadingRole();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const ContainerError();
                              } else if (snapshot.hasData) {
                                HistoryHutangDagangResult result =
                                    snapshot.data;
                                controller.dataHistoryHutangDagang =
                                    result.data ?? DataHistoryHutangDagang();
                                List<dynamic> listData = controller
                                        .dataHistoryHutangDagang
                                        .toJson()["data_bayar_hutang"] ??
                                    [];

                                if (listData.isNotEmpty) {
                                  List<PlutoRow> rows = [];
                                  List<PlutoColumn> columns = [];

                                  columns.add(
                                    PlutoColumn(
                                      width: 30,
                                      backgroundColor: primaryColor,
                                      title: "No.",
                                      field: "no",
                                      filterHintText: "Cari ",
                                      type: PlutoColumnType.text(),
                                      enableEditingMode: false,
                                      renderer: (rendererContext) {
                                        final rowIndex =
                                            rendererContext.rowIdx + 1;

                                        return Text(
                                          rendererContext.cell.value.toString(),
                                          style: myTextTheme.bodyMedium,
                                        );
                                      },
                                    ),
                                  );

                                  columns.addAll(
                                    List.generate(
                                      controller
                                          .listHistoryHutangDagangView.length,
                                      (index) {
                                        return PlutoColumn(
                                          backgroundColor: primaryColor,
                                          filterHintText:
                                              "Cari ${controller.listHistoryHutangDagangView[index]}",
                                          title: convertTitle(
                                            controller
                                                    .listHistoryHutangDagangView[
                                                index],
                                          ),
                                          field: controller
                                                  .listHistoryHutangDagangView[
                                              index],
                                          type:
                                              (controller.listHistoryHutangDagangView[
                                                          index] ==
                                                      "nominal")
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

                                    cells['no'] = PlutoCell(
                                      value: item['persistentIndex'].toString(),
                                    );

                                    cells['Aksi'] = PlutoCell(
                                      value: null,
                                    );

                                    for (String column in controller
                                        .listHistoryHutangDagangView) {
                                      if (item.containsKey(column)) {
                                        cells[column] = PlutoCell(
                                          value: trimStringStrip(
                                            item[column].toString(),
                                          ),
                                        );
                                      }
                                    }

                                    return PlutoRow(cells: cells);
                                  }).toList();

                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        AppBar().preferredSize.height -
                                        144 -
                                        16 -
                                        38,
                                    child: PlutoGrid(
                                      noRowsWidget: const ContainerTidakAda(
                                        entity: 'Hutang Dagang',
                                      ),
                                      mode: PlutoGridMode.select,
                                      onLoaded: (event) {
                                        event.stateManager
                                            .setShowColumnFilter(true);
                                      },
                                      onSorted: (event) {
                                        if (event.column.field != "Aksi") {
                                          controller.isAsc = !controller.isAsc;
                                          controller.update();
                                          controller.dataFuture =
                                              controller.cariDataHutangDagang(
                                            isAsc: controller.isAsc,
                                            field: (event.column.field ==
                                                        "cash_in" ||
                                                    event.column.field ==
                                                        "cash_out")
                                                ? "nominal"
                                                : event.column.field,
                                          );
                                          controller.update();
                                        }
                                      },
                                      configuration: PlutoGridConfiguration(
                                        columnSize:
                                            const PlutoGridColumnSizeConfig(
                                          autoSizeMode: PlutoAutoSizeMode.scale,
                                        ),
                                        style: PlutoGridStyleConfig(
                                          columnTextStyle:
                                              myTextTheme.titleSmall?.copyWith(
                                                      color: neutralWhite) ??
                                                  const TextStyle(),
                                          gridBorderColor: blueGray50,
                                          gridBorderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        localeText: configLocale,
                                      ),
                                      columns: columns,
                                      rows: rows,
                                      createFooter: (stateManager) {
                                        return FooterTableWidget(
                                          page: controller.page,
                                          itemPerpage: controller.size,
                                          maxPage: controller.dataHutangDagang
                                                  .paging?.totalPage ??
                                              0,
                                          onChangePage: (value) {
                                            controller.page = trimString(value);
                                            controller.update();
                                            controller.dataFuture = controller
                                                .cariDataHutangDagang();
                                            controller.update();
                                          },
                                          onChangePerPage: (value) {
                                            controller.page = "1";
                                            controller.size = trimString(value);
                                            controller.update();
                                            controller.dataFuture = controller
                                                .cariDataHutangDagang();
                                            controller.update();
                                          },
                                          totalRow: controller.dataHutangDagang
                                                  .paging?.totalItem ??
                                              0,
                                          onPressLeft: () {
                                            if (int.parse(controller.page) >
                                                1) {
                                              controller.page =
                                                  (int.parse(controller.page) -
                                                          1)
                                                      .toString();
                                              controller.update();
                                              controller.dataFuture = controller
                                                  .cariDataHutangDagang();
                                              controller.update();
                                            }
                                          },
                                          onPressRight: () {
                                            if (int.parse(controller.page) <
                                                (result.data?.paging
                                                        ?.totalPage ??
                                                    0)) {
                                              controller.page =
                                                  (int.parse(controller.page) +
                                                          1)
                                                      .toString();
                                              controller.update();
                                              controller.dataFuture = controller
                                                  .cariDataHutangDagang();
                                              controller.update();
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const ContainerTidakAda(
                                    entity: 'Hutang Dagang',
                                  );
                                }
                              } else {
                                return const ContainerError();
                              }
                            } else {
                              return const ContainerTidakAda(
                                entity: "Hutang Dagang",
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
  State<BayarHutangDagangView> createState() => BayarHutangDagangController();
}
