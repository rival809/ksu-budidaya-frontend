import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future showDialogLoadingStatis(String label) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          "Sedang memproses ...",
          style: myTextTheme.displaySmall?.copyWith(
            color: green800,
          ),
        ),
        content: SizedBox(
          width: 450,
          height: 167,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: gray50,
                    child: SvgPicture.asset(
                      "assets/icons/part_pop_up/objek.svg",
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  label,
                  style: myTextTheme.bodyMedium?.copyWith(
                    color: gray800,
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
