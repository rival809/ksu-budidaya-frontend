import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future showCircleDialogCarLoading() async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: const Color(0x00ffffff),
        shadowColor: const Color(0x00ffffff),
        content: Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            color: neutralWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  "assets/files/json/loading_mobil.json",
                  height: 200,
                  width: 200,
                ),
                Text(
                  "Sedang Memproses ...",
                  style: myTextTheme.bodyLarge?.copyWith(
                    color: gray900,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
