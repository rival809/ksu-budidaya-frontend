// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BodyCetakLabel extends StatefulWidget {
  final int index;
  final CetakLabelController controller;
  const BodyCetakLabel({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<BodyCetakLabel> createState() => _BodyCetakLabelState();
}

class _BodyCetakLabelState extends State<BodyCetakLabel> {
  @override
  Widget build(BuildContext context) {
    CetakLabelController controller = widget.controller;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimString(
                    controller.dataLabel[widget.index].idProduct,
                  ),
                  style: myTextTheme.bodyMedium,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimString(
                    controller.dataLabel[widget.index].nmProduct,
                  ),
                  style: myTextTheme.bodyMedium,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  formatMoney(
                    trimString(
                      controller.dataLabel[widget.index].hargaJual,
                    ),
                  ),
                  style: myTextTheme.bodyMedium,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    controller.dataLabel.removeAt(widget.index);
                    controller.update();
                  },
                  child: SvgPicture.asset(
                    iconDelete,
                    colorFilter: colorFilter(
                      color: red600,
                    ),
                    height: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
