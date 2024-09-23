// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogAnggota extends StatefulWidget {
  final DataDetailAnggota? data;
  final bool isDetail;

  const DialogAnggota({
    Key? key,
    required this.data,
    required this.isDetail,
  }) : super(key: key);

  @override
  State<DialogAnggota> createState() => _DialogAnggotaState();
}

class _DialogAnggotaState extends State<DialogAnggota> {
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

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailAnggota();
    textController[0].text = trimString(dataEdit.idAnggota);
    textController[1].text = trimString(dataEdit.nmAnggota);
    textController[2].text = trimString(dataEdit.noWa);
    textController[3].text = trimString(formatMoney(dataEdit.limitPinjaman));
    textController[4].text = trimString(dataEdit.alamat);
    super.initState();
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    textController[3].dispose();
    textController[4].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: anggotaKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Detail Anggota" : "Tambah Anggota",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            StaggeredGrid.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              children: [
                if (widget.isDetail)
                  BaseForm(
                    label: "ID",
                    hintText: "Masukkan ID",
                    textEditingController: textController[0],
                    enabled: false,
                    onChanged: (value) {
                      dataEdit.idAnggota = trimString(value);
                      update();
                    },
                  ),
                BaseForm(
                  label: "Nama",
                  hintText: "Masukkan Nama",
                  textEditingController: textController[1],
                  onChanged: (value) {
                    dataEdit.nmAnggota = trimString(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  label: "No. Whatsapp",
                  hintText: "Masukkan No. Whatsapp",
                  textEditingController: textController[2],
                  validator: Validatorless.required("Data Wajib Diisi"),
                  textInputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    dataEdit.noWa = trimString(value);
                    update();
                  },
                ),
                BaseForm(
                  prefix: const BasePrefixRupiah(),
                  label: "Limit ",
                  hintText: "Masukkan Limit ",
                  textEditingController: textController[3],
                  validator: Validatorless.required("Data Wajib Diisi"),
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: (value) {
                    dataEdit.limitPinjaman = removeComma(trimString(value));
                    update();
                  },
                ),
                BaseForm(
                  label: "Alamat",
                  hintText: "Masukkan Alamat",
                  validator: Validatorless.required("Data Wajib Diisi"),
                  textEditingController: textController[4],
                  onChanged: (value) {
                    dataEdit.alamat = trimString(value);
                    update();
                  },
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
                      if (anggotaKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        payload.removeWhere(
                          (key, value) => key == "created_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "updated_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "hutang",
                        );

                        if (widget.isDetail) {
                          AnggotaController.instance.postUpdateUser(payload);
                        } else {
                          payload.removeWhere(
                            (key, value) => key == "id_anggota",
                          );
                          payload.removeWhere(
                            (key, value) => key == "hutang",
                          );
                          AnggotaController.instance.postCreateAnggota(payload);
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
