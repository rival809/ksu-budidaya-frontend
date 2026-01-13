// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogSo extends StatefulWidget {
  final String namaProduk;
  final String? initialStokFisik;
  final String? initialNotes;
  final Function(String stokFisik, String notes) onSimpan;

  const DialogSo({
    super.key,
    required this.namaProduk,
    this.initialStokFisik,
    this.initialNotes,
    required this.onSimpan,
  });

  @override
  State<DialogSo> createState() => _DialogSoState();
}

class _DialogSoState extends State<DialogSo> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController stokFisikController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialStokFisik != null) {
      stokFisikController.text = widget.initialStokFisik!;
    }
    if (widget.initialNotes != null) {
      catatanController.text = widget.initialNotes!;
    }
  }

  @override
  void dispose() {
    stokFisikController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 480,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: neutralWhite,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stock Opname",
              style: myTextTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            BaseForm(
              label: "Nama Produk",
              hintText: widget.namaProduk,
              enabled: false,
              initialValue: widget.namaProduk,
            ),
            const SizedBox(height: 16),
            BaseForm(
              label: "Stock Fisik",
              autoFocus: true,
              hintText: "Masukkan Stock Fisik",
              textEditingController: stokFisikController,
              textInputType: TextInputType.number,
              textInputFormater: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: Validatorless.multiple([
                Validatorless.required("Stock Fisik harus diisi"),
                Validatorless.number("Stock Fisik harus berupa angka"),
              ]),
            ),
            const SizedBox(height: 16),
            BaseForm(
              label: "Catatan",
              hintText: "Masukkan Catatan (opsional)",
              textEditingController: catatanController,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Batal",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BasePrimaryButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSimpan(
                          stokFisikController.text,
                          catatanController.text,
                        );
                        Navigator.pop(context);
                      }
                    },
                    text: "Simpan",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
