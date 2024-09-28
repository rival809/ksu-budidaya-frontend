// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ContainerDetailPembelian extends StatefulWidget {
  final PembelianController controller;

  const ContainerDetailPembelian({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerDetailPembelian> createState() =>
      _ContainerDetailPembelianState();
}

class _ContainerDetailPembelianState extends State<ContainerDetailPembelian> {
  bool isDiskon = false;
  @override
  void initState() {
    super.initState();
    widget.controller.dataFuturePembelian = widget.controller.initDetail();
    widget.controller.textControllerDetail[0].text = formatDate(
      formatDateToYearMonthDay(
        trimString(widget.controller.dataSupplier.tgPembelian),
      ),
    );
    widget.controller.textControllerDetail[1].text =
        trimString(widget.controller.dataSupplier.keterangan);
    isDiskon = widget.controller
        .detailHasDiskon(widget.controller.dataPembelian.toJson()["details"]);
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
                    initValue: controller.dataSupplier.tgPembelian,
                  );

                  if (selectedDate != null) {
                    controller.dataSupplier.tgPembelian =
                        selectedDate.toString();
                    controller.textControllerDetail[0].text =
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
                textEditingController: controller.textControllerDetail[0],
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
                value: controller.dataSupplier.idSupplier?.isEmpty ?? true
                    ? null
                    : DataDetailSupplier(
                        idSupplier: controller.dataSupplier.idSupplier,
                        nmSupplier: trimString(
                          getNamaSupplier(
                              idSupplier: trimString(
                                  controller.dataSupplier.idSupplier)),
                        ),
                      ),
                onChanged: (value) {
                  controller.dataSupplier.idSupplier =
                      trimString(value?.idSupplier);
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
                value: controller.dataSupplier.jenisPembayaran?.isEmpty ?? true
                    ? null
                    : MetodeBayar(
                        metode:
                            trimString(controller.dataSupplier.jenisPembayaran),
                      ),
                onChanged: (value) {
                  controller.dataSupplier.jenisPembayaran =
                      trimString(value?.metode);
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
                textEditingController: controller.textControllerDetail[1],
                onChanged: (value) {
                  controller.dataSupplier.keterangan = trimString(value);
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
              onPressed: () {
                showDialogBase(
                  width: 700,
                  content: DialogTambahPembelian(
                    data: DataDetailPembelian(),
                  ),
                );
              },
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
                statusCheckbox: controller.isPpn,
                title: "Harga sudah termasuk pajak",
                onChanged: (value) {
                  controller.isLoading = true;
                  update();
                  controller.isPpn = value ?? false;
                  controller.isLoading = false;
                  update();
                },
              ),
              const SizedBox(
                width: 24.0,
              ),
              RowCheckbox(
                statusCheckbox: controller.isDiskon,
                title: "Harga sudah termasuk diskon",
                onChanged: (value) {
                  controller.isLoading = true;
                  update();
                  print(value);

                  controller.dataFuturePembelian =
                      controller.onChangeDiskon(value ?? false);

                  controller.isDiskon = value ?? false;

                  controller.isLoading = false;
                  update();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: controller.dataFuturePembelian,
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
                      bool isPpn = controller.detailHasPpn(listData);
                      String? totalNilaiBeli;
                      double sumTotalNilaiBeli = 0;
                      String? totalNilaiJual;
                      double sumTotalNilaiJual = 0;

                      for (var pembelian in listData) {
                        double nilaiBeli = double.parse(
                            pembelian['total_nilai_beli'].toString());
                        sumTotalNilaiBeli += nilaiBeli;

                        pembelian["ppn"] = nilaiBeli * (11 / 100);

                        double nilaiJual = double.parse(
                            pembelian['total_nilai_jual'].toString());
                        sumTotalNilaiJual += nilaiJual;

                        totalNilaiJual = sumTotalNilaiJual.toString();

                        if (isDiskon) {
                          totalNilaiBeli = sumTotalNilaiBeli.toString();
                        } else {
                          double diskon = double.parse(
                              (pembelian['diskon'] ?? 0).toString());
                          totalNilaiBeli = (sumTotalNilaiBeli -
                                  (sumTotalNilaiBeli * (diskon / 100)))
                              .toString();
                        }
                      }

                      if (listData.isNotEmpty) {
                        List<PlutoRow> rows = [];
                        List<PlutoColumn> columns = [
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "DISKON",
                                          style: myTextTheme.titleSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "PPN",
                                          style:
                                              myTextTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: gray100,
                                      ),
                                      child: Text(
                                        "TOTAL",
                                        style:
                                            myTextTheme.displayLarge?.copyWith(
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "11%",
                                          style:
                                              myTextTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
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
                                              style: myTextTheme.displayLarge
                                                  ?.copyWith(
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
                              if (!controller.isDiskon &&
                                  !controller.isPpn &&
                                  !isDiskon &&
                                  !isPpn) {
                                context.stateManager.columnFooterHeight = 49;
                              } else if (controller.isDiskon &&
                                  controller.isPpn &&
                                  !isDiskon &&
                                  !isPpn) {
                                context.stateManager.columnFooterHeight = 49;
                              } else if (!controller.isDiskon &&
                                  !controller.isPpn &&
                                  isDiskon &&
                                  isPpn) {
                                context.stateManager.columnFooterHeight = 123;
                              } else {
                                context.stateManager.columnFooterHeight = 86;
                              }
                              return SingleChildScrollView(
                                controller: ScrollController(),
                                child: Column(
                                  children: [
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "10%",
                                          style:
                                              myTextTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 9.5,
                                        ),
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
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
                            footerRenderer: (context) {
                              return SingleChildScrollView(
                                controller: ScrollController(),
                                child: Column(
                                  children: [
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "- 1.000",
                                            style: myTextTheme.titleSmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "1.000",
                                            style: myTextTheme.titleSmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
                                      decoration: const BoxDecoration(
                                        color: gray100,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          formatMoney(
                                              trimString(totalNilaiBeli)),
                                          style: myTextTheme.displayLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
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
                                    if (!controller.isDiskon && isDiskon)
                                      Container(
                                        height: 37,
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!controller.isPpn && isPpn)
                                      Container(
                                        height: 37,
                                        width: MediaQuery.of(globalContext)
                                            .size
                                            .width,
                                        decoration: const BoxDecoration(
                                          color: gray100,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: blueGray50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 49,
                                      width: MediaQuery.of(globalContext)
                                          .size
                                          .width,
                                      decoration: const BoxDecoration(
                                        color: gray100,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          formatCurrency(
                                              trimString(totalNilaiJual)),
                                          style: myTextTheme.displayLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ];

                        rows = listData.map((item) {
                          Map<String, PlutoCell> cells = {};
                          item.forEach(
                            (key, value) {
                              cells[key] = PlutoCell(
                                value: trimStringStrip(value.toString()),
                              );
                            },
                          );
                          return PlutoRow(cells: cells);
                        }).toList();
                        double rowHeight = 47;
                        double heighFooter = 49;
                        if (!controller.isDiskon &&
                            !controller.isPpn &&
                            !isDiskon &&
                            !isPpn) {
                          heighFooter = 49;
                        } else if (controller.isDiskon &&
                            controller.isPpn &&
                            !isDiskon &&
                            !isPpn) {
                          heighFooter = 49;
                        } else if (!controller.isDiskon &&
                            !controller.isPpn &&
                            isDiskon &&
                            isPpn) {
                          heighFooter = 123;
                        } else {
                          heighFooter = 86;
                        }
                        return SizedBox(
                          height: (rows.length * rowHeight) +
                              rowHeight * 2 +
                              heighFooter,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                controller.dataFuture =
                                    controller.cariDataPembelian(
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
