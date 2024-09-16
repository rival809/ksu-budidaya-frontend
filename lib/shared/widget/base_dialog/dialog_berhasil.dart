// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogBerhasil extends StatefulWidget {
  const DialogBerhasil({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogBerhasil> createState() => _DialogBerhasilState();
}

class _DialogBerhasilState extends State<DialogBerhasil> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SvgPicture.asset(
            iconStatusCheck,
            height: 80,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "Berhasil",
            style: myTextTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          BasePrimaryButton(
            text: "Oke, saya mengerti",
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
