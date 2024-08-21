// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowRincianDesktop extends StatefulWidget {
  final String title;
  final String pokok;
  final String denda;
  final bool? status;

  const RowRincianDesktop({
    Key? key,
    required this.title,
    required this.pokok,
    required this.denda,
    this.status = true,
  }) : super(key: key);

  @override
  State<RowRincianDesktop> createState() => _RowRincianDesktopState();
}

class _RowRincianDesktopState extends State<RowRincianDesktop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: bodyXSmall.copyWith(
              color: gray900,
            ),
          ),
        ),
        Expanded(
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
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "Rp.",
                      style: bodyXSmall.copyWith(
                        color: gray900,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  widget.pokok,
                  style: bodyXSmall.copyWith(
                    color: gray900,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  widget.status! ? "Rp." : "",
                  style: bodyXSmall.copyWith(
                    color: gray900,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  widget.denda,
                  style: bodyXSmall.copyWith(
                    color: gray900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
