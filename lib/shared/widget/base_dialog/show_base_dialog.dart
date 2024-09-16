import 'package:flutter/material.dart';

Future showDialogBase({
  required BuildContext context,
  required Widget content,
  bool? barrierDismissible,
  double? width,
}) async {
  await showDialog<void>(
    context: context,
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
