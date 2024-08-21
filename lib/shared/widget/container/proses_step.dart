import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ProsesStep extends StatefulWidget {
  final bool step1;
  final bool? step2;
  final bool? step3;

  const ProsesStep({
    Key? key,
    required this.step1,
    this.step2,
    this.step3,
  }) : super(key: key);

  @override
  State<ProsesStep> createState() => _ProsesStepState();
}

class _ProsesStepState extends State<ProsesStep> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            child: Container(
              color: widget.step1 ? yellow600 : gray200,
              height: 6,
            ),
          ),
        ),
        widget.step2 != null
            ? const SizedBox(
                width: 6.0,
              )
            : Container(),
        widget.step2 != null
            ? Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: Container(
                    color: widget.step2 ?? false ? yellow600 : gray200,
                    height: 6,
                  ),
                ),
              )
            : Container(),
        widget.step3 != null
            ? const SizedBox(
                width: 6.0,
              )
            : Container(),
        widget.step3 != null
            ? Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: Container(
                    color: widget.step3 ?? false ? yellow600 : gray200,
                    height: 6,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
