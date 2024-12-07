// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

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
    widget.controller.dataDetailSup = DataDetailSupplier(
      idSupplier: widget.controller.dataPayloadRetur.idSupplier,
      nmSupplier: widget.controller.dataPayloadRetur.nmSupplier,
    );
    widget.controller.dataPayloadRetur.tgRetur =
        formatDate(DateTime.now().toString());
    widget.controller.textControllerRetur[0].text =
        formatDate(DateTime.now().toString());
  }

  final inputRetursKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ReturController controller = widget.controller;

    controller.sumJumlah();
    controller.sumTotalHargaBeli();

    return SizedBox(
      height: MediaQuery.of(context).size.height - 105,
      child: Form(
        key: inputRetursKey,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.isList = true;
                    controller.dataPayloadRetur = ReturPayloadModel();
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
                        initValue: formatDateTimeNow(
                            controller.dataPayloadRetur.tgRetur ??
                                DateTime.now().toString()),
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
                    value:
                        controller.dataPayloadRetur.idSupplier?.isEmpty ?? true
                            ? null
                            : controller.dataDetailSup,
                    onChanged: (value) {
                      controller.dataDetailSup.idSupplier =
                          trimString(value?.idSupplier);
                      controller.dataDetailSup.nmSupplier =
                          trimString(value?.nmSupplier);
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
                      await showDialogBase(
                        width: 700,
                        content: DialogTambahRetur(
                          data: DetailsReturPayload(),
                          controller: controller,
                        ),
                      );
                      controller.update();
                      update();
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
                      if (inputRetursKey.currentState!.validate()) {
                        showDialogBase(
                          content: DialogKonfirmasi(
                            textKonfirmasi:
                                "Apakah Anda yakin ingin menyimpan data ini?",
                            onConfirm: () {
                              controller.postCreateRetur();
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
              itemCount: controller.dataPayloadRetur.details?.length ?? 0,
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
                  return InkWell(
                    onTap: controller.isDetail
                        ? null
                        : () async {
                            await showDialogBase(
                              width: 700,
                              content: DialogTambahRetur(
                                index: index,
                                data:
                                    controller.dataPayloadRetur.details?[index],
                                controller: controller,
                              ),
                            );
                            controller.update();
                            update();
                          },
                    child: BodyRetur(
                      controller: controller,
                      index: index,
                      color: neutralWhite,
                    ),
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
