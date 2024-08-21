import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerNomorPolisi extends StatefulWidget {
  final Function(String? value) onChangedTextfieldOne;
  final Function(String? value) onChangedTextfieldTwo;
  final Function(String? value) onChangedTextfieldThree;
  final String? Function(String?)? validatorOne;
  final String? Function(String?)? validatorTwo;
  final String? Function(String?)? validatorThree;
  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final FocusNode focusNode3;
  final Function()? onEditingComplete;
  const ContainerNomorPolisi({
    super.key,
    required this.onChangedTextfieldOne,
    required this.onChangedTextfieldTwo,
    required this.onChangedTextfieldThree,
    required this.validatorOne,
    required this.validatorTwo,
    required this.validatorThree,
    required this.focusNode1,
    required this.focusNode2,
    required this.focusNode3,
    this.onEditingComplete,
  });

  @override
  State<ContainerNomorPolisi> createState() => _ContainerNomorPolisiState();
}

class _ContainerNomorPolisiState extends State<ContainerNomorPolisi> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            focusNode: widget.focusNode1,
            cursorColor: yellow700,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
              UpperCaseTextFormatter(),
            ],
            textAlign: TextAlign.center,
            style: myTextTheme.headlineLarge,
            maxLength: 1,
            decoration: InputDecoration(
              hintText: "X",
              counterText: "",
              labelStyle: const TextStyle(
                color: yellow700,
              ),
              hintStyle: myTextTheme.headlineLarge?.copyWith(color: gray600),
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
          child: TextFormField(
            focusNode: widget.focusNode2,
            cursorColor: yellow700,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            style: myTextTheme.headlineLarge,
            maxLength: 4,
            decoration: InputDecoration(
              hintText: "XXXX",
              counterText: "",
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              hintStyle: myTextTheme.headlineLarge?.copyWith(color: gray600),
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
          child: TextFormField(
            cursorColor: yellow700,
            focusNode: widget.focusNode3,
            onEditingComplete: widget.onEditingComplete,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
              UpperCaseTextFormatter(),
            ],
            textAlign: TextAlign.center,
            style: myTextTheme.headlineLarge,
            maxLength: 3,
            decoration: InputDecoration(
              hintText: "XXX",
              counterText: "",
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              hintStyle: myTextTheme.headlineLarge?.copyWith(color: gray600),
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
    );
  }
}
