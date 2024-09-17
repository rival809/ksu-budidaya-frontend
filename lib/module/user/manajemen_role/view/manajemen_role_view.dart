import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ManajemenRoleView extends StatefulWidget {
  const ManajemenRoleView({Key? key}) : super(key: key);

  Widget build(context, ManajemenRoleController controller) {
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
                    "Role",
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
                        minWidth: MediaQuery.of(context).size.width - 32,
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
                                      controller.roleNameController,
                                  onChanged: (value) {},
                                  hintText: "Pencarian",
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BasePrimaryButton(
                                      onPressed: () {
                                        controller.dataFuture =
                                            controller.cariDataRole();
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
                                      controller.cariDataRole();
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
                                context: context,
                                content: const DialogTambahRole(
                                  isDetail: false,
                                ),
                              );
                            },
                            text: "Tambah Role",
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
                          ListRoleResult result = snapshot.data;
                          controller.dataListRole =
                              result.data ?? DataListRole();
                          List<dynamic> listData =
                              controller.dataListRole.toJson()["data_roles"] ??
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
                                  final rowIndex = rendererContext.rowIdx + 1;

                                  return Text(
                                    rendererContext.cell.value.toString(),
                                    style: myTextTheme.bodyMedium,
                                  );
                                },
                              ),
                            );

                            columns.addAll(List.generate(
                                controller.listRoleView.length, (index) {
                              return PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText:
                                    "Cari ${controller.listRoleView[index]}",
                                title: convertTitle(
                                  controller.listRoleView[index],
                                ),
                                field: controller.listRoleView[index],
                                type: PlutoColumnType.text(),
                              );
                            }));

                            columns.add(
                              PlutoColumn(
                                width: 75,
                                backgroundColor: primaryColor,
                                frozen: PlutoColumnFrozen.end,
                                title: "AKSI",
                                field: "Aksi",
                                filterHintText: "",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  final rowIndex = rendererContext.rowIdx;

                                  return DropdownAksi(
                                    text: "Aksi",
                                    onChange: (value) {
                                      if (value == 1) {
                                        showDialogBase(
                                          context: context,
                                          content: DialogTambahRole(
                                            isDetail: true,
                                            dataRole: result
                                                .data?.dataRoles?[rowIndex],
                                          ),
                                        );
                                      } else if (value == 2) {
                                        showDialogBase(
                                          context: context,
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda yakin ingin Menghapus Role",
                                            onConfirm: () {
                                              Navigator.pop(context);
                                              controller.postRemoveRole(
                                                trimString(result
                                                    .data
                                                    ?.dataRoles?[rowIndex]
                                                    .idRole),
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
                                    value: item[column],
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
                                  entity: "Role",
                                ),
                                mode: PlutoGridMode.select,
                                onLoaded: (event) {
                                  event.stateManager.setShowColumnFilter(true);
                                },
                                onSorted: (event) {
                                  // if (event.column.field != "Aksi") {
                                  //   controller.isAsc = !controller.isAsc;
                                  //   controller.update();
                                  //   controller.dataFuture =
                                  //       controller.cariEditTable(
                                  //           event.column.field,
                                  //           controller.isAsc);
                                  //   controller.update();
                                  // }
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
                                            .dataListRole.paging?.totalPage ??
                                        0,
                                    onChangePage: (value) {},
                                    onChangePerPage: (value) {},
                                    totalRow: controller
                                            .dataListRole.paging?.totalItem ??
                                        0,
                                    onPressLeft: () {},
                                    onPressRight: () {},
                                  );
                                },
                              ),
                            );
                          } else {
                            return const ContainerTidakAda(
                              entity: "Role",
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Role",
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
  State<ManajemenRoleView> createState() => ManajemenRoleController();
}
