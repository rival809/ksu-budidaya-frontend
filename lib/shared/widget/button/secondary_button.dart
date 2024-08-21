import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class SecondaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final String? pathIcon;
  final bool? isDense;

  const SecondaryButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.pathIcon,
    this.isDense,
  }) : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    Color textColor = widget.onPressed != null
        ? onHover
            ? neutralWhite
            : neutralBlack
        : gray400;
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 40,
        minHeight: 40,
      ),
      width: widget.isDense ?? false ? null : MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: ButtonStyle(
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
                      ? yellow700
                      : neutralBlack
                  : gray400,
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(yellow900),
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
                        ),
                      )
                    : Container(),
                trimString(widget.pathIcon).isNotEmpty &&
                        trimString(widget.text).isNotEmpty
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
    );
  }
}
