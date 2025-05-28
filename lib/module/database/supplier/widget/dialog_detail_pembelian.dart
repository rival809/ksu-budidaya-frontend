// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class DialogDetailPembelian extends StatefulWidget {
  final DetailPembelianResult dataPembelian;
  final String tgTransaksi;
  final String nmSuplier;
  final String idSuplier;
  const DialogDetailPembelian({
    Key? key,
    required this.dataPembelian,
    required this.tgTransaksi,
    required this.nmSuplier,
    required this.idSuplier,
  }) : super(key: key);

  @override
  State<DialogDetailPembelian> createState() => _DialogDetailPembelianState();
}

class _DialogDetailPembelianState extends State<DialogDetailPembelian> {
  List<TextEditingController> textControllerDetail = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool isPpn = true;
  double totalHargaBeli = 0;
  double totalHargaJual = 0;
  double totalPpn = 0;
  double totalDiskon = 0;
  double jumlah = 0;

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
  CreatePembelianModel dataPembelian = CreatePembelianModel();

  postDetailPurchase(String idPembelian) async {
    try {
      DetailPembelianResult result = await ApiService.detailPembelian(
        data: {"id_pembelian": idPembelian},
      ).timeout(const Duration(seconds: 30));

      if (result.success == true) {
        dataPembelian = dataPembelian.copyWith(
          details: result.data?.detailPurchase,
        );

        if (result.data?.detailPurchase?.isNotEmpty ?? false) {
          isPpn = result.data!.detailPurchase!.any((element) => element.ppn != "0");
        }

        update();
      }
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    dataPembelian = dataPembelian.copyWith(
      details: widget.dataPembelian.data!.detailPurchase,
    );

    if (widget.dataPembelian.data?.detailPurchase?.isNotEmpty ?? false) {
      isPpn = widget.dataPembelian.data!.detailPurchase!.any((element) => element.ppn != "0");
    }

    textControllerDetail[0].text = widget.tgTransaksi;
    initRow();
    initColumn();
    sumTotalDiskon();
    sumTotalPpn();
    sumTotalNilaiBeli();
    sumTotalNilaiJual();
    sumJumlah();
    checkPpn();
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
                if (!isPpn) const ContainerFooterText(text: "11 %"),
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

          total = double.parse((data["total_nilai_beli"] ?? 0).toString());

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
                      formatMoney((double.parse(dataPembelian.totalHargaBeli ?? "0") - totalDiskon)
                          .toString()),
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
                      formatMoney(dataPembelian.totalHargaJual.toString()),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: neutralWhite,
      ),
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
                  onTap: () async {},
                  label: "Tanggal Transaksi",
                  hintText: "Masukkan Tanggal Transaksi",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                  autoValidate: AutovalidateMode.onUserInteraction,
                  textEditingController: textControllerDetail[0],
                  enabled: false,
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
                  enabled: false,
                  itemAsString: (item) => item.supplierAsString(),
                  items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                  value: DataDetailSupplier(
                    idSupplier: trimString(widget.idSuplier),
                    nmSupplier: trimString(widget.nmSuplier),
                  ),
                  onChanged: (value) {},
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
                  enabled: false,
                  isSearch: false,
                  itemAsString: (item) => item.metodeBayarAsString(),
                  items: metodeBayarList,
                  value: MetodeBayar(
                    metode: trimString(dataPembelian.jenisPembayaran),
                  ),
                  onChanged: (value) {},
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
                  enabled: false,
                  label: "Keterangan",
                  hintText: "Masukkan Keterangan",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textControllerDetail[1],
                  onChanged: (value) {},
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
                  onChanged: null,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            height: dataPembelian.details?.isEmpty ?? true
                ? 330
                : (rows.length * rowHeight) + rowHeight * 2 + getRowHeigh(),
            child: PlutoGrid(
              noRowsWidget: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints.loose(
                  Size.fromHeight(
                    MediaQuery.of(context).size.height - 144 - AppBar().preferredSize.height - 73,
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
              configuration: PlutoGridConfiguration(
                columnSize: const PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale,
                ),
                style: PlutoGridStyleConfig(
                  columnTextStyle:
                      myTextTheme.titleSmall?.copyWith(color: neutralWhite) ?? const TextStyle(),
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
    );
  }
}
