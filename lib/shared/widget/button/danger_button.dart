// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DangerButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final String? pathIcon;
  final bool? isDense;

  const DangerButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.pathIcon,
    this.isDense,
  }) : super(key: key);

  @override
  State<DangerButton> createState() => _DangerButtonState();
}

class _DangerButtonState extends State<DangerButton> {
  @override
  Widget build(BuildContext context) {
    Color textColor = neutralWhite;
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 40,
        minHeight: 40,
      ),
      width: widget.isDense ?? false ? null : MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: widget.onPressed != null
              ? const MaterialStatePropertyAll(red700)
              : const MaterialStatePropertyAll(gray400),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(red900),
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
                trimString(widget.text).isNotEmpty
                    ? Text(
                        trimString(widget.text),
                        style: myTextTheme.titleMedium?.copyWith(
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
