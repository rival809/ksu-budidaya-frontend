import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class BayarHutangAnggotaView extends StatefulWidget {
  final String idAnggota;
  const BayarHutangAnggotaView({
    Key? key,
    required this.idAnggota,
  }) : super(key: key);

  Widget build(context, BayarHutangAnggotaController controller) {
    controller.view = this;
    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            router.go("/koperasi/anggota");
                          },
                          child: SvgPicture.asset(
                            iconChevronLeft,
                            height: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Text(
                            "Detail Anggota",
                            style: myTextTheme.headlineLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        color: gray100,
                        border: Border.all(
                          width: 1.0,
                          color: blueGray50,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(iconInfo),
                          const SizedBox(
                            width: 8.0,
                          ),
                          OneData(
                            title: "ID Anggota",
                            subtitle: trimString(controller.widget.idAnggota),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          OneData(
                            title: "Nama Anggota",
                            subtitle: getNamaAnggota(
                                idAnggota: controller.widget.idAnggota),
                          ),
                        ],
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
                      textStep1: "Detail",
                      step2: controller.step2,
                      onTapStep2: () {
                        controller.onSwitchStep("2");
                      },
                      textStep2: "Transaksi",
                      step3: controller.step3,
                      onTapStep3: () {
                        controller.onSwitchStep("3");
                      },
                      textStep3: "Hutang",
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (controller.step1)
                      FutureBuilder(
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
                              DetailAnggotaResult result = snapshot.data;
                              List<TextEditingController> textController = [
                                TextEditingController(),
                                TextEditingController(),
                                TextEditingController(),
                                TextEditingController(),
                                TextEditingController(),
                              ];

                              bool obsecure = true;

                              DataDetailAnggota dataEdit = DataDetailAnggota();

                              final anggotaKey = GlobalKey<FormState>();

                              if (result.success == true) {
                                dataEdit = DataDetailAnggota.fromJson(
                                    result.data?.toJson() ?? {});
                                textController[0].text =
                                    trimString(dataEdit.idAnggota);
                                textController[1].text =
                                    trimString(dataEdit.nmAnggota);
                                textController[2].text =
                                    trimString(dataEdit.noWa);
                                textController[3].text = trimString(
                                    formatMoney(dataEdit.limitPinjaman));
                                textController[4].text =
                                    trimString(dataEdit.alamat);

                                return SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: Form(
                                    key: anggotaKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StaggeredGrid.count(
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          crossAxisCount: 1,
                                          children: [
                                            BaseForm(
                                              label: "Nama",
                                              hintText: "Masukkan Nama",
                                              textEditingController:
                                                  textController[1],
                                              onChanged: (value) {
                                                dataEdit.nmAnggota =
                                                    trimString(value);
                                              },
                                              validator: Validatorless.required(
                                                  "Data Wajib Diisi"),
                                            ),
                                            BaseForm(
                                              label: "No. Whatsapp",
                                              hintText: "Masukkan No. Whatsapp",
                                              textEditingController:
                                                  textController[2],
                                              validator: Validatorless.required(
                                                  "Data Wajib Diisi"),
                                              textInputFormater: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) {
                                                dataEdit.noWa =
                                                    trimString(value);
                                              },
                                            ),
                                            BaseForm(
                                              prefix: const BasePrefixRupiah(),
                                              label: "Limit ",
                                              hintText: "Masukkan Limit ",
                                              textEditingController:
                                                  textController[3],
                                              validator: Validatorless.required(
                                                  "Data Wajib Diisi"),
                                              textInputFormater: [
                                                ThousandsFormatter(),
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9.]')),
                                              ],
                                              onChanged: (value) {
                                                dataEdit.limitPinjaman =
                                                    removeComma(
                                                        trimString(value));
                                              },
                                            ),
                                            BaseForm(
                                              label: "Alamat",
                                              hintText: "Masukkan Alamat",
                                              validator: Validatorless.required(
                                                  "Data Wajib Diisi"),
                                              textEditingController:
                                                  textController[4],
                                              onChanged: (value) {
                                                dataEdit.alamat =
                                                    trimString(value);
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 24.0,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: BaseSecondaryButton(
                                                text: "Batal",
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16.0,
                                            ),
                                            Expanded(
                                              child: BasePrimaryButton(
                                                text: "Simpan",
                                                onPressed: () async {
                                                  if (anggotaKey.currentState!
                                                      .validate()) {
                                                    DataMap payload =
                                                        dataEdit.toJson();
                                                    payload.removeWhere(
                                                      (key, value) =>
                                                          key == "created_at",
                                                    );
                                                    payload.removeWhere(
                                                      (key, value) =>
                                                          key == "updated_at",
                                                    );
                                                    payload.removeWhere(
                                                      (key, value) =>
                                                          key == "hutang",
                                                    );

                                                    showCircleDialogLoading();
                                                    try {
                                                      AnggotaResult result =
                                                          await ApiService
                                                              .updateAnggota(
                                                        data: payload,
                                                      ).timeout(const Duration(
                                                              seconds: 30));

                                                      Navigator.pop(context);

                                                      if (result.success ==
                                                          true) {
                                                        showDialogBase(
                                                          content:
                                                              const DialogBerhasil(),
                                                        );

                                                        controller.dataFuture =
                                                            controller
                                                                .cariDetailAnggota();
                                                        controller.update();
                                                      }
                                                    } catch (e) {
                                                      Navigator.pop(context);

                                                      if (e.toString().contains(
                                                          "TimeoutException")) {
                                                        showInfoDialog(
                                                            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.",
                                                            context);
                                                      } else {
                                                        showInfoDialog(
                                                            e
                                                                .toString()
                                                                .replaceAll(
                                                                    "Exception: ",
                                                                    ""),
                                                            context);
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const ContainerTidakAda(
                                  entity: 'Divisi',
                                );
                              }
                            } else {
                              return const ContainerError();
                            }
                          } else {
                            return const ContainerTidakAda(
                              entity: "Divisi",
                            );
                          }
                        },
                      ),
                    if (controller.step2)
                      FutureBuilder(
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
                              PenjualanResult result = snapshot.data;
                              controller.dataListPenjualan =
                                  result.data ?? DataPenjualan();
                              List<dynamic> listData = controller
                                      .dataListPenjualan
                                      .toJson()["data_penjualan"] ??
                                  [];

                              if (listData.isNotEmpty) {
                                List<PlutoRow> rows = [];
                                List<PlutoColumn> columns = [];

                                columns.addAll(
                                  List.generate(
                                    controller.listPenjualanView.length,
                                    (index) {
                                      if (controller.listPenjualanView[index] ==
                                          "jenis_pembayaran") {
                                        return PlutoColumn(
                                          width: 75,
                                          backgroundColor: primaryColor,
                                          filterHintText:
                                              "Cari ${controller.listPenjualanView[index]}",
                                          title: convertTitle(
                                            controller.listPenjualanView[index],
                                          ),
                                          field: controller
                                              .listPenjualanView[index],
                                          type: PlutoColumnType.text(),
                                          renderer: (rendererContext) {
                                            Map<String, dynamic> dataRow =
                                                rendererContext.row.toJson();
                                            return CardLabel(
                                              cardColor: yellow50,
                                              cardTitle:
                                                  dataRow["jenis_pembayaran"]
                                                      .toString()
                                                      .toUpperCase(),
                                              cardTitleColor: yellow900,
                                              cardBorderColor: yellow50,
                                            );
                                          },
                                        );
                                      }
                                      if (controller.listPenjualanView[index] ==
                                          "jumlah") {
                                        return PlutoColumn(
                                          width: 75,
                                          backgroundColor: primaryColor,
                                          filterHintText:
                                              "Cari ${controller.listPenjualanView[index]}",
                                          title: "Qnt",
                                          field: controller
                                              .listPenjualanView[index],
                                          type: PlutoColumnType.number(
                                            locale: "id",
                                          ),
                                        );
                                      }
                                      return PlutoColumn(
                                        backgroundColor: primaryColor,
                                        filterHintText:
                                            "Cari ${controller.listPenjualanView[index]}",
                                        title: convertTitle(
                                          controller.listPenjualanView[index],
                                        ),
                                        field:
                                            controller.listPenjualanView[index],
                                        type: (controller.listPenjualanView[
                                                        index] ==
                                                    "total_nilai_beli" ||
                                                controller.listPenjualanView[
                                                        index] ==
                                                    "total_nilai_jual" ||
                                                controller.listPenjualanView[
                                                        index] ==
                                                    "jumlah")
                                            ? PlutoColumnType.number(
                                                locale: "id",
                                              )
                                            : (controller.listPenjualanView[
                                                        index] ==
                                                    "tg_pembelian")
                                                ? PlutoColumnType.date()
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

                                  cells['Aksi'] = PlutoCell(
                                    value: null,
                                  );

                                  for (String column
                                      in controller.listPenjualanView) {
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
                                      70 -
                                      16,
                                  child: PlutoGrid(
                                    noRowsWidget: const ContainerTidakAda(
                                      entity: 'Penjualan',
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
                                            controller.cariDataPenjualan(
                                          isAsc: controller.isAsc,
                                          field: event.column.field,
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
                                        columnTextStyle: myTextTheme.titleSmall
                                                ?.copyWith(
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
                                        maxPage: controller.dataListPenjualan
                                                .paging?.totalPage ??
                                            0,
                                        onChangePage: (value) {
                                          controller.page = trimString(value);
                                          controller.update();
                                          controller.dataFuture =
                                              controller.cariDataPenjualan();
                                          controller.update();
                                        },
                                        onChangePerPage: (value) {
                                          controller.page = "1";
                                          controller.size = trimString(value);
                                          controller.update();
                                          controller.dataFuture =
                                              controller.cariDataPenjualan();
                                          controller.update();
                                        },
                                        totalRow: controller.dataListPenjualan
                                                .paging?.totalItem ??
                                            0,
                                        onPressLeft: () {
                                          if (int.parse(controller.page) > 1) {
                                            controller.page =
                                                (int.parse(controller.page) - 1)
                                                    .toString();
                                            controller.update();
                                            controller.dataFuture =
                                                controller.cariDataPenjualan();
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
                                                controller.cariDataPenjualan();
                                            controller.update();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const ContainerTidakAda(
                                  entity: 'Penjualan',
                                );
                              }
                            } else {
                              return const ContainerError();
                            }
                          } else {
                            return const ContainerTidakAda(
                              entity: "Penjualan",
                            );
                          }
                        },
                      ),
                    if (controller.step3)
                      FutureBuilder(
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
                              HutangAnggotaResult result = snapshot.data;
                              controller.dataHutangAnggota =
                                  result.data ?? DataHutangAnggota();
                              List<dynamic> listData = controller
                                      .dataHutangAnggota
                                      .toJson()["data_hutang_anggota"] ??
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
                                    controller.listHutangAnggotaView.length,
                                    (index) {
                                      return PlutoColumn(
                                        backgroundColor: primaryColor,
                                        filterHintText:
                                            "Cari ${controller.listHutangAnggotaView[index]}",
                                        title: convertTitle(
                                          controller
                                              .listHutangAnggotaView[index],
                                        ),
                                        field: controller
                                            .listHutangAnggotaView[index],
                                        type: (controller.listHutangAnggotaView[
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
                                                    style:
                                                        myTextTheme.bodyMedium,
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
                                              content: DialogPelunasanAnggota(
                                                listHutang: result
                                                    .data?.dataHutangAnggota,
                                                dataHutang: controller
                                                        .result
                                                        .data
                                                        ?.dataHutangAnggota?[
                                                    rowIndex],
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
                                      in controller.listHutangAnggotaView) {
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
                                      50 -
                                      38,
                                  child: PlutoGrid(
                                    noRowsWidget: const ContainerTidakAda(
                                      entity: 'Hutang Anggota',
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
                                            controller.cariDataHutangAnggota(
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
                                        columnTextStyle: myTextTheme.titleSmall
                                                ?.copyWith(
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
                                        maxPage: controller.dataHutangAnggota
                                                .paging?.totalPage ??
                                            0,
                                        onChangePage: (value) {
                                          controller.page = trimString(value);
                                          controller.update();
                                          controller.dataFuture = controller
                                              .cariDataHutangAnggota();
                                          controller.update();
                                        },
                                        onChangePerPage: (value) {
                                          controller.page = "1";
                                          controller.size = trimString(value);
                                          controller.update();
                                          controller.dataFuture = controller
                                              .cariDataHutangAnggota();
                                          controller.update();
                                        },
                                        totalRow: controller.dataHutangAnggota
                                                .paging?.totalItem ??
                                            0,
                                        onPressLeft: () {
                                          if (int.parse(controller.page) > 1) {
                                            controller.page =
                                                (int.parse(controller.page) - 1)
                                                    .toString();
                                            controller.update();
                                            controller.dataFuture = controller
                                                .cariDataHutangAnggota();
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
                                            controller.dataFuture = controller
                                                .cariDataHutangAnggota();
                                            controller.update();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const ContainerTidakAda(
                                  entity: 'Hutang Anggota',
                                );
                              }
                            } else {
                              return const ContainerError();
                            }
                          } else {
                            return const ContainerTidakAda(
                              entity: "Hutang Anggota",
                            );
                          }
                        },
                      )
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
  State<BayarHutangAnggotaView> createState() => BayarHutangAnggotaController();
}
