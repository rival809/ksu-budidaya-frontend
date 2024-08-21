import 'package:ksu_budidaya/core.dart';
import 'package:flutter/material.dart';

Future showBaseDialog({
  String? title,
  String? pathIconMessage,
  required String message,
  String? titleMessage,
  Function()? onPressedRight,
  Function()? onPressedLeft,
  Function()? onPressed,
  String? textSecondary,
  String? pathIconSecondary,
  String? textPrimary,
  String? pathIconPrimary,
  String? pathIconButton,
  String? text,
  bool? barrierDismissible,
  required BuildContext context,
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
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: trimString(title).isNotEmpty
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                trimString(title).isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 16,
                            ),
                            child: Text(
                              trimString(title),
                              style: myTextTheme.displaySmall?.copyWith(
                                color: gray900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: trimString(pathIconMessage).isNotEmpty
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        trimString(pathIconMessage).isNotEmpty
                            ? SvgPicture.asset(
                                trimString(pathIconMessage),
                                height: 100,
                                width: 100,
                              )
                            : Container(),
                        trimString(pathIconMessage).isNotEmpty
                            ? const SizedBox(
                                height: 16.0,
                              )
                            : Container(),
                        Text(
                          trimString(titleMessage),
                          style: myTextTheme.displaySmall,
                          textAlign: pathIconMessage?.isEmpty ?? true
                              ? TextAlign.left
                              : TextAlign.center,
                        ),
                        trimString(titleMessage).isNotEmpty
                            ? const SizedBox(
                                height: 16.0,
                              )
                            : Container(),
                        Text(
                          trimString(message),
                          style: myTextTheme.bodyLarge,
                          textAlign: pathIconMessage?.isEmpty ?? true
                              ? TextAlign.left
                              : TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                (onPressed == null &&
                        onPressedLeft == null &&
                        onPressedRight == null)
                    ? Container()
                    : const SizedBox(
                        height: 16,
                      ),
                (onPressed == null &&
                        onPressedLeft == null &&
                        onPressedRight == null)
                    ? Container()
                    : Container(
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
                        child: Column(
                          children: [
                            onPressedLeft != null
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: SecondaryButton(
                                          onPressed: onPressedLeft,
                                          text: textSecondary,
                                          pathIcon: pathIconSecondary,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                        child: PrimaryButton(
                                          onPressed: onPressedRight,
                                          text: textPrimary,
                                          pathIcon: pathIconPrimary,
                                        ),
                                      ),
                                    ],
                                  )
                                : PrimaryButton(
                                    text: text,
                                    onPressed: onPressed,
                                    pathIcon: pathIconButton,
                                  ),
                          ],
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
