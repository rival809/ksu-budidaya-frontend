// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogCekUlang extends StatefulWidget {
  final Function(String)? onConfirm;

  const DialogCekUlang({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<DialogCekUlang> createState() => _DialogCekUlangState();
}

class _DialogCekUlangState extends State<DialogCekUlang> {
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
            BaseForm(
              label: "Catatan Review",
              hintText: "Masukkan Catatan Review stock opname",
              maxLines: 4,
              autoValidate: AutovalidateMode.onUserInteraction,
              textEditingController: _alasanController,
              validator: Validatorless.multiple([
                Validatorless.required("Alasan pembatalan harus diisi"),
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
                    text: "Konfirmasi",
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
