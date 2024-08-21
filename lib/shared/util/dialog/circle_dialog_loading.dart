import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future showCircleDialogLoading(BuildContext context) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0x00ffffff),
        shadowColor: const Color(0x00ffffff),
        content: SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundColor: neutralWhite,
            child: LottieBuilder.asset(
              "assets/files/json/loading.json",
            ),
          ),
        ),
      );
    },
  );
}
