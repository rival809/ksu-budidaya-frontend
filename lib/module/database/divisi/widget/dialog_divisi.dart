// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogDivisi extends StatefulWidget {
  const DialogDivisi({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogDivisi> createState() => _DialogDivisiState();
}

class _DialogDivisiState extends State<DialogDivisi> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
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
            "Tambah Divisi",
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
