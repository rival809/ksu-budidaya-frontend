import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future showDialogSukses(String label) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: SizedBox(
          width: 450,
          height: 180,
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
                      "assets/icons/info_progresif/sukses.svg",
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
                  style: myTextTheme.displaySmall
                      ?.copyWith(color: gray900, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
