// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogKonfirmasi extends StatefulWidget {
  final String textKonfirmasi;
  final Function()? onConfirm;

  const DialogKonfirmasi({
    Key? key,
    required this.textKonfirmasi,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<DialogKonfirmasi> createState() => _DialogKonfirmasiState();
}

class _DialogKonfirmasiState extends State<DialogKonfirmasi> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            widget.textKonfirmasi,
            style: myTextTheme.bodyMedium,
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
                child: BaseDangerButton(
                  text: "Konfirmasi",
                  onPressed: widget.onConfirm,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
