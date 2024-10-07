import 'package:ksu_budidaya/core.dart';
import 'package:flutter/material.dart';

Future showInfoDialog(String message, BuildContext context) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
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
            child: SelectionArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Text(
                      'Info',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: green700,
                              ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: gray50,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            8,
                          ),
                          bottomRight: Radius.circular(
                            8,
                          ),
                        )),
                    child: BasePrimaryButton(
                      onPressed: () {
                        if (message == "TokenExpiredError: jwt expired") {
                          doLogout();
                          return;
                        }
                        Navigator.pop(context);
                      },
                      text: "OK",
                    ),
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
