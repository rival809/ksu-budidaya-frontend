import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BaseSecondaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool? isDense;

  const BaseSecondaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
  });

  @override
  State<BaseSecondaryButton> createState() => _BaseSecondaryButtonState();
}

class _BaseSecondaryButtonState extends State<BaseSecondaryButton> {
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
          backgroundColor: MaterialStateProperty.all<Color>(neutralWhite),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: widget.onPressed != null
                  ? onHover
                      ? primaryColor
                      : primaryColor
                  : gray400,
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
              onHover ? gray200 : neutralWhite),
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
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              height: 1.75,
                              color: textColor,
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
