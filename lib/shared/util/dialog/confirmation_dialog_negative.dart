import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future showConfirmationDialogNegative({
  required String title,
  required String subtitle,
  required Function() onPressedSecondaryButton,
  required String secondaryButtonText,
  required Function() onPressedPrimaryButton,
  required String primaryButtonText,
  required BuildContext context,
}) async {
  await showDialog<void>(
    context: context,
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
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    subtitle,
                    style: myTextTheme.bodyLarge?.copyWith(
                      color: gray900,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          onPressed: onPressedSecondaryButton,
                          text: secondaryButtonText,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: DangerButton(
                          onPressed: onPressedPrimaryButton,
                          text: primaryButtonText,
                        ),
                      ),
                    ],
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
