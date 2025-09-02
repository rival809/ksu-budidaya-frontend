// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class DialogDetailSupplier extends StatefulWidget {
  const DialogDetailSupplier({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DataDetailSupplier? data;

  @override
  State<DialogDetailSupplier> createState() => _DialogDetailSupplierState();
}

class _DialogDetailSupplierState extends State<DialogDetailSupplier> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool step1 = true;
  bool step2 = false;
  bool step3 = false;
  bool step4 = false;

  Future<dynamic>? dataFuture;

  DataProduct dataProduct = DataProduct();
  ProductResult result = ProductResult();
  DataPembelian dataPembelian = DataPembelian();
  PembelianResult resultPembelian = PembelianResult();
  DataHutangDagang dataHutangDagang = DataHutangDagang();
  HutangDagangResult resultHutangDagang = HutangDagangResult();

  List<String> listProdukView = [
    "id_product",
    "nm_product",
    "harga_beli",
    "harga_jual",
    "jumlah",
  ];

  List<String> listPenjualanView = [
    "tg_pembelian",
    "id_pembelian",
    "jenis_pembayaran",
    "jumlah",
    "total_harga_beli",
    "total_harga_jual",
  ];

  List<String> listHutangDagangView = [
    "id_pembelian",
    "tg_hutang",
    "nm_supplier",
    "nominal",
    "keterangan",
  ];

  String page = "1";
  String size = "500";
  bool isAsc = true;

  cariDataProduct({bool? isAsc, String? field}) async {
    try {
      result = ProductResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
        "id_supplier": trimString(widget.data?.idSupplier),
      };

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listProduct(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDataPembelian({
    bool? isAsc,
    String? field,
  }) async {
    try {
      resultPembelian = PembelianResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
        "id_supplier": trimString(widget.data?.idSupplier),
      };

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      resultPembelian = await ApiService.listPembelian(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return resultPembelian;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDataHutangDagang({
    bool? isAsc,
    String? field,
  }) async {
    try {
      resultHutangDagang = HutangDagangResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
        "id_supplier": trimString(widget.data?.idSupplier),
      };

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      resultHutangDagang = await ApiService.listHutangDagang(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return resultHutangDagang;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  PlutoColumnType typeField(String field) {
    switch (field) {
      case "jumlah":
        return PlutoColumnType.number(locale: "id");
      case "harga_beli":
        return PlutoColumnType.number(locale: "id");
      case "harga_jual":
        return PlutoColumnType.number(locale: "id");

      default:
        return PlutoColumnType.text();
    }
  }

  @override
  void initState() {
    textController[0].text = trimString(widget.data?.idSupplier);
    textController[1].text = trimString(widget.data?.nmSupplier);
    textController[2].text = trimString(widget.data?.nmPemilik);
    textController[3].text = trimString(widget.data?.alamat);
    super.initState();
  }

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        step3 = false;
        step4 = false;
        break;
      case "2":
        step1 = false;
        step2 = true;
        step3 = false;
        step4 = false;
        dataFuture = cariDataProduct();
        break;
      case "3":
        step1 = false;
        step2 = false;
        step3 = true;
        step4 = false;
        dataFuture = cariDataPembelian();
      case "4":
        step1 = false;
        step2 = false;
        step3 = false;
        step4 = true;
        dataFuture = cariDataHutangDagang();
        break;
      default:
        step1 = true;
        step2 = false;
        step3 = false;
        step4 = false;
    }
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Supplier",
            style: myTextTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
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
                  title: "ID SUPLIER",
                  subtitle: trimString(widget.data?.idSupplier),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                OneData(
                  title: "Nama Supplier",
                  subtitle: trimString(widget.data?.nmSupplier),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ProsesStep(
            step1: step1,
            onTapStep1: () {
              onSwitchStep("1");
            },
            textStep1: "Detail",
            step2: step2,
            onTapStep2: () {
              onSwitchStep("2");
            },
            textStep2: "Produk",
            step3: step3,
            onTapStep3: () {
              onSwitchStep("3");
            },
            textStep3: "Transaksi",
            step4: step4,
            onTapStep4: () {
              onSwitchStep("4");
            },
            textStep4: "Hutang",
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (step1)
            Column(
              children: [
                BaseForm(
                  label: "Pemilik",
                  readOnly: true,
                  hintText: "Masukkan Pemilik",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[0],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "Nama PIC",
                  readOnly: true,
                  hintText: "Masukkan Pemilik",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[1],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "No. Whatsapp",
                  readOnly: true,
                  hintText: "Masukkan No. Whatsapp",
                  textEditingController: textController[2],
                  textInputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "Alamat",
                  readOnly: true,
                  hintText: "Masukkan Alamat",
                  textEditingController: textController[3],
                ),
              ],
            ),
          if (step2)
            FutureBuilder(
              future: dataFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(
                      "Terjadi kesalahan saat mengambil data.",
                      textAlign: TextAlign.center,
                      style: myTextTheme.bodyMedium,
                    );
                  } else if (snapshot.hasData) {
                    ProductResult result = snapshot.data;
                    dataProduct = result.data ?? DataProduct();
                    List<dynamic> listData = dataProduct.toJson()["data_product"] ?? [];

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
                          listProdukView.length,
                          (index) {
                            return PlutoColumn(
                              backgroundColor: primaryColor,
                              filterHintText: "Cari ${listProdukView[index]}",
                              title: convertTitle(
                                listProdukView[index],
                              ),
                              field: listProdukView[index],
                              type: typeField(
                                listProdukView[index],
                              ),
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

                        cells['no'] = PlutoCell(
                          value: item['persistentIndex'].toString(),
                        );

                        cells['Aksi'] = PlutoCell(
                          value: null,
                        );

                        for (String column in listProdukView) {
                          if (item.containsKey(column)) {
                            cells[column] = PlutoCell(
                              value: trimStringStrip(item[column].toString()),
                            );
                          }
                        }

                        return PlutoRow(cells: cells);
                      }).toList();
                      double rowHeight = 46.0;

                      return SizedBox(
                        height: (rows.length * rowHeight) + rowHeight * 3,
                        child: PlutoGrid(
                          noRowsWidget: const ContainerTidakAda(
                            entity: 'Product',
                          ),
                          mode: PlutoGridMode.select,
                          onLoaded: (event) {
                            event.stateManager.setShowColumnFilter(true);
                            event.stateManager.columnFooterHeight = 68;
                          },
                          onSorted: (event) {
                            if (event.column.field != "Aksi") {
                              isAsc = !isAsc;
                              update();
                              dataFuture = cariDataProduct(
                                isAsc: isAsc,
                                field: event.column.field,
                              );
                              update();
                            }
                          },
                          configuration: PlutoGridConfiguration(
                            columnSize: const PlutoGridColumnSizeConfig(
                              autoSizeMode: PlutoAutoSizeMode.scale,
                            ),
                            style: PlutoGridStyleConfig(
                              cellTextStyle: myTextTheme.bodyMedium?.copyWith(color: gray900) ??
                                  const TextStyle(),
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
                              widthDialog: 1168,
                              page: page,
                              itemPerpage: size,
                              maxPage: dataProduct.paging?.totalPage ?? 0,
                              onChangePage: (value) {
                                page = trimString(value);
                                update();
                                dataFuture = cariDataProduct();
                                update();
                              },
                              onChangePerPage: (value) {
                                page = "1";
                                size = trimString(value);
                                update();
                                dataFuture = cariDataProduct();
                                update();
                              },
                              totalRow: dataProduct.paging?.totalItem ?? 0,
                              onPressLeft: () {
                                if (int.parse(page) > 1) {
                                  page = (int.parse(page) - 1).toString();
                                  update();
                                  dataFuture = cariDataProduct();
                                  update();
                                }
                              },
                              onPressRight: () {
                                if (int.parse(page) < (result.data?.paging?.totalPage ?? 0)) {
                                  page = (int.parse(page) + 1).toString();
                                  update();
                                  dataFuture = cariDataProduct();
                                  update();
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Tidak ada data Produk.",
                                  style: myTextTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  } else {
                    return Text(
                      "Terjadi kesalahan saat mengambil data.",
                      textAlign: TextAlign.center,
                      style: myTextTheme.bodyMedium,
                    );
                  }
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Tidak ada data Produk.",
                              style: myTextTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          if (step3)
            FutureBuilder(
              future: dataFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const ContainerError();
                  } else if (snapshot.hasData) {
                    PembelianResult result = snapshot.data;
                    dataPembelian = result.data ?? DataPembelian();
                    for (var i = 0; i < (dataPembelian.dataPembelian?.length ?? 0); i++) {
                      dataPembelian.dataPembelian?[i].tgPembelian = formatDateForView(
                          trimString(dataPembelian.dataPembelian?[i].tgPembelian));
                    }
                    List<dynamic> listData = dataPembelian.toJson()["data_pembelian"] ?? [];

                    if (listData.isNotEmpty) {
                      List<PlutoRow> rows = [];
                      List<PlutoColumn> columns = [];

                      columns.addAll(
                        List.generate(
                          listPenjualanView.length,
                          (index) {
                            if (listPenjualanView[index] == "jenis_pembayaran") {
                              return PlutoColumn(
                                // width: 75,
                                backgroundColor: primaryColor,
                                filterHintText: "Cari ${listPenjualanView[index]}",
                                title: convertTitle(
                                  listPenjualanView[index],
                                ),
                                field: listPenjualanView[index],
                                type: PlutoColumnType.text(),
                                renderer: (rendererContext) {
                                  Map<String, dynamic> dataRow = rendererContext.row.toJson();
                                  return CardLabel(
                                    cardColor: yellow50,
                                    cardTitle: dataRow["jenis_pembayaran"].toString().toUpperCase(),
                                    cardTitleColor: yellow900,
                                    cardBorderColor: yellow50,
                                  );
                                },
                              );
                            }
                            if (listPenjualanView[index] == "jumlah") {
                              return PlutoColumn(
                                width: 75,
                                backgroundColor: primaryColor,
                                filterHintText: "Cari ${listPenjualanView[index]}",
                                title: "Jumlah",
                                field: listPenjualanView[index],
                                type: PlutoColumnType.number(
                                  locale: "id",
                                ),
                              );
                            }
                            if (listPenjualanView[index] == "tg_pembelian") {
                              return PlutoColumn(
                                  // width: 75,
                                  backgroundColor: primaryColor,
                                  filterHintText: "Cari Tgl. Pembelian",
                                  title: "Tanggal",
                                  field: listPenjualanView[index],
                                  type: PlutoColumnType.date(format: 'dd-MM-yyyy'));
                            }
                            return PlutoColumn(
                              backgroundColor: primaryColor,
                              filterHintText: "Cari ${listPenjualanView[index]}",
                              title: convertTitle(
                                listPenjualanView[index],
                              ),
                              field: listPenjualanView[index],
                              type: (listPenjualanView[index] == "total_harga_beli" ||
                                      listPenjualanView[index] == "total_harga_jual" ||
                                      listPenjualanView[index] == "jumlah")
                                  ? PlutoColumnType.number(
                                      locale: "id",
                                    )
                                  : PlutoColumnType.text(),
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
                          value: null,
                        );

                        for (String column in listPenjualanView) {
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
                            248 -
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
                              isAsc = !isAsc;
                              update();
                              dataFuture = cariDataPembelian(
                                isAsc: isAsc,
                                field: event.column.field,
                              );
                              update();
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
                              widthDialog: 1168,
                              page: page,
                              itemPerpage: size,
                              maxPage: dataPembelian.paging?.totalPage ?? 0,
                              onChangePage: (value) {
                                page = trimString(value);
                                update();
                                dataFuture = cariDataPembelian();
                                update();
                              },
                              onChangePerPage: (value) {
                                page = "1";
                                size = trimString(value);
                                update();
                                dataFuture = cariDataPembelian();
                                update();
                              },
                              totalRow: dataPembelian.paging?.totalItem ?? 0,
                              onPressLeft: () {
                                if (int.parse(page) > 1) {
                                  page = (int.parse(page) - 1).toString();
                                  update();
                                  dataFuture = cariDataPembelian();
                                  update();
                                }
                              },
                              onPressRight: () {
                                if (int.parse(page) < (result.data?.paging?.totalPage ?? 0)) {
                                  page = (int.parse(page) + 1).toString();
                                  update();
                                  dataFuture = cariDataPembelian();
                                  update();
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Tidak ada data Pembelian.",
                                  style: myTextTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        "Terjadi kesalahan saat mengambil data.",
                        textAlign: TextAlign.center,
                        style: myTextTheme.bodyMedium,
                      ),
                    );
                  }
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Tidak ada data Pembelian.",
                              style: myTextTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          if (step4)
            FutureBuilder(
              future: dataFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ContainerLoadingRole();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const ContainerError();
                  } else if (snapshot.hasData) {
                    HutangDagangResult result = snapshot.data;
                    dataHutangDagang = result.data ?? DataHutangDagang();
                    List<dynamic> listData = dataHutangDagang.toJson()["data_hutang_dagang"] ?? [];

                    if (listData.isNotEmpty) {
                      List<PlutoRow> rows = [];
                      List<PlutoColumn> columns = [];

                      columns.addAll(
                        List.generate(
                          listHutangDagangView.length,
                          (index) {
                            return PlutoColumn(
                              backgroundColor: primaryColor,
                              filterHintText: "Cari ${listHutangDagangView[index]}",
                              title: convertTitle(
                                listHutangDagangView[index],
                              ),
                              field: listHutangDagangView[index],
                              type: (listHutangDagangView[index] == "nominal")
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
                            return DropdownAksi(
                              text: "Aksi",
                              listItem: [
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        iconInfo,
                                        colorFilter: colorFilterGray600,
                                      ),
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
                                        iconAccountBalanceWallet,
                                        colorFilter: colorFilterGray600,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Bayar Hutang',
                                        style: myTextTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onChange: (value) async {
                                if (value == 1) {
                                  try {
                                    DetailPembelianResult result = await ApiService.detailPembelian(
                                      data: {"id_pembelian": trimString(dataRow["id_pembelian"])},
                                    ).timeout(const Duration(seconds: 30));

                                    if (result.success == true) {
                                      showDialogBase(
                                        barrierDismissible: true,
                                        width: Get.width,
                                        content: DialogDetailPembelian(
                                          dataPembelian: result,
                                          nmSuplier: trimString(widget.data?.nmSupplier),
                                          idSuplier: trimString(widget.data?.idSupplier),
                                          tgTransaksi: trimString(resultHutangDagang
                                              .data?.dataHutangDagang?[rowIndex].tgHutang),
                                        ),
                                      );

                                      update();
                                    }
                                  } catch (e) {
                                    if (e.toString().contains("TimeoutException")) {
                                      showInfoDialog(
                                          "Tidak Mendapat Respon Dari Server! Silakan coba lagi.",
                                          context);
                                    } else {
                                      showInfoDialog(
                                          e.toString().replaceAll("Exception: ", ""), context);
                                    }
                                  }
                                } else if (value == 2) {
                                  showDialogBase(
                                    width: 700,
                                    content: DialogTambahPelunasan(
                                      isPageBayarHutang: false,
                                      nominal: trimString(resultHutangDagang
                                          .data?.dataHutangDagang?[rowIndex].nominal),
                                      idHutangDagang: trimString(resultHutangDagang
                                          .data?.dataHutangDagang?[rowIndex].idHutangDagang),
                                      idTransaksi: trimString(resultHutangDagang
                                          .data?.dataHutangDagang?[rowIndex].idPembelian),
                                      idSupplier: trimString(widget.data?.idSupplier),
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
                          value: null,
                        );

                        for (String column in listHutangDagangView) {
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
                            64 -
                            56,
                        child: PlutoGrid(
                          noRowsWidget: const ContainerTidakAda(
                            entity: 'Hutang Dagang',
                          ),
                          mode: PlutoGridMode.select,
                          onLoaded: (event) {
                            event.stateManager.setShowColumnFilter(true);
                          },
                          onSorted: (event) {
                            if (event.column.field != "Aksi") {
                              isAsc = !isAsc;
                              update();
                              dataFuture = cariDataHutangDagang(
                                isAsc: isAsc,
                                field: (event.column.field == "cash_in" ||
                                        event.column.field == "cash_out")
                                    ? "nominal"
                                    : event.column.field,
                              );
                              update();
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
                            double totalHutang = 0;
                            for (var i = 0; i < (result.data?.dataHutangDagang?.length ?? 0); i++) {
                              totalHutang +=
                                  double.parse(result.data?.dataHutangDagang?[i].nominal ?? "0");
                            }
                            return FooterTableWidget(
                              widthDialog: 1162,
                              page: page,
                              itemPerpage: size,
                              maxPage: dataHutangDagang.paging?.totalPage ?? 0,
                              onChangePage: (value) {
                                page = trimString(value);
                                update();
                                dataFuture = cariDataHutangDagang();
                                update();
                              },
                              onChangePerPage: (value) {
                                page = "1";
                                size = trimString(value);
                                update();
                                dataFuture = cariDataHutangDagang();
                                update();
                              },
                              totalRow: dataHutangDagang.paging?.totalItem ?? 0,
                              onPressLeft: () {
                                if (int.parse(page) > 1) {
                                  page = (int.parse(page) - 1).toString();
                                  update();
                                  dataFuture = cariDataHutangDagang();
                                  update();
                                }
                              },
                              onPressRight: () {
                                if (int.parse(page) < (result.data?.paging?.totalPage ?? 0)) {
                                  page = (int.parse(page) + 1).toString();
                                  update();
                                  dataFuture = cariDataHutangDagang();
                                  update();
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Tidak ada data Hutang Dagang.",
                                  style: myTextTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        "Terjadi kesalahan saat mengambil data.",
                        textAlign: TextAlign.center,
                        style: myTextTheme.bodyMedium,
                      ),
                    );
                  }
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Tidak ada data Hutang Dagang.",
                              style: myTextTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          const SizedBox(
            height: 16.0,
          ),
          BaseSecondaryButton(
            text: "Kembali",
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
