// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ContainerListPembelian extends StatefulWidget {
  final PembelianController controller;

  const ContainerListPembelian({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerListPembelian> createState() => _ContainerListPembelianState();
}

class _ContainerListPembelianState extends State<ContainerListPembelian> {
  @override
  Widget build(BuildContext context) {
    PembelianController controller = widget.controller;
    return Column(
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
                        textEditingController:
                            controller.pembelianNameController,
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
                        controller.dataFuture = controller.cariDataPembelian();
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
                    controller.dataPembelian.details = [];
                    controller.update();
                    controller.isList = false;
                    controller.isDetail = false;
                    controller.isPpn = false;
                    controller.isDiskon = false;
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
                PembelianResult result = snapshot.data;
                controller.dataCashInOut = result.data ?? DataPembelian();
                for (var i = 0;
                    i < (controller.dataCashInOut.dataPembelian?.length ?? 0);
                    i++) {
                  controller.dataCashInOut.dataPembelian?[i].tgPembelian =
                      formatDateForView(trimString(controller
                          .dataCashInOut.dataPembelian?[i].tgPembelian));
                }
                List<dynamic> listData =
                    controller.dataCashInOut.toJson()["data_pembelian"] ?? [];

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
                                cardTitle: dataRow["jenis_pembayaran"]
                                    .toString()
                                    .toUpperCase(),
                                cardTitleColor: yellow900,
                                cardBorderColor: yellow50,
                              );
                            },
                          );
                        }
                        if (controller.listRoleView[index] == "jumlah") {
                          return PlutoColumn(
                            width: 75,
                            backgroundColor: primaryColor,
                            filterHintText:
                                "Cari ${controller.listRoleView[index]}",
                            title: "Qnt",
                            field: controller.listRoleView[index],
                            type: PlutoColumnType.number(
                              locale: "id",
                            ),
                          );
                        }
                        if (controller.listRoleView[index] == "tg_pembelian") {
                          return PlutoColumn(
                              // width: 85,
                              backgroundColor: primaryColor,
                              filterHintText: "Cari Tgl. Pembelian",
                              title: "TGL. PEMBELIAN",
                              field: controller.listRoleView[index],
                              type: PlutoColumnType.date(format: 'dd-MM-yyyy'));
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
                                  controller.listRoleView[index] == "jumlah")
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
                              DetailDataPembelian dataDetail =
                                  result.data?.dataPembelian?[rowIndex] ??
                                      DetailDataPembelian();
                              controller.dataPembelian.jenisPembayaran =
                                  dataDetail.jenisPembayaran;
                              controller.dataPembelian.idSupplier =
                                  dataDetail.idSupplier;
                              controller.dataPembelian.jumlah =
                                  trimString(dataDetail.jumlah.toString());
                              controller.dataPembelian.keterangan =
                                  dataDetail.keterangan;
                              controller.dataPembelian.nmSupplier =
                                  dataDetail.nmSupplier;
                              controller.dataPembelian.tgPembelian =
                                  dataDetail.tgPembelian;
                              controller.dataPembelian.totalHargaBeli =
                                  dataDetail.totalHargaBeli;
                              controller.dataPembelian.totalHargaJual =
                                  dataDetail.totalHargaJual;

                              controller.postDetailPurchase(
                                trimString(
                                  result.data?.dataPembelian?[rowIndex]
                                      .idPembelian,
                                ),
                              );
                              update();
                            } else if (value == 2) {
                              showDialogBase(
                                content: DialogKonfirmasi(
                                  textKonfirmasi:
                                      "Apakah Anda yakin ingin Menghapus Data Pembelian",
                                  onConfirm: () async {
                                    controller.postRemovePurchase(
                                      trimString(
                                        result.data?.dataPembelian?[rowIndex]
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
                        entity: 'Pembelian',
                      ),
                      mode: PlutoGridMode.select,
                      onLoaded: (event) {
                        event.stateManager.setShowColumnFilter(true);
                      },
                      onSorted: (event) {
                        if (event.column.field != "Aksi") {
                          controller.isAsc = !controller.isAsc;
                          controller.update();
                          controller.dataFuture = controller.cariDataPembelian(
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
                          maxPage:
                              controller.dataCashInOut.paging?.totalPage ?? 0,
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
                          totalRow:
                              controller.dataCashInOut.paging?.totalItem ?? 0,
                          onPressLeft: () {
                            if (int.parse(controller.page) > 1) {
                              controller.page =
                                  (int.parse(controller.page) - 1).toString();
                              controller.update();
                              controller.dataFuture =
                                  controller.cariDataPembelian();
                              controller.update();
                            }
                          },
                          onPressRight: () {
                            if (int.parse(controller.page) <
                                (result.data?.paging?.totalPage ?? 0)) {
                              controller.page =
                                  (int.parse(controller.page) + 1).toString();
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
                    entity: 'Pembelian',
                  );
                }
              } else {
                return const ContainerError();
              }
            } else {
              return const ContainerTidakAda(
                entity: "Pembelian",
              );
            }
          },
        ),
      ],
    );
  }
}
