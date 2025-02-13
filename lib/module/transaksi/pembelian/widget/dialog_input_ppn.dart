// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogInputPpn extends StatefulWidget {
  const DialogInputPpn({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogInputPpn> createState() => _DialogInputPpnState();
}

class _DialogInputPpnState extends State<DialogInputPpn> {
  final TextEditingController _ppnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
      ),
      child: Column(
        children: [
          BaseForm(
            label: 'PPN (%)',
            textEditingController: _ppnController,
            textInputType: TextInputType.number,
            maxLenght: 3,
            textInputFormater: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                child: BaseSecondaryButton(
                  text: 'Batal',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: BasePrimaryButton(
                  text: 'Simpan',
                  onPressed: () {
                    Navigator.pop(context, _ppnController.text);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
