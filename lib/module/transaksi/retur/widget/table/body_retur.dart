// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BodyRetur extends StatefulWidget {
  final ReturController controller;
  final int index;
  final Color color;
  const BodyRetur({
    Key? key,
    required this.color,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  State<BodyRetur> createState() => _BodyReturState();
}

class _BodyReturState extends State<BodyRetur> {
  @override
  Widget build(BuildContext context) {
    ReturController controller = widget.controller;

    var dataIndex = controller.dataPayloadRetur.details?[widget.index];
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            controller.isDetail
                ? Container()
                : InkWell(
                    onTap: () {
                      controller.dataPayloadRetur.details
                          ?.removeAt(widget.index);
                      controller.update();
                    },
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 8),
                      child: SvgPicture.asset(
                        iconDelete,
                        width: 24,
                        colorFilter: colorFilterRed800,
                      ),
                    ),
                  ),
            controller.isDetail
                ? Container()
                : Container(
                    width: 1,
                    color: blueGray50,
                  ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimStringStrip(controller.dataPayloadRetur.idPembelian),
                  style: myTextTheme.bodyMedium,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimStringStrip(dataIndex?.idProduct),
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
                child: Text(
                  trimStringStrip(dataIndex?.nmDivisi),
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
                child: Text(
                  trimStringStrip(dataIndex?.nmProduk),
                  style: myTextTheme.bodyMedium,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Container(
              width: 110,
              padding: const EdgeInsets.all(8),
              child: Text(
                formatMoney(dataIndex?.hargaBeli),
                style: myTextTheme.bodyMedium,
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Container(
              width: 60,
              padding: const EdgeInsets.all(8),
              child: Text(
                formatMoney(dataIndex?.jumlah),
                textAlign: TextAlign.center,
                style: myTextTheme.bodyMedium,
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.all(8),
              child: Text(
                formatMoney(dataIndex?.totalNilaiBeli),
                textAlign: TextAlign.end,
                style: myTextTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
