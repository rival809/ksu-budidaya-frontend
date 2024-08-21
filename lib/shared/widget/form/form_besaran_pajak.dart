// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class FormBesaranPajak extends StatefulWidget {
  final String label;
  final bool? isMobile;
  final TextEditingController textFirstEditingController;
  final TextEditingController textSecondEditingController;
  final bool enabledPokok;
  final bool enabledDenda;
  final Function(String value) onChangedPokok;
  final Function(String value) onChangedDenda;
  final String? Function(String?)? validatorPokok;
  final String? Function(String?)? validatorDenda;

  const FormBesaranPajak({
    Key? key,
    required this.label,
    this.isMobile,
    required this.enabledPokok,
    required this.onChangedPokok,
    this.validatorPokok,
    required this.enabledDenda,
    required this.onChangedDenda,
    this.validatorDenda,
    required this.textFirstEditingController,
    required this.textSecondEditingController,
  }) : super(key: key);

  @override
  State<FormBesaranPajak> createState() => _FormBesaranPajakState();
}

class _FormBesaranPajakState extends State<FormBesaranPajak> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: widget.isMobile ?? false
              ? BorderSide.none
              : const BorderSide(color: gray100),
        ),
      ),
      child: Padding(
        padding: widget.isMobile ?? false
            ? const EdgeInsets.only(bottom: 12)
            : const EdgeInsets.symmetric(vertical: 12.0),
        child: widget.isMobile ?? false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.label} :",
                    style: myTextTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: IntrinsicHeight(
                          child: Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: gray200,
                                border: Border.all(color: gray300),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Text(
                                    "Rp.",
                                    style: myTextTheme.bodyMedium
                                        ?.copyWith(color: gray900),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                // autofocus: true,
                                style: myTextTheme.bodyMedium
                                    ?.copyWith(color: gray900),
                                textAlignVertical: TextAlignVertical.bottom,
                                inputFormatters: [
                                  ThousandsFormatter(),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'),
                                  ),
                                ],
                                controller: widget.textFirstEditingController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                cursorColor: yellow700,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: widget.enabledPokok
                                      ? neutralWhite
                                      : gray200,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16.5),
                                  hintStyle: myTextTheme.bodyMedium
                                      ?.copyWith(color: gray600),
                                  errorStyle: const TextStyle(height: 0.7),
                                  errorMaxLines: 1,
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: red500, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: yellow700, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: gray300, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: red500, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: gray300, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: gray300, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                ),
                                enabled: widget.enabledPokok,
                                onChanged: widget.onChangedPokok,
                                validator: widget.validatorPokok,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: IntrinsicHeight(
                          child: Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: gray200,
                                border: Border.all(color: gray300),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Center(
                                  child: Text(
                                    "Rp.",
                                    style: myTextTheme.bodyMedium
                                        ?.copyWith(color: gray900),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                // autofocus: true,
                                controller: widget.textSecondEditingController,
                                style: myTextTheme.bodyMedium
                                    ?.copyWith(color: gray900),
                                textAlignVertical: TextAlignVertical.bottom,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  ThousandsFormatter(),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'),
                                  ),
                                ],
                                cursorColor: yellow700,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: widget.enabledDenda
                                      ? neutralWhite
                                      : gray200,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16.5),
                                  hintStyle: myTextTheme.bodyMedium
                                      ?.copyWith(color: gray600),
                                  errorStyle: const TextStyle(height: 0.7),
                                  errorMaxLines: 1,
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: red500, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: yellow700, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: gray300, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: red500, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: gray300, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: gray300, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                ),
                                enabled: widget.enabledDenda,
                                onChanged: widget.onChangedDenda,
                                validator: widget.validatorDenda,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.label,
                                style: myTextTheme.labelLarge?.copyWith(
                                  color: gray900,
                                ),
                              ),
                              const Text(":"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Expanded(
                          child: IntrinsicHeight(
                            child: Row(children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: gray200,
                                  border: Border.all(color: gray300),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Text(
                                      "Rp.",
                                      style: myTextTheme.bodyMedium
                                          ?.copyWith(color: gray900),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  // autofocus: true,
                                  cursorColor: yellow700,
                                  style: myTextTheme.bodyMedium
                                      ?.copyWith(color: gray900),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]'),
                                    ),
                                  ],
                                  controller: widget.textFirstEditingController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: widget.enabledPokok
                                        ? neutralWhite
                                        : gray200,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16.5),
                                    hintStyle: myTextTheme.bodyMedium
                                        ?.copyWith(color: gray600),
                                    errorStyle: const TextStyle(height: 0.7),
                                    errorMaxLines: 1,
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: red500, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: yellow700, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: gray300, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: red500, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: gray300, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: gray300, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                  ),
                                  enabled: widget.enabledPokok,
                                  onChanged: widget.onChangedPokok,
                                  validator: widget.validatorPokok,
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: IntrinsicHeight(
                            child: Row(children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: gray200,
                                  border: Border.all(color: gray300),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Center(
                                    child: Text(
                                      "Rp.",
                                      style: myTextTheme.bodyMedium
                                          ?.copyWith(color: gray900),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  // autofocus: true,
                                  controller:
                                      widget.textSecondEditingController,
                                  style: myTextTheme.bodyMedium
                                      ?.copyWith(color: gray900),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]'),
                                    ),
                                  ],
                                  textAlign: TextAlign.right,
                                  cursorColor: yellow700,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: widget.enabledDenda
                                        ? neutralWhite
                                        : gray200,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16.5),
                                    hintStyle: myTextTheme.bodyMedium
                                        ?.copyWith(color: gray600),
                                    errorStyle: const TextStyle(height: 0.7),
                                    errorMaxLines: 1,
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: red500, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: yellow700, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: gray300, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: red500, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: gray300, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: gray300, width: 1),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight: Radius.circular(8)),
                                    ),
                                  ),
                                  enabled: widget.enabledDenda,
                                  onChanged: widget.onChangedDenda,
                                  validator: widget.validatorDenda,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
