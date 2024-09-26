// ignore_for_file: camel_case_types
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ContainerDetailPembelian extends StatefulWidget {
  final List<DataDetailPembelian> dataDetail;
  final DetailDataPembelian dataSupplier;
  final PembelianController controller;

  const ContainerDetailPembelian({
    Key? key,
    required this.controller,
    required this.dataSupplier,
    required this.dataDetail,
  }) : super(key: key);

  @override
  State<ContainerDetailPembelian> createState() =>
      _ContainerDetailPembelianState();
}

class _ContainerDetailPembelianState extends State<ContainerDetailPembelian> {
  List<DataDetailPembelian> dataDetail = [];
  DetailDataPembelian dataSupplier = DetailDataPembelian();

  Future<dynamic>? dataFuturePembelian;

  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool isPpn = false;
  bool isDiskon = false;

  tambahData(List<DataDetailPembelian> data) async {
    try {
      CreatePembelianModel data = CreatePembelianModel();

      data.details = widget.dataDetail;

      return data;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    dataFuturePembelian = tambahData(widget.dataDetail);
    dataDetail = widget.dataDetail;
    dataSupplier = widget.dataSupplier.copyWith();
    textController[0].text = formatDate(
      formatDateToYearMonthDay(
        trimString(dataSupplier.tgPembelian),
      ),
    );
    textController[1].text = trimString(dataSupplier.keterangan);
  }

  @override
  void dispose() {
    super.dispose();
    textController[0].dispose();
    textController[1].dispose();
  }

  @override
  Widget build(BuildContext context) {
    PembelianController controller = widget.controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                controller.isList = true;
                controller.dataDetail = DataDetailPembelian();
                controller.dataSupplier = DetailDataPembelian();
                controller.update();
                update();
              },
              child: SvgPicture.asset(
                iconChevronLeft,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              controller.isDetail ? "Detail Pembelian" : "Tambah Pembelian",
              style: myTextTheme.headlineLarge,
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BaseForm(
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconCalendarMonth,
                    height: 16,
                    colorFilter: colorFilterPrimary,
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await initSelectedDate(
                    initValue: dataSupplier.tgPembelian,
                  );

                  if (selectedDate != null) {
                    dataSupplier.tgPembelian = selectedDate.toString();
                    textController[0].text =
                        formatDate(selectedDate.toString());
                    update();
                  }
                },
                label: "Tanggal Transaksi",
                hintText: "Masukkan Tanggal Transaksi",
                textInputFormater: [
                  UpperCaseTextFormatter(),
                ],
                validator: Validatorless.required("Data Wajib Diisi"),
                autoValidate: AutovalidateMode.onUserInteraction,
                textEditingController: textController[0],
                enabled: true,
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              flex: 2,
              child: BaseDropdownButton<DataDetailSupplier>(
                hint: "Pilih  Supplier",
                label: "Supplier",
                itemAsString: (item) => item.supplierAsString(),
                items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                value: dataSupplier.idSupplier?.isEmpty ?? true
                    ? null
                    : DataDetailSupplier(
                        idSupplier: dataSupplier.idSupplier,
                        nmSupplier: trimString(
                          getNamaSupplier(
                              idSupplier: trimString(dataSupplier.idSupplier)),
                        ),
                      ),
                onChanged: (value) {
                  dataSupplier.idSupplier = trimString(value?.idSupplier);
                  update();
                },
                autoValidate: AutovalidateMode.onUserInteraction,
                validator: Validatorless.required("Data Wajib Diisi"),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: BaseDropdownButton<MetodeBayar>(
                hint: "Pilih Pembayaran",
                label: "Pembayaran",
                isSearch: false,
                itemAsString: (item) => item.metodeBayarAsString(),
                items: metodeBayarList,
                value: dataSupplier.jenisPembayaran?.isEmpty ?? true
                    ? null
                    : MetodeBayar(
                        metode: trimString(dataSupplier.jenisPembayaran),
                      ),
                onChanged: (value) {
                  dataSupplier.jenisPembayaran = trimString(value?.metode);
                  update();
                },
                autoValidate: AutovalidateMode.onUserInteraction,
                validator: Validatorless.required("Data Wajib Diisi"),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              flex: 2,
              child: BaseForm(
                label: "Keterangan",
                hintText: "Masukkan Keterangan",
                textInputFormater: [
                  UpperCaseTextFormatter(),
                ],
                textEditingController: textController[1],
                onChanged: (value) {
                  dataSupplier.keterangan = trimString(value);
                  update();
                },
                validator: Validatorless.required("Data Wajib Diisi"),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            BaseSecondaryButton(
              isDense: true,
              prefixIcon: iconAddShoppingCart,
              onPressed: () {},
            ),
            const SizedBox(
              width: 16.0,
            ),
            BasePrimaryButton(
              text: "Simpan",
              isDense: true,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: blue50,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              RowCheckbox(
                statusCheckbox: isPpn,
                title: "Harga sudah termasuk pajak",
                onChanged: (value) {
                  isPpn = value ?? false;
                  update();
                },
              ),
              const SizedBox(
                width: 24.0,
              ),
              RowCheckbox(
                statusCheckbox: isDiskon,
                title: "Harga sudah termasuk diskon",
                onChanged: (value) {
                  isDiskon = value ?? false;
                  update();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        FutureBuilder(
          future: dataFuturePembelian,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: gray300,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Terjadi kesalahan saat mengambil data.",
                      textAlign: TextAlign.center,
                      style: myTextTheme.bodyMedium,
                    )
                  ],
                );
              } else if (snapshot.hasData) {
                CreatePembelianModel result = snapshot.data;
                List<dynamic> listData = result.toJson()["details"] ?? [];

                if (listData.isNotEmpty) {
                  List<PlutoRow> rows = [];
                  List<PlutoColumn> columns = [
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari ID Produk",
                      title: 'ID Produk',
                      field: 'id_product',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Divisi",
                      title: 'Divisi',
                      field: 'nm_divisi',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Nama Produk",
                      title: 'Nama Produk',
                      field: 'nm_produk',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Harga Beli",
                      title: 'Harga Beli',
                      field: 'harga_beli',
                      type: PlutoColumnType.number(
                        locale: 'id',
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Harga Jual",
                      title: 'Harga Jual',
                      field: 'harga_jual',
                      type: PlutoColumnType.number(
                        locale: 'id',
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Qty",
                      title: 'Qty',
                      field: 'jumlah',
                      type: PlutoColumnType.number(
                        locale: 'id',
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Disc",
                      title: 'Disc',
                      field: 'diskon',
                      type: PlutoColumnType.number(
                        locale: 'id',
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Total Nilai Beli",
                      title: 'Total Nilai Beli',
                      field: 'total_nilai_beli',
                      type: PlutoColumnType.number(
                        locale: 'id',
                      ),
                    ),
                    PlutoColumn(
                      backgroundColor: primaryColor,
                      filterHintText: "Cari Total Nilai Jual",
                      title: 'Total Nilai Jual',
                      field: 'total_nilai_jual',
                      type: PlutoColumnType.number(
                        locale: 'id',
                      ),
                    ),
                  ];

                  rows = listData.map((item) {
                    Map<String, PlutoCell> cells = {};

                    for (var i = 0; i < (result.details?.length ?? 0); i++) {
                      result.details?[i].toJson().forEach(
                        (key, value) {
                          cells[key] = PlutoCell(
                            value: trimStringStrip(value.toString()),
                          );
                        },
                      );
                    }

                    return PlutoRow(cells: cells);
                  }).toList();

                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        144 -
                        16,
                    child: PlutoGrid(
                      noRowsWidget: Container(
                        width: MediaQuery.of(context).size.width,
                        constraints: BoxConstraints.loose(
                          Size.fromHeight(
                            MediaQuery.of(context).size.height -
                                144 -
                                AppBar().preferredSize.height -
                                73,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: blueGray50,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            const SizedBox(
                              height: 24.0,
                            ),
                          ],
                        ),
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
                    ),
                  );
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints.loose(
                      Size.fromHeight(
                        MediaQuery.of(context).size.height -
                            144 -
                            AppBar().preferredSize.height -
                            73,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        width: 1.0,
                        color: blueGray50,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(
                          height: 24.0,
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints.loose(
                    Size.fromHeight(
                      MediaQuery.of(context).size.height -
                          144 -
                          AppBar().preferredSize.height -
                          73,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: blueGray50,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Terjadi kesalahan saat mengambil data.",
                              style: myTextTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints.loose(
                  Size.fromHeight(
                    MediaQuery.of(context).size.height -
                        144 -
                        AppBar().preferredSize.height -
                        73,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: blueGray50,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
