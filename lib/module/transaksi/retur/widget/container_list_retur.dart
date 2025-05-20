// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ContainerListRetur extends StatefulWidget {
  final ReturController controller;

  const ContainerListRetur({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerListRetur> createState() => _ContainerListReturState();
}

class _ContainerListReturState extends State<ContainerListRetur> {
  @override
  Widget build(BuildContext context) {
    ReturController controller = widget.controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daftar Retur",
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
                        textEditingController: controller.returSearchController,
                        onChanged: (value) {},
                        hintText: "Pencarian",
                        suffix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BasePrimaryButton(
                            onPressed: () {
                              controller.dataFuture = controller.cariDataRetur();
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
                        controller.dataFuture = controller.cariDataRetur();
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
                BasePrimaryButton(
                  onPressed: () {
                    controller.dataPayloadRetur = ReturPayloadModel();
                    controller.update();
                    controller.isList = false;
                    controller.isDetail = false;
                    controller.update();
                    update();
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
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const ContainerError();
              } else if (snapshot.hasData) {
                ReturResult result = snapshot.data;
                controller.dataRetur = result.data ?? DataRetur();

                List<dynamic> listData = controller.dataRetur.toJson()["data_retur"] ?? [];

                if (listData.isNotEmpty) {
                  List<PlutoRow> rows = [];
                  List<PlutoColumn> columns = [];

                  columns.addAll(
                    List.generate(
                      controller.listReturView.length,
                      (index) {
                        return PlutoColumn(
                          backgroundColor: primaryColor,
                          filterHintText: "Cari ${controller.listReturView[index]}",
                          title: convertTitle(
                            controller.listReturView[index],
                          ),
                          field: controller.listReturView[index],
                          type: (controller.listReturView[index] == "total_nilai_beli")
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
                        Map<String, dynamic> dataRow = rendererContext.row.toJson();
                        DetailDataRetur dataDetail = result.data?.dataRetur?.firstWhere((element) =>
                                trimString(element.idRetur) == trimString(dataRow["Aksi"])) ??
                            DetailDataRetur();
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
                              controller.dataPayloadRetur.idPembelian = dataDetail.idPembelian;
                              controller.dataPayloadRetur.idSupplier = dataDetail.idSupplier;
                              controller.dataPayloadRetur.jumlah = dataDetail.jumlah.toString();
                              controller.dataPayloadRetur.keterangan = dataDetail.keterangan;
                              controller.dataPayloadRetur.nmSupplier = dataDetail.nmSupplier;
                              controller.dataPayloadRetur.tgRetur = dataDetail.tgRetur;
                              controller.dataPayloadRetur.totalNilaiBeli =
                                  dataDetail.totalNilaiBeli;

                              controller.postDetailPurchase(
                                trimString(
                                  dataDetail.idRetur,
                                ),
                              );
                              update();
                            } else if (value == 2) {
                              showDialogBase(
                                content: DialogKonfirmasi(
                                  textKonfirmasi:
                                      "Apakah Anda yakin ingin Menghapus Data Pembelian",
                                  onConfirm: () async {
                                    controller.postRemoveRetur(
                                      trimString(
                                        dataDetail.idRetur,
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

                  List<dynamic> listDataWithIndex = List.generate(listData.length, (index) {
                    return {
                      ...listData[index],
                      'persistentIndex': index + 1,
                    };
                  });
                  rows = listDataWithIndex.map((item) {
                    Map<String, PlutoCell> cells = {};

                    cells['Aksi'] = PlutoCell(
                      value: trimStringStrip(
                        item["id_retur"].toString(),
                      ),
                    );

                    for (String column in controller.listReturView) {
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
                        entity: 'Retur',
                      ),
                      mode: PlutoGridMode.select,
                      onLoaded: (event) {
                        event.stateManager.setShowColumnFilter(true);
                      },
                      onSorted: (event) {
                        if (event.column.field != "Aksi") {
                          controller.isAsc = !controller.isAsc;
                          controller.update();
                          controller.dataFuture = controller.cariDataRetur(
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
                          columnTextStyle: myTextTheme.titleSmall?.copyWith(color: neutralWhite) ??
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
                          maxPage: controller.dataRetur.paging?.totalPage ?? 0,
                          onChangePage: (value) {
                            controller.page = trimString(value);
                            controller.update();
                            controller.dataFuture = controller.cariDataRetur();
                            controller.update();
                          },
                          onChangePerPage: (value) {
                            controller.page = "1";
                            controller.size = trimString(value);
                            controller.update();
                            controller.dataFuture = controller.cariDataRetur();
                            controller.update();
                          },
                          totalRow: controller.dataRetur.paging?.totalItem ?? 0,
                          onPressLeft: () {
                            if (int.parse(controller.page) > 1) {
                              controller.page = (int.parse(controller.page) - 1).toString();
                              controller.update();
                              controller.dataFuture = controller.cariDataRetur();
                              controller.update();
                            }
                          },
                          onPressRight: () {
                            if (int.parse(controller.page) <
                                (result.data?.paging?.totalPage ?? 0)) {
                              controller.page = (int.parse(controller.page) + 1).toString();
                              controller.update();
                              controller.dataFuture = controller.cariDataRetur();
                              controller.update();
                            }
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const ContainerTidakAda(
                    entity: 'Retur',
                  );
                }
              } else {
                return const ContainerError();
              }
            } else {
              return const ContainerTidakAda(
                entity: "Retur",
              );
            }
          },
        ),
      ],
    );
  }
}
