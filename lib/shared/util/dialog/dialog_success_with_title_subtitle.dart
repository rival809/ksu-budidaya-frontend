import 'package:ksu_budidaya/core.dart';
import 'package:flutter/material.dart';

Future showDialogSuksenWithTitleSubtitle({
  required String title,
  required String subtitle,
  required Function() onPress,
}) async {
  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
            maxHeight: 450,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      SvgPicture.asset(
                        "assets/icons/info_progresif/sukses.svg",
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: myTextTheme.displaySmall?.copyWith(
                            color: gray900,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: myTextTheme.bodyLarge
                            ?.copyWith(color: gray900, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: gray50,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        8,
                      ),
                      bottomRight: Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: SizedBox(
                      child: PrimaryButton(
                        onPressed: onPress,
                        text: "Oke, saya mengerti",
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    },
  );
}
