// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogSupplier extends StatefulWidget {
  const DialogSupplier({
    Key? key,
    required this.isDetail,
    required this.data,
  }) : super(key: key);

  final DataDetailSupplier? data;
  final bool isDetail;

  @override
  State<DialogSupplier> createState() => _DialogSupplierState();
}

class _DialogSupplierState extends State<DialogSupplier> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataDetailSupplier dataEdit = DataDetailSupplier();

  final supplierKey = GlobalKey<FormState>();

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailSupplier();
    textController[0].text = trimString(dataEdit.idSupplier);
    textController[1].text = trimString(dataEdit.nmSupplier);
    textController[2].text = trimString(dataEdit.nmPemilik);
    textController[3].text = trimString(dataEdit.nmPic);
    textController[4].text = trimString(dataEdit.noWa);
    textController[5].text = trimString(dataEdit.alamat);
    textController[6].text = formatMoney(trimString(dataEdit.hutangDagang));
    super.initState();
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    textController[3].dispose();
    textController[4].dispose();
    textController[5].dispose();
    textController[6].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: supplierKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Detail Supplier" : "Tambah Supplier",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "ID",
                    hintText: "Masukkan ID",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    textEditingController: textController[0],
                    onChanged: (value) {
                      dataEdit.idSupplier = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    label: "Nama Supplier",
                    hintText: "Masukkan Nama Supplier",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    textEditingController: textController[1],
                    onChanged: (value) {
                      dataEdit.nmSupplier = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "Pemilik",
                    hintText: "Masukkan Pemilik",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    textEditingController: textController[2],
                    onChanged: (value) {
                      dataEdit.nmPemilik = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "Nama PIC",
                    hintText: "Masukkan Pemilik",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    textEditingController: textController[3],
                    onChanged: (value) {
                      dataEdit.nmPic = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    label: "No. Whatsapp",
                    hintText: "Masukkan No. Whatsapp",
                    textEditingController: textController[4],
                    textInputFormater: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      dataEdit.noWa = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              label: "Alamat",
              hintText: "Masukkan Alamat",
              textEditingController: textController[5],
              onChanged: (value) {
                dataEdit.alamat = trimString(value);
                update();
              },
              validator: Validatorless.required("Data Wajib Diisi"),
            ),
            if (widget.isDetail)
              const SizedBox(
                height: 16.0,
              ),
            if (widget.isDetail)
              Row(
                children: [
                  Expanded(
                    child: BaseForm(
                      label: "Hutang Dagang",
                      hintText: "Masukkan Hutang Dagang",
                      prefix: const BasePrefixRupiah(),
                      textEditingController: textController[6],
                      onChanged: (value) {
                        dataEdit.hutangDagang = removeComma(trimString(value));
                        update();
                      },
                      textInputFormater: [
                        ThousandsFormatter(),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      validator: Validatorless.required("Data Wajib Diisi"),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            const SizedBox(
              height: 16.0,
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
                    onPressed: () {
                      if (supplierKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        payload.removeWhere(
                          (key, value) => key == "created_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "updated_at",
                        );
                        if (widget.isDetail) {
                          SupplierController.instance
                              .postUpdateSupplier(payload);
                        } else {
                          payload.removeWhere(
                            (key, value) => key == "hutang_dagang",
                          );
                          SupplierController.instance
                              .postCreateSupplier(payload);
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
  }
}
