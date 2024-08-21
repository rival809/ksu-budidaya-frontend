// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class TertiaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final String? pathIcon;
  final bool? isDense;

  const TertiaryButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.pathIcon,
    this.isDense,
  }) : super(key: key);

  @override
  State<TertiaryButton> createState() => _TertiaryButtonState();
}

class _TertiaryButtonState extends State<TertiaryButton> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.onPressed != null
        ? onHover
            ? yellow700
            : gray900
        : gray400;
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 40,
        minHeight: 40,
      ),
      child: IntrinsicWidth(
        child: OutlinedButton(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: widget.onPressed != null
                    ? Colors.transparent
                    : Colors.transparent,
              ),
            ),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          onFocusChange: (value) {
            setState(
              () {
                onHover = value;
              },
            );
          },
          onHover: (value) {
            setState(
              () {
                onHover = value;
              },
            );
          },
          onPressed: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  trimString(widget.text).isNotEmpty
                      ? Text(
                          trimString(widget.text),
                          style: myTextTheme.titleSmall?.copyWith(
                            color: textColor,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        )
                      : Container(),
                  trimString(widget.pathIcon).isNotEmpty
                      ? const SizedBox(
                          width: 8.0,
                        )
                      : Container(),
                  trimString(widget.pathIcon).isNotEmpty
                      ? SvgPicture.asset(
                          trimString(widget.pathIcon),
                          color: textColor,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
