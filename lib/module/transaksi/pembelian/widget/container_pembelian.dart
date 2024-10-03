// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ContainerPembelian extends StatefulWidget {
  final PembelianController controller;
  const ContainerPembelian({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerPembelian> createState() => _ContainerPembelianState();
}

class _ContainerPembelianState extends State<ContainerPembelian> {
  @override
  void initState() {
    super.initState();
    widget.controller.initColumn();
    widget.controller.initRow();
  }

  @override
  Widget build(BuildContext context) {
    PembelianController controller = widget.controller;

    controller.sumTotalDiskon();
    controller.sumTotalPpn();
    controller.sumTotalNilaiBeli();
    controller.sumTotalNilaiJual();
    controller.checkPpn();

    return SizedBox(
      height: MediaQuery.of(context).size.height - 105,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.isList = true;
                  controller.dataPembelian = CreatePembelianModel();
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
                      initValue: controller.dataPembelian.tgPembelian,
                    );

                    if (selectedDate != null) {
                      controller.dataPembelian.tgPembelian =
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
                  enabled: controller.isDetail ? false : true,
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
                  enabled: controller.isDetail ? false : true,
                  itemAsString: (item) => item.supplierAsString(),
                  items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                  value: controller.dataPembelian.idSupplier?.isEmpty ?? true
                      ? null
                      : DataDetailSupplier(
                          idSupplier: controller.dataPembelian.idSupplier,
                          nmSupplier: trimString(
                            getNamaSupplier(
                                idSupplier: trimString(
                                    controller.dataPembelian.idSupplier)),
                          ),
                        ),
                  onChanged: (value) {
                    controller.dataPembelian.idSupplier =
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
                  enabled: controller.isDetail ? false : true,
                  isSearch: false,
                  itemAsString: (item) => item.metodeBayarAsString(),
                  items: metodeBayarList,
                  value:
                      controller.dataPembelian.jenisPembayaran?.isEmpty ?? true
                          ? null
                          : MetodeBayar(
                              metode: trimString(
                                  controller.dataPembelian.jenisPembayaran),
                            ),
                  onChanged: (value) {
                    controller.dataPembelian.jenisPembayaran =
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
                  enabled: controller.isDetail ? false : true,
                  label: "Keterangan",
                  hintText: "Masukkan Keterangan",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: controller.textControllerDetail[1],
                  onChanged: (value) {
                    controller.dataPembelian.keterangan = trimString(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              if (!controller.isDetail)
                BaseSecondaryButton(
                  isDense: true,
                  prefixIcon: iconAddShoppingCart,
                  onPressed: () async {
                    controller.isLoading = true;
                    controller.update();
                    await showDialogBase(
                      width: 700,
                      content: DialogTambahPembelian(
                        data: DataDetailPembelian(),
                        controller: controller,
                      ),
                    );
                    await controller.initColumn();
                    await controller.initRow();
                    controller.isLoading = false;
                    controller.update();
                  },
                ),
              if (!controller.isDetail)
                const SizedBox(
                  width: 16.0,
                ),
              if (!controller.isDetail)
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
                  onChanged: controller.isDetail
                      ? null
                      : (value) {
                          controller.isLoading = true;
                          update();
                          controller.checklistPpn(value ?? false);
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
              : SizedBox(
                  height: controller.dataPembelian.details?.isEmpty ?? true
                      ? 330
                      : (controller.rows.length * controller.rowHeight) +
                          controller.rowHeight * 2 +
                          controller.getRowHeigh(),
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
                    onSelected: (event) async {
                      var dataRow = event.row?.toJson();

                      DataDetailPembelian? data =
                          controller.dataPembelian.details?.firstWhere(
                        (element) =>
                            trimString(element.idDetailPembelian.toString()) ==
                            trimString(
                                dataRow?["id_detail_pembelian"].toString()),
                      );

                      controller.isLoading = true;
                      controller.update();
                      await showDialogBase(
                        width: 700,
                        content: DialogTambahPembelian(
                          isDetail: true,
                          data: data,
                          controller: controller,
                        ),
                      );
                      await controller.initColumn();
                      await controller.initRow();
                      controller.isLoading = false;
                      controller.update();
                    },
                    // onChanged: (event) {
                    //   var dataRow = event.row.toJson();

                    //   dataRow.update("id_detail_pembelian", (value) => null);
                    //   dataRow.update("harga_beli", (value) => value.toString());
                    //   dataRow.update("harga_jual", (value) => value.toString());
                    //   dataRow.update("diskon", (value) => value.toString());
                    //   dataRow.update(
                    //       "total_nilai_beli", (value) => value.toString());
                    //   dataRow.update(
                    //       "total_nilai_jual", (value) => value.toString());

                    //   controller.dataPembelian.details?[event.rowIdx] =
                    //       DataDetailPembelian.fromJson(dataRow);
                    // },
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
                    columns: controller.columns,
                    rows: controller.rows,
                  ),
                ),
        ],
      ),
    );
  }
}
