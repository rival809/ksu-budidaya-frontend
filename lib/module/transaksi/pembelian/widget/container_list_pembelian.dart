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
                              controller.field = null;
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
                        controller.field = null;
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
                Row(
                  children: [
                    BaseSecondaryButton(
                      onPressed: () {
                        doGenerateLaporanPembelian(controller: controller);
                      },
                      text: "Cetak Laporan Pembelian",
                      suffixIcon: iconPrint,
                      isDense: true,
                    ),
                    const SizedBox(
                      width: 16.0,
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
                              String jenisBayar = dataRow["jenis_pembayaran"]
                                  .toString()
                                  .toUpperCase();
                              return CardLabel(
                                cardColor:
                                    jenisBayar == "TUNAI" ? green50 : yellow50,
                                cardTitle: jenisBayar,
                                cardTitleColor: jenisBayar == "TUNAI"
                                    ? green900
                                    : yellow900,
                                cardBorderColor:
                                    jenisBayar == "TUNAI" ? green50 : yellow50,
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
                        // final rowIndex = rendererContext.rowIdx;
                        Map<String, dynamic> dataRow =
                            rendererContext.row.toJson();
                        DetailDataPembelian dataDetail =
                            result.data?.dataPembelian?.firstWhere((element) =>
                                    trimString(element.idPembelian) ==
                                    trimString(dataRow["Aksi"])) ??
                                DetailDataPembelian();
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
                              DetailDataPembelian dataPembelian =
                                  dataDetail.copyWith();
                              controller.dataPembelian.jenisPembayaran =
                                  dataPembelian.jenisPembayaran;
                              controller.dataPembelian.idSupplier =
                                  dataPembelian.idSupplier;
                              controller.dataPembelian.jumlah =
                                  trimString(dataPembelian.jumlah.toString());
                              controller.dataPembelian.keterangan =
                                  dataPembelian.keterangan;
                              controller.dataPembelian.nmSupplier =
                                  dataPembelian.nmSupplier;
                              controller.dataPembelian.tgPembelian =
                                  dataPembelian.tgPembelian;
                              controller.dataPembelian.totalHargaBeli =
                                  dataPembelian.totalHargaBeli;
                              controller.dataPembelian.totalHargaJual =
                                  dataPembelian.totalHargaJual;

                              controller.postDetailPurchase(
                                trimString(
                                  dataPembelian.idPembelian,
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
                                        dataDetail.idPembelian,
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
                      value: trimStringStrip(
                        item["id_pembelian"].toString(),
                      ),
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
                          controller.field = event.column.field;
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
                                controller.cariDataPembelian(
                              isAsc: controller.isAsc,
                              field: controller.field,
                            );
                            controller.update();
                          },
                          onChangePerPage: (value) {
                            controller.page = "1";
                            controller.size = trimString(value);
                            controller.update();
                            controller.dataFuture =
                                controller.cariDataPembelian(
                              isAsc: controller.isAsc,
                              field: controller.field,
                            );
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
                                  controller.cariDataPembelian(
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
                              controller.dataFuture =
                                  controller.cariDataPembelian(
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
