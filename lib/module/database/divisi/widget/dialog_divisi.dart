// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';

class DialogDivisi extends StatefulWidget {
  final DataDetailDivisi? data;
  final bool isDetail;

  const DialogDivisi({
    Key? key,
    required this.data,
    required this.isDetail,
  }) : super(key: key);

  @override
  State<DialogDivisi> createState() => _DialogDivisiState();
}

class _DialogDivisiState extends State<DialogDivisi> {
  TextEditingController textController = TextEditingController();

  DataDetailDivisi dataEdit = DataDetailDivisi();

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailDivisi();
    textController.text = trimString(widget.data?.nmDivisi);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final divisiKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: divisiKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Detail Divisi" : "Tambah Divisi",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            BaseForm(
              label: "Nama Divisi",
              hintText: "Masukkan Nama Divisi",
              textEditingController: textController,
              autoValidate: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                dataEdit.nmDivisi = trimString(value);
                update();
              },
              validator: Validatorless.required("Data Wajib Diisi"),
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
                    onPressed: trimString(textController.text)
                            .toString()
                            .isEmpty
                        ? null
                        : () {
                            if (divisiKey.currentState!.validate()) {
                              widget.isDetail
                                  ? DivisiController.instance.postUpdateDivisi(
                                      trimString(widget.data?.idDivisi),
                                      trimString(textController.text),
                                    )
                                  : DivisiController.instance.postCreateDivisi(
                                      trimString(textController.text),
                                    );
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
