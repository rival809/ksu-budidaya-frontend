// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BaseTertiaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool? isDense;

  const BaseTertiaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
  });

  @override
  State<BaseTertiaryButton> createState() => _BaseTertiaryButtonState();
}

class _BaseTertiaryButtonState extends State<BaseTertiaryButton> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.onPressed != null
        ? onHover
            ? primaryColor
            : primaryColor
        : gray400;

    ColorFilter colorFilter = widget.onPressed != null
        ? onHover
            ? colorFilterPrimary
            : colorFilterPrimary
        : colorFilterGray400;
    return SizedBox(
      width: widget.isDense ?? false ? null : MediaQuery.of(context).size.width,
      height: 42,
      child: OutlinedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: MaterialStateProperty.all<Color>(
              onHover ? gray200 : Colors.transparent),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: widget.onPressed != null
                  ? Colors.transparent
                  : Colors.transparent,
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
              onHover ? gray200 : Colors.transparent),
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                trimString(widget.prefixIcon).isNotEmpty
                    ? SvgPicture.asset(
                        trimString(widget.prefixIcon),
                        colorFilter: colorFilter,
                      )
                    : Container(),
                trimString(widget.prefixIcon).isNotEmpty &&
                        trimString(widget.text).isNotEmpty
                    ? const SizedBox(
                        width: 8.0,
                      )
                    : Container(),
                trimString(widget.text).isNotEmpty
                    ? Text(
                        trimString(widget.text),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: textColor,
                              height: 1.75,
                            ),
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      )
                    : Container(),
                trimString(widget.suffixIcon).isNotEmpty &&
                        trimString(widget.text).isNotEmpty
                    ? const SizedBox(
                        width: 8.0,
                      )
                    : Container(),
                trimString(widget.suffixIcon).isNotEmpty
                    ? SvgPicture.asset(
                        trimString(widget.suffixIcon),
                        colorFilter: colorFilter,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
