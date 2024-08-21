import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerNomorPolisiBase extends StatefulWidget {
  final Function(String? value) onChangedTextfieldOne;
  final Function(String? value) onChangedTextfieldTwo;
  final Function(String? value) onChangedTextfieldThree;
  final String? Function(String?)? validatorOne;
  final String? Function(String?)? validatorTwo;
  final String? Function(String?)? validatorThree;
  final String? usingFormat;
  final String? label;
  final bool? require;
  final bool? enabled;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;

  const ContainerNomorPolisiBase({
    super.key,
    required this.onChangedTextfieldOne,
    required this.onChangedTextfieldTwo,
    required this.onChangedTextfieldThree,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    this.validatorOne,
    this.validatorTwo,
    this.validatorThree,
    this.usingFormat,
    this.label,
    this.require,
    this.enabled,
  });

  @override
  State<ContainerNomorPolisiBase> createState() =>
      _ContainerNomorPolisiBaseState();
}

class _ContainerNomorPolisiBaseState extends State<ContainerNomorPolisiBase> {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: yellow700,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
                  UpperCaseTextFormatter(),
                ],
                controller: widget.controller1,
                textAlign: TextAlign.center,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: widget.enabled ?? true ? gray900 : gray600,
                ),
                maxLength: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.5,
                  ),
                  isDense: true,
                  filled: true,
                  enabled: widget.enabled ?? true,
                  fillColor: widget.enabled ?? true ? neutralWhite : gray200,
                  hintText: "X",
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
                onChanged: widget.onChangedTextfieldOne,
                validator: widget.validatorOne,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: widget.controller2,
                cursorColor: yellow700,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: widget.enabled ?? true ? gray900 : gray600,
                ),
                maxLength: 4,
                decoration: InputDecoration(
                  hintText: "XXXX",
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.5,
                  ),
                  isDense: true,
                  enabled: widget.enabled ?? true,
                  filled: true,
                  fillColor: widget.enabled ?? true ? neutralWhite : gray200,
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
                onChanged: widget.onChangedTextfieldTwo,
                validator: widget.validatorTwo,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: widget.controller3,
                cursorColor: yellow700,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
                  UpperCaseTextFormatter(),
                ],
                textAlign: TextAlign.center,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: widget.enabled ?? true ? gray900 : gray600,
                ),
                maxLength: 3,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.5,
                  ),
                  isDense: true,
                  enabled: widget.enabled ?? true,
                  filled: true,
                  fillColor: widget.enabled ?? true ? neutralWhite : gray200,
                  hintText: "XXX",
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
                onChanged: widget.onChangedTextfieldThree,
                validator: widget.validatorThree,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
