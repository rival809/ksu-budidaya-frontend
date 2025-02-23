import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class SupplierView extends StatefulWidget {
  const SupplierView({Key? key}) : super(key: key);

  Widget build(context, SupplierController controller) {
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
                    "Supplier",
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
                                  textEditingController: controller.supplierNameController,
                                  onChanged: (value) {},
                                  hintText: "Pencarian",
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasePrimaryButton(
                                      onPressed: () {
                                        controller.field = null;
                                        controller.dataFuture = controller.cariDataSupplier();
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
                                  controller.dataFuture = controller.cariDataSupplier();
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
                                content: DialogSupplier(
                                  isDetail: false,
                                  data: DataDetailSupplier(),
                                ),
                              );
                            },
                            text: "Tambah Supplier",
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
                          SupplierResult result = snapshot.data;
                          controller.dataSupplier = result.data ?? DataSupplier();
                          List<dynamic> listData =
                              controller.dataSupplier.toJson()["data_supplier"] ?? [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            columns.addAll(List.generate(controller.listRoleView.length, (index) {
                              return PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText: "Cari ${controller.listRoleView[index]}",
                                title: convertTitle(
                                  controller.listRoleView[index],
                                ),
                                field: controller.listRoleView[index],
                                type: (controller.listRoleView[index] == "hutang_dagang")
                                    ? PlutoColumnType.number(
                                        locale: "id",
                                      )
                                    : PlutoColumnType.text(),
                              );
                            }));

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
                                  Map<String, dynamic> dataRow = rendererContext.row.toJson();
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
                                      PopupMenuItem(
                                        value: 4,
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
                                          width: 1200,
                                          content: DialogDetailSupplier(
                                            data: result.data?.dataSupplier?[rowIndex],
                                          ),
                                        );
                                      } else if (value == 2) {
                                        showDialogBase(
                                          width: 700,
                                          content: DialogSupplier(
                                            isDetail: true,
                                            data: result.data?.dataSupplier?[rowIndex],
                                          ),
                                        );
                                      } else if (value == 4) {
                                        showDialogBase(
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda yakin ingin Menghapus Supplier",
                                            onConfirm: () async {
                                              controller.postRemoveSupplier(
                                                trimString(
                                                  dataRow["id_supplier"],
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

                              // cells['no'] = PlutoCell(
                              //   value: item['persistentIndex'].toString(),
                              // );

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
                                  entity: 'Supplier',
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
                                    controller.dataFuture = controller.cariDataSupplier(
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
                                    maxPage: controller.dataSupplier.paging?.totalPage ?? 0,
                                    onChangePage: (value) {
                                      controller.page = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataSupplier(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.cariDataSupplier(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    totalRow: controller.dataSupplier.paging?.totalItem ?? 0,
                                    onPressLeft: () {
                                      if (int.parse(controller.page) > 1) {
                                        controller.page =
                                            (int.parse(controller.page) - 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.cariDataSupplier(
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
                                        controller.dataFuture = controller.cariDataSupplier(
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
                              entity: 'Supplier',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Supplier",
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
  State<SupplierView> createState() => SupplierController();
}
