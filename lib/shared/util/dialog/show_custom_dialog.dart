import 'package:ksu_budidaya/core.dart';
import 'package:flutter/material.dart';

Future showCustomDialog(
    {required String title, required String message}) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: myTextTheme.headlineLarge?.copyWith(
                      color: green700,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    message,
                    style: myTextTheme.bodyLarge?.copyWith(
                      color: gray900,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: "OK",
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
