// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/date_formater/date_formater.dart';

class ContainerNota extends StatefulWidget {
  const ContainerNota({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerNota> createState() => _ContainerNotaState();
}

class _ContainerNotaState extends State<ContainerNota> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: neutralWhite,
      ),
      width: 400,
      child: Column(
        children: [
          Text(
            "KSU BUDI DAYA",
            style: myTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "KASIR 1",
                  style: myTextTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  formatDateTime(DateTime.now().toString()),
                  textAlign: TextAlign.end,
                  style: myTextTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
