// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/pembelian/widget/dialog_input_ppn.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class DetailPembelian extends StatefulWidget {
  final DetailPembelianResult result;

  const DetailPembelian({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  State<DetailPembelian> createState() => _DetailPembelianState();
}

class _DetailPembelianState extends State<DetailPembelian> {
  CreatePembelianModel dataPembelian = CreatePembelianModel();

  List<TextEditingController> textControllerDetail = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool isLoading = false;
  bool isPpn = true;
  bool isDiskon = false;
  double totalHargaBeli = 0;
  double totalHargaJual = 0;
  double totalPpn = 0;
  double totalDiskon = 0;
  double jumlah = 0;

  String? ppn = "0";

  double rowHeight = 47;
  double heighFooter = 49;

  double getRowHeigh() {
    if (!isPpn) {
      return heighFooter = 123;
    } else {
      return heighFooter = 86;
    }
  }

  checkPpn() {
    isPpn = true;

    if (dataPembelian.details?.isNotEmpty ?? false) {
      isPpn = dataPembelian.details!.every((element) => trimString(element.ppn ?? "0") == "0");
    }
  }

  createDialogPpn(bool value) async {
    if (isPpn) {
      ppn = await showDialog<String?>(
        context: globalContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 450,
              ),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: const DialogInputPpn(),
              ),
            ),
          );
        },
      );

      if (ppn != null) {
        if (int.tryParse(ppn ?? "0") == null) {
          showInfoDialog("Inputan Harus Berupa Angka", context);
        } else if ((int.tryParse(ppn ?? "0") ?? 0) > 100) {
          showInfoDialog("Inputan Harus Kurang Dari 100", context);
        } else {
          checklistPpn(value, int.tryParse(ppn ?? "0") ?? 0);
        }
      }
    } else {
      checklistPpn(value, 0);
    }
  }

  initRow() {
    rows.clear();

    var dataList = dataPembelian.toJson()["details"] as List<dynamic>;

    rows = dataList.map<PlutoRow>((item) {
      Map<String, PlutoCell> cells = {};

      (item as Map<String, dynamic>).forEach((key, value) {
        cells[key] = PlutoCell(
          value: trimStringStrip(value.toString()),
        );
      });

      return PlutoRow(cells: cells);
    }).toList();
  }

  checklistPpn(bool value, int ppn) {
    isPpn = value;

    for (var detail in dataPembelian.details ?? [DetailPurchase()]) {
      if (!value) {
        detail.ppn = roundDouble((ppn / 100) *
                double.parse(detail.hargaBeli ?? "0") *
                double.parse(detail.jumlah?.toString() ?? "0"))
            .toString();
      } else {
        detail.ppn = "0";
      }
    }
    update();
  }

  sumTotalDiskon() {
    totalDiskon = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalDiskon += double.parse(dataPembelian.details?[i].diskon ?? "0");
    }
  }

  sumTotalPpn() {
    totalPpn = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalPpn += double.parse(dataPembelian.details?[i].ppn ?? "0");
    }
  }

  sumTotalNilaiBeli() {
    totalHargaBeli = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalHargaBeli += double.parse(dataPembelian.details?[i].totalNilaiBeli ?? "0");
    }
    totalHargaBeli = totalHargaBeli + totalPpn;
    dataPembelian.totalHargaBeli = totalHargaBeli.toString();
  }

  sumTotalNilaiJual() {
    totalHargaJual = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalHargaJual += double.parse(dataPembelian.details?[i].totalNilaiJual ?? "0");
    }
    dataPembelian.totalHargaJual = totalHargaJual.toString();
  }

  sumJumlah() {
    jumlah = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      jumlah += dataPembelian.details?[i].jumlah ?? 0;
    }
    dataPembelian.jumlah = jumlah.toString();
  }

  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  initColumn() {
    columns.clear();
    columns.addAll([
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari ID Produk",
        title: 'ID Produk',
        field: 'id_product',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (!isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Divisi",
        title: 'Divisi',
        field: 'nm_divisi',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerFooterText(text: "Diskon"),
                if (!isPpn) const ContainerFooterText(text: "PPN"),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: Text(
                    "TOTAL",
                    style: myTextTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Nama Produk",
        title: 'Nama Produk',
        field: 'nm_produk',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (!isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Harga Beli",
        title: 'Harga Beli',
        field: 'harga_beli',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (!isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Harga Jual",
        title: 'Harga Jual',
        field: 'harga_jual',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (!isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Qty",
        title: 'Qty',
        field: 'jumlah',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (!isPpn) ContainerFooterText(text: "$ppn %"),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: PlutoAggregateColumnFooter(
                    rendererContext: context,
                    type: PlutoAggregateColumnType.sum,
                    titleSpanBuilder: (text) {
                      return [
                        TextSpan(
                          text: text,
                          style: myTextTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Disc",
        title: 'Disc',
        field: 'diskon',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          context.stateManager.columnFooterHeight = getRowHeigh();

          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                ContainerFooterText(
                  text: formatMoney(totalDiskon.toString()),
                ),
                if (!isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Total Nilai Beli",
        title: 'Total Nilai Beli',
        field: 'total_nilai_beli',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        renderer: (rendererContext) {
          var data = rendererContext.row.toJson();

          double total = 0;

          if (isDetail) {
            total = double.parse((data["total_nilai_beli"] ?? 0).toString());
          } else {
            total = ((double.parse((data["total_nilai_beli"] ?? 0).toString())) +
                (double.parse((data["diskon"] ?? 0).toString())));
          }

          return Text(formatMoney(total.toString()));
        },
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                ContainerFooterText(
                  text: "-${formatMoney(totalDiskon.toString())}",
                ),
                if (!isPpn)
                  ContainerFooterText(
                    text: formatMoney(totalPpn.toString()),
                  ),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isDetail
                          ? formatMoney(
                              (double.parse(dataPembelian.totalHargaBeli ?? "0") - totalDiskon)
                                  .toString())
                          : formatMoney(totalHargaBeli.toString()),
                      style: myTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Total Nilai Jual",
        title: 'Total Nilai Jual',
        field: 'total_nilai_jual',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (!isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isDetail
                          ? formatMoney(dataPembelian.totalHargaJual.toString())
                          : formatMoney(totalHargaJual.toString()),
                      style: myTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ]);
  }

  bool isDetail = true;
  bool isList = false;

  @override
  void initState() {
    super.initState();

    dataPembelian = dataPembelian.copyWith(
      details: widget.result.data?.detailPurchase,
      idSupplier: widget.result.data?.existingPurchase?.idSupplier,
      nmSupplier: widget.result.data?.existingPurchase?.nmSupplier,
      jenisPembayaran: widget.result.data?.existingPurchase?.jenisPembayaran,
      tgPembelian: widget.result.data?.existingPurchase?.tgPembelian,
      keterangan: widget.result.data?.existingPurchase?.keterangan,
      jumlah: widget.result.data?.existingPurchase?.jumlah?.toString(),
      totalHargaBeli: widget.result.data?.existingPurchase?.totalHargaBeli,
      totalHargaJual: widget.result.data?.existingPurchase?.totalHargaJual,
    );
    if (widget.result.data?.detailPurchase?.isNotEmpty ?? false) {
      isPpn = widget.result.data!.detailPurchase!.any((element) => element.ppn != "0");
    }
    textControllerDetail[0].text = trimString(dataPembelian.tgPembelian);
    textControllerDetail[1].text = dataPembelian.keterangan ?? "";
    ppn = "-";
    initColumn();
    initRow();
    sumTotalDiskon();
    sumTotalDiskon();
    sumTotalPpn();
    sumTotalNilaiBeli();
    sumTotalNilaiJual();
    sumJumlah();
    checkPpn();
  }

  final inputPembelianKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    sumTotalDiskon();
    sumTotalDiskon();
    sumTotalPpn();
    sumTotalNilaiBeli();
    sumTotalNilaiJual();
    sumJumlah();
    checkPpn();
    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 105,
                child: Form(
                  key: inputPembelianKey,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
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
                              "Detail Pembelian",
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
                                    initValue: formatDateTimeNow(textControllerDetail[0].text),
                                  );

                                  if (selectedDate != null) {
                                    dataPembelian.tgPembelian = formatDate(selectedDate.toString());
                                    textControllerDetail[0].text =
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
                                textEditingController: textControllerDetail[0],
                                enabled: isDetail ? false : true,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              flex: 2,
                              child: BaseDropdownButton<DataDetailSupplier>(
                                hint: "Pilih Supplier",
                                label: "Supplier",
                                enabled: isDetail ? false : true,
                                itemAsString: (item) => item.supplierAsString(),
                                items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                                value: dataPembelian.idSupplier?.isEmpty ?? true
                                    ? null
                                    : DataDetailSupplier(
                                        idSupplier: dataPembelian.idSupplier,
                                        nmSupplier: trimString(
                                          getNamaSupplier(
                                              idSupplier: trimString(dataPembelian.idSupplier)),
                                        ),
                                      ),
                                onChanged: (value) {
                                  dataPembelian.idSupplier = trimString(value?.idSupplier);
                                  dataPembelian.nmSupplier = trimString(value?.nmSupplier);
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
                                enabled: isDetail ? false : true,
                                isSearch: false,
                                itemAsString: (item) => item.metodeBayarAsString(),
                                items: metodeBayarList,
                                value: dataPembelian.jenisPembayaran?.isEmpty ?? true
                                    ? null
                                    : MetodeBayar(
                                        metode: trimString(dataPembelian.jenisPembayaran),
                                      ),
                                onChanged: (value) {
                                  dataPembelian.jenisPembayaran = trimString(value?.metode);
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
                                enabled: isDetail ? false : true,
                                label: "Keterangan",
                                hintText: "Masukkan Keterangan",
                                textInputFormater: [
                                  UpperCaseTextFormatter(),
                                ],
                                textEditingController: textControllerDetail[1],
                                onChanged: (value) {
                                  dataPembelian.keterangan = trimString(value);
                                  update();
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(),
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
                                onChanged: isDetail
                                    ? null
                                    : (value) {
                                        isLoading = true;
                                        update();
                                        createDialogPpn(value ?? false);
                                        isLoading = false;
                                        update();
                                      },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                height: dataPembelian.details?.isEmpty ?? true
                                    ? 330
                                    : (rows.length * rowHeight) + rowHeight * 2 + getRowHeigh(),
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
                                  onSorted: (event) {},
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
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
