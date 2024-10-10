// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogProsesPembayaran extends StatefulWidget {
  final PenjualanController controller;
  const DialogProsesPembayaran({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DialogProsesPembayaran> createState() => _DialogProsesPembayaranState();
}

class _DialogProsesPembayaranState extends State<DialogProsesPembayaran> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Form(
        child: Column(
          children: [
            Text(
              "Proses Pembayaran",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            BaseForm(
              label: "Anggota",
              hintText: "Masukkan Anggota",
              textInputFormater: [
                UpperCaseTextFormatter(),
              ],
              textEditingController: textController[0],
              onChanged: (value) {
                // dataEdit.idProduct = trimString(value);
                // onBarcodeChanged(value);
                // update();
              },
            ),
          ],
        ),
      ),
    );
  }
}
