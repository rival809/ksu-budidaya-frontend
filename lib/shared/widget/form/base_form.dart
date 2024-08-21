import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class BaseForm extends StatefulWidget {
  final String? label;
  final bool? require;
  final bool? enabled;
  final bool? obsecure;
  final bool? canPress;
  final Function(String value) onChanged;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? textInputFormater;
  final String? Function(String?)? validator;
  final String? prefixIcon;
  final String? suffixIcon;
  final Function()? onTapSuffix;
  final Function()? onTap;
  final Function()? onEditComplete;
  final int? maxLenght;
  final TextInputType? textInputType;
  final String? usingFormat;
  final bool? autoFocus;
  final Widget? suffix;
  final bool? haveCounter;

  const BaseForm({
    Key? key,
    this.label,
    this.require,
    this.enabled,
    this.canPress,
    this.obsecure,
    required this.onChanged,
    this.hintText,
    this.textEditingController,
    this.textInputFormater,
    this.initialValue,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onTapSuffix,
    this.maxLenght,
    this.textInputType,
    this.usingFormat,
    this.autoFocus,
    this.onEditComplete,
    this.suffix,
    this.haveCounter,
  }) : super(key: key);

  @override
  State<BaseForm> createState() => _BaseMasteForm();
}

class _BaseMasteForm extends State<BaseForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        trimString(widget.label).isNotEmpty
            ? widget.require ?? false
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: trimString(widget.label),
                        style: myTextTheme.labelLarge?.copyWith(
                          color: gray900,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: myTextTheme.labelLarge?.copyWith(
                              color: red600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      trimString(widget.label),
                      style: myTextTheme.labelLarge?.copyWith(color: gray900),
                    ),
                  )
            : Container(),
        trimString(widget.usingFormat).isNotEmpty
            ? const SizedBox(
                height: 2.0,
              )
            : Container(),
        trimString(widget.usingFormat).isNotEmpty
            ? Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  trimString(widget.usingFormat),
                  style: bodyXSmall.copyWith(
                    color: gray500,
                  ),
                ),
              )
            : Container(),
        trimString(widget.label).isNotEmpty
            ? const SizedBox(
                height: 2.0,
              )
            : Container(),
        widget.canPress ?? false
            ? InkWell(
                onTap: widget.enabled ?? true ? widget.onTap : null,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(maxHeight: 41),
                  decoration: BoxDecoration(
                    color: widget.enabled ?? true ? neutralWhite : gray200,
                    border: Border.all(
                      color: gray300,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.initialValue ??
                                widget.textEditingController?.text ??
                                widget.hintText ??
                                "-",
                            style: myTextTheme.bodyMedium?.copyWith(
                              color: (widget.initialValue != null ||
                                      widget.textEditingController?.text !=
                                          null)
                                  ? widget.enabled ?? true
                                      ? gray900
                                      : gray600
                                  : widget.hintText != null
                                      ? gray600
                                      : gray900,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icons/misc/search.svg",
                          color: widget.enabled ?? true ? yellow700 : gray600,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : TextFormField(
                style: myTextTheme.bodyMedium?.copyWith(
                  color: widget.enabled ?? true ? gray900 : gray600,
                ),
                autofocus: widget.autoFocus ?? false,
                inputFormatters: widget.textInputFormater,
                initialValue: trimString(widget.initialValue).isEmpty
                    ? null
                    : widget.initialValue,
                controller: trimString(widget.initialValue).isEmpty
                    ? widget.textEditingController
                    : null,
                maxLength: widget.maxLenght,
                cursorColor: yellow700,
                textAlignVertical: TextAlignVertical.center,
                obscureText: widget.obsecure ?? false,
                keyboardType: widget.textInputType,
                onEditingComplete: widget.onEditComplete,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.5,
                  ),
                  hintText: widget.enabled ?? true ? widget.hintText : "-",
                  prefixIcon: trimString(widget.prefixIcon).isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(
                            12,
                          ),
                          child: SvgPicture.asset(
                            trimString(widget.prefixIcon),
                            color: gray500,
                          ),
                        )
                      : null,
                  prefixIconConstraints:
                      trimString(widget.prefixIcon).isNotEmpty
                          ? const BoxConstraints(
                              maxWidth: 40,
                              maxHeight: 40,
                              minHeight: 40,
                            )
                          : null,
                  suffixIcon: trimString(widget.suffixIcon).isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(
                            12,
                          ),
                          child: InkWell(
                            onTap: widget.onTapSuffix,
                            child: SvgPicture.asset(
                              trimString(widget.suffixIcon),
                              color: gray500,
                            ),
                          ),
                        )
                      : widget.suffix,
                  suffixIconConstraints:
                      trimString(widget.suffixIcon).isNotEmpty
                          ? const BoxConstraints(
                              maxWidth: 40,
                              maxHeight: 40,
                              minHeight: 40,
                            )
                          : null,
                  filled: true,
                  fillColor: widget.enabled ?? true ? neutralWhite : gray200,
                  isDense: true,
                  counterText: widget.haveCounter ?? false ? null : "",
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
                onChanged: widget.onChanged,
                validator: widget.validator,
              ),
      ],
    );
  }
}
