// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowJumlahNppab extends StatefulWidget {
  final String jumlah;

  const RowJumlahNppab({
    Key? key,
    required this.jumlah,
  }) : super(key: key);

  @override
  State<RowJumlahNppab> createState() => _RowJumlahNppabState();
}

class _RowJumlahNppabState extends State<RowJumlahNppab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "TOTAL",
            style: myTextTheme.titleSmall?.copyWith(
              color: gray900,
              height: 1.5,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      ":",
                      style: myTextTheme.bodyLarge?.copyWith(
                        color: gray900,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Rp.",
                      style: myTextTheme.titleSmall?.copyWith(
                        color: gray900,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.jumlah,
                style: myTextTheme.titleSmall?.copyWith(
                  color: gray900,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
