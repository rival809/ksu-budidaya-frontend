import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ProsesStep extends StatefulWidget {
  final bool step1;
  final Function()? onTapStep1;
  final String textStep1;
  final bool step2;
  final Function()? onTapStep2;
  final String textStep2;
  final bool? step3;
  final Function()? onTapStep3;
  final String? textStep3;

  const ProsesStep({
    Key? key,
    required this.step1,
    required this.onTapStep1,
    required this.textStep1,
    required this.step2,
    required this.onTapStep2,
    required this.textStep2,
    this.step3,
    this.onTapStep3,
    this.textStep3,
  }) : super(key: key);

  @override
  State<ProsesStep> createState() => _ProsesStepState();
}

class _ProsesStepState extends State<ProsesStep> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IntrinsicWidth(
          child: Column(
            children: [
              InkWell(
                onTap: widget.onTapStep1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.textStep1,
                    style: myTextTheme.bodyLarge?.copyWith(
                      color: widget.step1 ? primaryColor : gray500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                color: widget.step1 ? primaryColor : gray200,
                height: 2,
              ),
            ],
          ),
        ),
        IntrinsicWidth(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: widget.onTapStep2,
                  child: Text(
                    widget.textStep2,
                    style: myTextTheme.bodyLarge?.copyWith(
                      color: widget.step2 ? primaryColor : gray500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                color: widget.step2 ? primaryColor : gray200,
                height: 2,
              ),
            ],
          ),
        ),
        if (widget.textStep3?.isNotEmpty ?? false)
          IntrinsicWidth(
            child: Column(
              children: [
                InkWell(
                  onTap: widget.onTapStep3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      trimString(widget.textStep3),
                      style: myTextTheme.bodyLarge?.copyWith(
                        color: widget.step3 ?? false ? primaryColor : gray500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  color: widget.step3 ?? false ? primaryColor : gray200,
                  height: 2,
                ),
              ],
            ),
          ),
        Expanded(
          child: Column(
            children: [
              const Text(
                "",
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                color: gray200,
                height: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
