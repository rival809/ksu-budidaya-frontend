// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogSupplier extends StatefulWidget {
  const DialogSupplier({
    Key? key,
  }) : super(key: key);

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
  ];

  bool obsecure = true;

  @override
  void initState() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tambah Supplier",
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
                  textEditingController: textController[0],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: BaseForm(
                  label: "Nama Supplier",
                  hintText: "Masukkan Nama Supplier",
                  textEditingController: textController[1],
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
                  textEditingController: textController[2],
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
                  textEditingController: textController[3],
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
                    showDialogBase(
                      context: context,
                      content: const DialogBerhasil(),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
