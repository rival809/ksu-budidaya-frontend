import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final String? value;
  final Function()? onTap;
  final bool? enabled;
  final bool usingFormat;
  final String? validatorText;
  final TextEditingController? textEditingController;
  final String? suffixIcon;
  final String? hintText;
  final Function()? onClear;
  final String? Function(String?)? validator;

  const DatePicker({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
    this.enabled,
    required this.usingFormat,
    this.validatorText,
    this.textEditingController,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.onClear,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
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
        TextFormField(
          style: myTextTheme.bodyMedium?.copyWith(
            color: widget.enabled ?? true ? gray900 : gray600,
          ),
          readOnly: true,
          controller: widget.textEditingController,
          cursorColor: yellow700,
          textAlignVertical: TextAlignVertical.center,
          onTap: widget.onTap,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 16.5,
            ),
            hintText: widget.enabled ?? true ? widget.hintText : "-",
            suffixIcon: Row(
              children: [
                widget.onClear != null && widget.value != null
                    ? Expanded(
                        child: IconButton(
                          onPressed: widget.onClear,
                          icon: const Icon(Icons.close, color: red600),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: SvgPicture.asset(
                    "assets/icons/misc/calendar_month.svg",
                    color: yellow600,
                  ),
                ),
              ],
            ),
            suffixIconConstraints: BoxConstraints(
              maxWidth:
                  widget.onClear != null && widget.value != null ? 80 : 40,
              maxHeight: 40,
              minHeight: 40,
            ),
            filled: true,
            fillColor: widget.enabled ?? true ? neutralWhite : gray200,
            isDense: true,
            counterText: "",
            hintStyle: myTextTheme.bodyMedium?.copyWith(color: gray600),
            errorStyle: const TextStyle(height: 0.7),
            errorMaxLines: 1,
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: red500, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: yellow700, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: gray300, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: red500, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: gray300, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: gray300, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          enabled: widget.enabled,
          validator: widget.enabled ?? true ? widget.validator : null,
        ),
      ],
    );
  }
}
