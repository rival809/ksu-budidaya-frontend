// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

showCustomSnackBar(BuildContext context, String message,
    {VoidCallback? onPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: red400,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            100,
        left: 24,
        right: 24,
      ),
      content: Container(
        decoration: const BoxDecoration(
          color: red400,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Text(
          message,
          style: myTextTheme.bodyMedium?.copyWith(color: neutralWhite),
        ),
      ),
      action: onPressed != null
          ? SnackBarAction(
              label: "OK",
              textColor: neutralWhite,
              onPressed: onPressed,
            )
          : null,
    ),
  );
}
