import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class BaseForm extends StatefulWidget {
  final String? label;
  final bool? require;
  final String? helperMessage;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final Function(String value)? onChanged;
  final Function()? onEditComplete;
  final List<TextInputFormatter>? textInputFormater;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? prefix;
  final String? prefixIcon;
  final String? suffixIcon;
  final Function()? onTapSuffix;
  final bool? enabled;
  final bool? obsecure;
  final bool? autoFocus;
  final int? maxLenght;
  final int? maxLines;
  final bool? haveCounter;
  final AutovalidateMode? autoValidate;
  final Function()? onTap;
  final Key? keyForm;
  final bool? readOnly;

  const BaseForm({
    super.key,
    this.label,
    this.require,
    this.enabled,
    this.obsecure,
    this.onChanged,
    this.hintText,
    this.textEditingController,
    this.textInputFormater,
    this.initialValue,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffix,
    this.maxLenght,
    this.textInputType,
    this.helperMessage,
    this.autoFocus,
    this.onEditComplete,
    this.suffix,
    this.prefix,
    this.haveCounter,
    this.autoValidate,
    this.maxLines = 1,
    this.onTap,
    this.keyForm,
    this.readOnly,
  });

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  final _isValid = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    widget.textEditingController?.addListener(_validateInput);
  }

  void _validateInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.validator != null && widget.autoValidate != null) {
        final isValid = widget.validator!(widget.textEditingController != null
                ? widget.textEditingController?.text
                : widget.initialValue) ==
            null;
        if (_isValid.value != isValid) {
          _isValid.value = isValid;
        }
      }
    });
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_validateInput);
    _isValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isValid,
          builder: (context, isValid, child) {
            return widget.label != null && widget.label!.isNotEmpty
                ? widget.require ?? false
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            text: widget.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: isValid ? gray900 : error,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: error,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.label!,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: isValid ? gray900 : error,
                                  ),
                        ),
                      )
                : Container();
          },
        ),
        if (widget.helperMessage != null &&
            widget.helperMessage!.isNotEmpty) ...[
          const SizedBox(height: 2.0),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              trimString(widget.helperMessage),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: gray500,
                    height: 1.8,
                  ),
              textHeightBehavior: const TextHeightBehavior(
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        ],
        if (widget.label != null && widget.label!.isNotEmpty)
          const SizedBox(height: 2.0),
        TextFormField(
          key: widget.keyForm,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: widget.enabled ?? true ? gray900 : gray600,
                height: 1.4,
              ),
          autofocus: widget.autoFocus ?? false,
          inputFormatters: widget.textInputFormater,
          initialValue:
              widget.initialValue?.isEmpty ?? true ? null : widget.initialValue,
          controller: widget.initialValue?.isEmpty ?? true
              ? widget.textEditingController
              : null,
          maxLength: widget.maxLenght,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          cursorColor: green700,
          textAlignVertical: TextAlignVertical.center,
          readOnly: widget.readOnly ?? false,
          obscureText: widget.obsecure ?? false,
          keyboardType: widget.textInputType,
          onEditingComplete: widget.onEditComplete,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
            hintText: widget.enabled ?? true ? widget.hintText : "-",
            prefixIcon:
                widget.prefixIcon != null && widget.prefixIcon!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          widget.prefixIcon!,
                          colorFilter: colorFilterGray500,
                        ),
                      )
                    : widget.prefix,
            suffixIcon:
                widget.suffixIcon != null && widget.suffixIcon!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: widget.onTapSuffix,
                          child: SvgPicture.asset(
                            widget.suffixIcon!,
                            colorFilter: widget.enabled ?? true
                                ? colorFilterGreen700
                                : colorFilterGray500,
                          ),
                        ),
                      )
                    : widget.suffix,
            prefixIconConstraints:
                widget.prefixIcon != null && widget.prefixIcon!.isNotEmpty
                    ? const BoxConstraints(
                        maxWidth: 40,
                        maxHeight: 40,
                        minHeight: 40,
                      )
                    : null,
            suffixIconConstraints:
                widget.suffixIcon != null && widget.suffixIcon!.isNotEmpty
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
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: gray600),
            errorStyle:
                Theme.of(context).textTheme.bodySmall?.copyWith(color: error),
            errorMaxLines: 1,
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: red500, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: green700, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: gray300, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: error, width: 1),
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
          autovalidateMode: widget.autoValidate,
          enabled: widget.enabled,
          validator: widget.validator != null
              ? (value) {
                  final error = widget.validator?.call(value);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final isValid = error == null;
                    if (_isValid.value != isValid) {
                      _isValid.value = isValid;
                    }
                  });
                  return error;
                }
              : null,
        ),
      ],
    );
  }
}
