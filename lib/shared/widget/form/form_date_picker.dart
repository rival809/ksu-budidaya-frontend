import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class FormDatePicker extends StatefulWidget {
  final String label;
  final String? value;
  final Function()? onTap;
  final bool enabled;
  final bool usingFormat;

  const FormDatePicker(
      {Key? key,
      required this.label,
      required this.value,
      required this.onTap,
      required this.enabled,
      required this.usingFormat})
      : super(key: key);

  @override
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: myTextTheme.labelLarge?.copyWith(color: gray900),
          ),
        ),
        widget.usingFormat
            ? const SizedBox(
                height: 2.0,
              )
            : Container(),
        widget.usingFormat
            ? Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "(dd-mm-yyyy)",
                  style: bodyXSmall.copyWith(color: gray500),
                ),
              )
            : Container(),
        const SizedBox(
          height: 2.0,
        ),
        InkWell(
          onTap: widget.enabled ? widget.onTap : null,
          child: Container(
            width: MediaQuery.of(context).size.width,
            constraints: const BoxConstraints(
              maxHeight: 40,
              minHeight: 40,
            ),
            decoration: BoxDecoration(
              color: widget.enabled ? neutralWhite : gray200,
              border: Border.all(color: gray300),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.value == null
                        ? "Pilih Tanggal"
                        : formatDate(widget.value),
                    style: myTextTheme.bodyMedium
                        ?.copyWith(color: widget.enabled ? gray900 : gray600),
                  ),
                  SvgPicture.asset(
                    "assets/icons/misc/calendar_month.svg",
                    color: widget.enabled ? yellow600 : gray600,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
