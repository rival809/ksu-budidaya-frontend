import 'package:flutter/material.dart';
import 'package:ksu_budidaya/state_util.dart';

Future showDialogBase({
  required Widget content,
  bool? barrierDismissible,
  double? width,
}) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: barrierDismissible ?? false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width ?? 450,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: content,
          ),
        ),
      );
    },
  );
}
