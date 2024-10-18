// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/retur/widget/table/footer_retur.dart';

class ContainerRetur extends StatefulWidget {
  final ReturController controller;
  const ContainerRetur({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerRetur> createState() => _ContainerReturState();
}

class _ContainerReturState extends State<ContainerRetur> {
  @override
  void initState() {
    super.initState();
  }

  final inputPembelianKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ReturController controller = widget.controller;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 105,
      child: Form(
        key: inputPembelianKey,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.isList = true;
                    // controller.dataPembelian = CreatePembelianModel();
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
                  controller.isDetail ? "Detail Retur" : "Tambah Retur",
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
                        initValue: controller.dataPayloadRetur.tgRetur,
                      );

                      if (selectedDate != null) {
                        controller.dataPayloadRetur.tgRetur =
                            selectedDate.toString();
                        controller.textControllerRetur[0].text =
                            formatDate(selectedDate.toString());
                        update();
                      }
                    },
                    label: "Tgl. Retur",
                    hintText: "Masukkan Tgl. Retur",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: Validatorless.required("Data Wajib Diisi"),
                    autoValidate: AutovalidateMode.onUserInteraction,
                    textEditingController: controller.textControllerRetur[0],
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
                    value: controller.dataPayloadRetur.idSupplier?.isEmpty ??
                            true
                        ? null
                        : DataDetailSupplier(
                            idSupplier: controller.dataPayloadRetur.idSupplier,
                            nmSupplier: trimString(
                              getNamaSupplier(
                                  idSupplier: trimString(
                                      controller.dataPayloadRetur.idSupplier)),
                            ),
                          ),
                    onChanged: (value) {
                      controller.dataPayloadRetur.idSupplier =
                          trimString(value?.idSupplier);
                      controller.dataPayloadRetur.nmSupplier =
                          trimString(value?.nmSupplier);
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
                    textEditingController: controller.textControllerRetur[1],
                    onChanged: (value) {
                      controller.dataPayloadRetur.keterangan =
                          trimString(value);
                      update();
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Container(),
                ),
                if (!controller.isDetail)
                  BaseSecondaryButton(
                    isDense: true,
                    prefixIcon: iconAddShoppingCart,
                    onPressed: () async {
                      // controller.isLoading = true;
                      // controller.update();
                      // await showDialogBase(
                      //   width: 700,
                      //   content: DialogTambahPembelian(
                      //     data: DataDetailPembelian(),
                      //     controller: controller,
                      //   ),
                      // );
                      // await controller.initColumn();
                      // await controller.initRow();
                      // controller.isLoading = false;
                      // controller.update();
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
                    onPressed: () {
                      if (inputPembelianKey.currentState!.validate()) {
                        showDialogBase(
                          content: DialogKonfirmasi(
                            textKonfirmasi:
                                "Apakah Anda yakin ingin menyimpan data ini?",
                            onConfirm: () {
                              // controller.postCreatePembelian();
                            },
                          ),
                        );
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            const HeaderRetur(),
            ListView.builder(
              itemCount: controller.dataPayloadRetur.details?.length ?? 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (controller.dataPayloadRetur.details?.isEmpty ?? true) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: blueGray50,
                      ),
                    ),
                    child: Text(
                      "Tidak Ada Data Retur",
                      textAlign: TextAlign.center,
                      style: myTextTheme.titleMedium,
                    ),
                  );
                } else {
                  return BodyRetur(
                    controller: controller,
                    index: index,
                    color: neutralWhite,
                  );
                }
              },
            ),
            FooterRetur(controller: controller)
          ],
        ),
      ),
    );
  }
}
