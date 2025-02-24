import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class TutupKasirView extends StatefulWidget {
  const TutupKasirView({Key? key}) : super(key: key);

  Widget build(context, TutupKasirController controller) {
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
                    "Riwayat Tutup Kasir",
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
                                  textEditingController: controller.penjualanNameController,
                                  onChanged: (value) {},
                                  hintText: "Pencarian",
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasePrimaryButton(
                                      onPressed: () {
                                        controller.field = null;
                                        controller.dataFuture = controller.cariDataTutupKasir();
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
                                  controller.field = null;
                                  controller.dataFuture = controller.cariDataTutupKasir();
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
                              controller.cariDataTotalPenjualan();
                            },
                            text: "Tambah Tutup Kasir",
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
                          ListTutupKasirResult result = snapshot.data;
                          controller.dataListTutupKasir = result.data ?? DataTutupKasir();
                          List<dynamic> listData =
                              controller.dataListTutupKasir.toJson()["data_tutup_kasir"] ?? [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];
                            List<PlutoColumnGroup> col = [
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "TOTAL KEUNTUNGAN",
                                fields: [
                                  "total_nilai_beli",
                                  "total_nilai_jual",
                                  "total_keuntungan",
                                ],
                              ),
                              PlutoColumnGroup(
                                backgroundColor: primaryColor,
                                title: "TOTAL PENJUALAN",
                                fields: [
                                  "tunai",
                                  "qris",
                                  "kredit",
                                  "total",
                                ],
                              ),
                            ];

                            columns.addAll(
                              List.generate(
                                controller.listTutupKasir.length,
                                (index) {
                                  var list = controller.listTutupKasir[index];
                                  return PlutoColumn(
                                    backgroundColor: primaryColor,
                                    filterHintText: "Cari ${controller.listTutupKasir[index]}",
                                    title: list == "total_nilai_beli"
                                        ? "HARGA BELI"
                                        : list == "total_nilai_jual"
                                            ? "HARGA JUAL"
                                            : convertTitle(
                                                controller.listTutupKasir[index],
                                              ),
                                    field: controller.listTutupKasir[index],
                                    type: (controller.listTutupKasir[index] == "shift" ||
                                            controller.listTutupKasir[index] == "tg_tutup_kasir" ||
                                            controller.listTutupKasir[index] == "nama_kasir")
                                        ? PlutoColumnType.text()
                                        : PlutoColumnType.number(
                                            locale: "id",
                                          ),
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
                                field: "id_tutup_kasir",
                                filterHintText: "",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  final rowIndex = rendererContext.rowIdx;
                                  Map<String, dynamic> dataRow = rendererContext.row.toJson();

                                  DetailDataTutupKasir? data = controller
                                      .dataListTutupKasir.dataTutupKasir
                                      ?.firstWhere((element) =>
                                          trimString(element.idTutupKasir.toString()) ==
                                          trimString(dataRow["id_tutup_kasir"].toString()));

                                  dataRow.updateAll((key, value) => value.toString());
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
                                      PopupMenuItem(
                                        value: 4,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.refresh,
                                              size: 24,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Refresh Data',
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
                                            SvgPicture.asset(iconEditSquare),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Edit Data',
                                              style: myTextTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
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
                                        dataRow.update(
                                            "id_tutup_kasir", (value) => int.parse(value));
                                        showDialogBase(
                                          width: 700,
                                          content: DialogTutupKasir(
                                            detail: data ?? DetailDataTutupKasir(),
                                            isEdit: false,
                                          ),
                                        );
                                      } else if (value == 2) {
                                        dataRow.update(
                                            "id_tutup_kasir", (value) => int.parse(value));
                                        showDialogBase(
                                          width: 700,
                                          content: DialogTutupKasir(
                                            detail: data ?? DetailDataTutupKasir(),
                                            isEdit: true,
                                          ),
                                        );
                                      } else if (value == 3) {
                                        showDialogBase(
                                          width: 400,
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda yakin ingin menghapus data ini?",
                                            onConfirm: () {
                                              controller.postRemoveTutupKasir(
                                                trimString(data?.idTutupKasir.toString()),
                                              );
                                            },
                                          ),
                                        );
                                      } else if (value == 4) {
                                        showDialogBase(
                                          width: 400,
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda yakin ingin merefresh data ini?",
                                            onConfirm: () {
                                              controller.postRefreshTutupKasir(
                                                trimString(data?.idTutupKasir.toString()),
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

                              cells['id_tutup_kasir'] = PlutoCell(
                                value: item["id_tutup_kasir"].toString(),
                              );

                              for (String column in controller.listTutupKasir) {
                                if (item.containsKey(column)) {
                                  cells[column] = PlutoCell(
                                    value: column == "id_supplier"
                                        ? getNamaSupplier(
                                            idSupplier: trimString(
                                            item[column].toString(),
                                          ))
                                        : trimStringStrip(
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
                                  16,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: 'Tutup Kasir',
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
                                    controller.dataFuture = controller.cariDataTutupKasir(
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
                                columnGroups: col,
                                createFooter: (stateManager) {
                                  return FooterTableWidget(
                                    page: controller.page,
                                    itemPerpage: controller.size,
                                    maxPage: controller.dataListTutupKasir.paging?.totalPage ?? 0,
                                    onChangePage: (value) {
                                      controller.page = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataTutupKasir(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataTutupKasir(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    totalRow: controller.dataListTutupKasir.paging?.totalItem ?? 0,
                                    onPressLeft: () {
                                      if (int.parse(controller.page) > 1) {
                                        controller.page =
                                            (int.parse(controller.page) - 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.cariDataTutupKasir(
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
                                        controller.dataFuture = controller.cariDataTutupKasir(
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
                              entity: 'Tutup Kasir',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Tutup Kasir",
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
  State<TutupKasirView> createState() => TutupKasirController();
}
