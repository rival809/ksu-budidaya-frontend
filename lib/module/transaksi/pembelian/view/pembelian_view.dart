import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class PembelianView extends StatefulWidget {
  const PembelianView({Key? key}) : super(key: key);

  Widget build(context, PembelianController controller) {
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
                    "Daftar Pembelian",
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
                                            controller.cariDataPembelian();
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
                                  controller.dataFuture =
                                      controller.cariDataPembelian();
                                  controller.update();
                                },
                                text: "Refresh",
                                suffixIcon: iconCached,
                                isDense: true,
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              BaseSecondaryButton(
                                onPressed: () {
                                  // controller.dataFuture =
                                  //     controller.cariDataProduct();
                                  // controller.update();
                                },
                                text: "Filter",
                                suffixIcon: iconFilterAlt,
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
                          PembelianResult result = snapshot.data;
                          controller.dataCashInOut =
                              result.data ?? DataPembelian();
                          List<dynamic> listData = controller.dataCashInOut
                                  .toJson()["data_pembelian"] ??
                              [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            columns.addAll(
                              List.generate(
                                controller.listRoleView.length,
                                (index) {
                                  if (controller.listRoleView[index] ==
                                      "jenis_pembayaran") {
                                    return PlutoColumn(
                                      width: 75,
                                      backgroundColor: primaryColor,
                                      filterHintText:
                                          "Cari ${controller.listRoleView[index]}",
                                      title: convertTitle(
                                        controller.listRoleView[index],
                                      ),
                                      field: controller.listRoleView[index],
                                      type: PlutoColumnType.text(),
                                      renderer: (rendererContext) {
                                        Map<String, dynamic> dataRow =
                                            rendererContext.row.toJson();
                                        return CardLabel(
                                          cardColor: yellow50,
                                          cardTitle:
                                              dataRow["jenis_pembayaran"],
                                          cardTitleColor: yellow900,
                                          cardBorderColor: yellow50,
                                        );
                                      },
                                    );
                                  }
                                  return PlutoColumn(
                                    backgroundColor: primaryColor,
                                    filterHintText:
                                        "Cari ${controller.listRoleView[index]}",
                                    title: convertTitle(
                                      controller.listRoleView[index],
                                    ),
                                    field: controller.listRoleView[index],
                                    type: (controller.listRoleView[index] ==
                                                "total_harga_beli" ||
                                            controller.listRoleView[index] ==
                                                "total_harga_jual" ||
                                            controller.listRoleView[index] ==
                                                "jumlah")
                                        ? PlutoColumnType.number(
                                            locale: "id",
                                          )
                                        : (controller.listRoleView[index] ==
                                                "tg_pembelian")
                                            ? PlutoColumnType.date()
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
                                        // showDialogBase(
                                        //   width: 1000,
                                        //   content: DialogCashInOut(
                                        //     isDetail: true,
                                        //     data: result
                                        //         .data?.dataPembelian?[rowIndex],
                                        //   ),
                                        // );
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
                                                      ?.dataPembelian?[rowIndex]
                                                      .idPembelian,
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
                                        controller.cariDataPembelian(
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
                                          controller.cariDataPembelian();
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture =
                                          controller.cariDataPembelian();
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
                                            controller.cariDataPembelian();
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
                                            controller.cariDataPembelian();
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
  State<PembelianView> createState() => PembelianController();
}
