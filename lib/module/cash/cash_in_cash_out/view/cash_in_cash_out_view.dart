import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CashInCashOutView extends StatefulWidget {
  const CashInCashOutView({Key? key}) : super(key: key);

  Widget build(context, CashInCashOutController controller) {
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
                    "Cash In dan Cash Out",
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
                                ? MediaQuery.of(context).size.width - 32 - 260
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
                                            controller.cariDataCashInOut();
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
                                    controller.step1 == true
                                        ? "1"
                                        : controller.step2 == true
                                            ? "2"
                                            : "3",
                                  );
                                  controller.dataFuture =
                                      controller.cariDataCashInOut();
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
                                width: 1000,
                                content: DialogCashInOut(
                                  isDetail: false,
                                  data: DataDetailCashInOut(),
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
                    textStep1: "Semua",
                    step2: controller.step2,
                    onTapStep2: () {
                      controller.onSwitchStep("2");
                    },
                    textStep2: "Cash In",
                    step3: controller.step3,
                    onTapStep3: () {
                      controller.onSwitchStep("3");
                    },
                    textStep3: "Cash Out",
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  FutureBuilder(
                    future: controller.dataFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ContainerLoadingRole();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const ContainerError();
                        } else if (snapshot.hasData) {
                          CashInOutResult result = snapshot.data;
                          controller.dataCashInOut =
                              result.data ?? DataCashInOut();
                          List<dynamic> listData = controller.dataCashInOut
                                  .toJson()["data_cash_in_out"] ??
                              [];

                          for (var data in listData) {
                            final isCashIn = data["id_cash"] == "1";
                            final isCashOut = data["id_cash"] == "2";

                            data.addAll({
                              "cash_in": isCashIn ? data["nominal"] : "0",
                              "cash_out": isCashOut ? data["nominal"] : "0",
                            });
                          }

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
                                  final rowIndex = rendererContext.rowIdx + 1;

                                  return Text(
                                    rendererContext.cell.value.toString(),
                                    style: myTextTheme.bodyMedium,
                                  );
                                },
                              ),
                            );

                            columns.addAll(
                              List.generate(
                                controller.listRoleView.length,
                                (index) {
                                  return PlutoColumn(
                                    backgroundColor: primaryColor,
                                    filterHintText:
                                        "Cari ${controller.listRoleView[index]}",
                                    title: convertTitle(
                                      controller.listRoleView[index],
                                    ),
                                    field: controller.listRoleView[index],
                                    type: (controller.listRoleView[index] ==
                                                "cash_in" ||
                                            controller.listRoleView[index] ==
                                                "cash_out")
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
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              iconDelete,
                                              colorFilter:
                                                  colorFilter(color: red600),
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
                                          content: DialogCashInOut(
                                            isDetail: true,
                                            data: result
                                                .data?.dataCashInOut?[rowIndex],
                                          ),
                                        );
                                      } else if (value == 2) {
                                        showDialogBase(
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda yakin ingin Menghapus Data Cash In Out",
                                            onConfirm: () async {
                                              controller.postRemoveCashInOut(
                                                trimString(
                                                  result
                                                      .data
                                                      ?.dataCashInOut?[rowIndex]
                                                      .idCashInOut,
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

                              for (String column in controller.listRoleView) {
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
                                  entity: 'Cash In dan Cash Out',
                                ),
                                mode: PlutoGridMode.select,
                                onLoaded: (event) {
                                  event.stateManager.setShowColumnFilter(true);
                                },
                                onSorted: (event) {
                                  if (event.column.field != "Aksi") {
                                    controller.isAsc = !controller.isAsc;
                                    controller.update();
                                    controller.dataFuture =
                                        controller.cariDataCashInOut(
                                      isAsc: controller.isAsc,
                                      field: (event.column.field == "cash_in" ||
                                              event.column.field == "cash_out")
                                          ? "nominal"
                                          : event.column.field,
                                    );
                                    controller.update();
                                  }
                                },
                                configuration: PlutoGridConfiguration(
                                  columnSize: const PlutoGridColumnSizeConfig(
                                    autoSizeMode: PlutoAutoSizeMode.scale,
                                  ),
                                  style: PlutoGridStyleConfig(
                                    columnTextStyle: myTextTheme.titleSmall
                                            ?.copyWith(color: neutralWhite) ??
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
                                    maxPage: controller
                                            .dataCashInOut.paging?.totalPage ??
                                        0,
                                    onChangePage: (value) {
                                      controller.page = trimString(value);
                                      controller.update();
                                      controller.dataFuture =
                                          controller.cariDataCashInOut();
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture =
                                          controller.cariDataCashInOut();
                                      controller.update();
                                    },
                                    totalRow: controller
                                            .dataCashInOut.paging?.totalItem ??
                                        0,
                                    onPressLeft: () {
                                      if (int.parse(controller.page) > 1) {
                                        controller.page =
                                            (int.parse(controller.page) - 1)
                                                .toString();
                                        controller.update();
                                        controller.dataFuture =
                                            controller.cariDataCashInOut();
                                        controller.update();
                                      }
                                    },
                                    onPressRight: () {
                                      if (int.parse(controller.page) <
                                          (result.data?.paging?.totalPage ??
                                              0)) {
                                        controller.page =
                                            (int.parse(controller.page) + 1)
                                                .toString();
                                        controller.update();
                                        controller.dataFuture =
                                            controller.cariDataCashInOut();
                                        controller.update();
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const ContainerTidakAda(
                              entity: 'Cash In dan Cash Out',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Cash In dan Cash Out",
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
  State<CashInCashOutView> createState() => CashInCashOutController();
}
