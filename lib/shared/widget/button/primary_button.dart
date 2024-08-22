// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class PrimaryButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final String? pathIcon;
  final bool? isExpand;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.pathIcon,
    this.isExpand,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    Color textColor = widget.onPressed != null ? neutralBlack : neutralWhite;
    return SizedBox(
      // constraints: const BoxConstraints(
      //   maxHeight: 40,
      //   minHeight: 40,
      // ),
      width:
          widget.isExpand ?? false ? MediaQuery.of(context).size.width : null,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: widget.onPressed != null
              ? const MaterialStatePropertyAll(yellow500)
              : const MaterialStatePropertyAll(gray400),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(yellow900),
        ),
        onPressed: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.5),
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                trimString(widget.text).isNotEmpty
                    ? Text(
                        trimString(widget.text),
                        style: myTextTheme.labelLarge?.copyWith(
                          color: textColor,
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
    );
  }
}
