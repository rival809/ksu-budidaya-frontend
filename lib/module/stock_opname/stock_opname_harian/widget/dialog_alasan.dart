// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogAlasan extends StatefulWidget {
  final Function(String)? onConfirm;

  const DialogAlasan({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<DialogAlasan> createState() => _DialogAlasanState();
}

class _DialogAlasanState extends State<DialogAlasan> {
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
              label: "Alasan Pembatalan",
              hintText: "Masukkan alasan pembatalan stock opname",
              maxLines: 4,
              autoValidate: AutovalidateMode.onUserInteraction,
              textEditingController: _alasanController,
              validator: Validatorless.multiple([
                Validatorless.min(10, "Alasan pembatalan minimal 10 karakter"),
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
