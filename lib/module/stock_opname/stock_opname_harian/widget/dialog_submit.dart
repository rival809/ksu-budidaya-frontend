// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogSubmit extends StatefulWidget {
  final Function(String)? onConfirm;

  const DialogSubmit({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<DialogSubmit> createState() => _DialogSubmitState();
}

class _DialogSubmitState extends State<DialogSubmit> {
  final TextEditingController _alasanController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Konfirmasi",
              style: myTextTheme.titleMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Apakah anda yakin ingin menyimpan data Stock Opname Harian ini?",
              style: myTextTheme.bodyLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            BaseForm(
              label: "Catatan",
              hintText: "Masukkan catatan stock opname",
              maxLines: 4,
              autoValidate: AutovalidateMode.onUserInteraction,
              textEditingController: _alasanController,
              validator: Validatorless.multiple([
                Validatorless.required("Catatan harus diisi"),
              ]),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    text: "Periksa Kembali",
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
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context); // Close the dialog
                        if (widget.onConfirm != null) {
                          widget.onConfirm!(_alasanController.text);
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
