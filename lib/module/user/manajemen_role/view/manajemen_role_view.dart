import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
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
          child: ScreenTypeLayout.builder(
            mobile: (BuildContext context) => Container(),
            desktop: (BuildContext context) => Container(
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
                    Row(
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
                              onPressed: () {},
                              text: "Refresh",
                              suffixIcon: iconCached,
                              isDense: true,
                            ),
                          ],
                        ),
                        BasePrimaryButton(
                          onPressed: () {},
                          text: "Tambah Role",
                          suffixIcon: iconAdd,
                          isDense: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    FutureBuilder(
                      future: controller.dataFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ContainerLoadingRole();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const ContainerErrorRole();
                          } else if (snapshot.hasData) {
                            ListRoleResult result = snapshot.data;
                            controller.dataListRole =
                                result.data ?? DataListRole();
                            List<dynamic> listData =
                                controller.dataListRole.dataRoles ?? [];
                            print("result.data");
                            print(controller.dataListRole.dataRoles);

                            if (listData.isNotEmpty) {
                              List<PlutoRow> rows = [];
                              List<PlutoColumn> columns = [];

                              columns.add(
                                PlutoColumn(
                                  width: 100,
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
                                  width: 120,
                                  backgroundColor: primaryColor,
                                  frozen: PlutoColumnFrozen.end,
                                  title: "AKSI",
                                  field: "Aksi",
                                  filterHintText: "",
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    final rowIndex = rendererContext.rowIdx;

                                    return BaseSecondaryButton(
                                      onPressed: () {
                                        // controller.getDetailVerif(
                                        //   trimString(
                                        //     result.data?.items?[rowIndex]
                                        //         ["id_edit"],
                                        //   ),
                                        // );
                                      },
                                      text: "Aksi",
                                      suffixIcon: iconChevronDown,
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
                                  noRowsWidget: const ContainerTidakAdaRole(),

                                  mode: PlutoGridMode.select,
                                  onLoaded: (event) {
                                    event.stateManager
                                        .setShowColumnFilter(true);
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
                                      gridBorderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    localeText: configLocale,
                                  ),
                                  columns: columns,
                                  rows: rows,
                                  // createFooter: (stateManager) {
                                  //   return FooterCariVerif(
                                  //     controller: controller,
                                  //     isMobile: true,
                                  //   );
                                  // },
                                ),
                              );
                            } else {
                              return const ContainerTidakAdaRole();
                            }
                          } else {
                            return const ContainerErrorRole();
                          }
                        } else {
                          return const ContainerTidakAdaRole();
                        }
                      },
                    ),
                  ],
                ),
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
