import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';

class ProsesStep extends StatefulWidget {
  final bool step1;
  final Function()? onTapStep1;
  final String textStep1;
  final bool? step2;
  final Function()? onTapStep2;
  final String? textStep2;
  final bool? step3;
  final Function()? onTapStep3;
  final String? textStep3;
  final bool? step4;
  final Function()? onTapStep4;
  final String? textStep4;

  const ProsesStep({
    Key? key,
    required this.step1,
    required this.onTapStep1,
    required this.textStep1,
    this.step2,
    this.onTapStep2,
    this.textStep2,
    this.step3,
    this.onTapStep3,
    this.textStep3,
    this.step4,
    this.onTapStep4,
    this.textStep4,
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
        if (widget.textStep2?.isNotEmpty ?? false)
          IntrinsicWidth(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: widget.onTapStep2,
                    child: Text(
                      trimString(widget.textStep2),
                      style: myTextTheme.bodyLarge?.copyWith(
                        color: widget.step2 ?? false ? primaryColor : gray500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  color: widget.step2 ?? false ? primaryColor : gray200,
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
        if (widget.textStep4?.isNotEmpty ?? false)
          IntrinsicWidth(
            child: Column(
              children: [
                InkWell(
                  onTap: widget.onTapStep4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      trimString(widget.textStep4),
                      style: myTextTheme.bodyLarge?.copyWith(
                        color: widget.step4 ?? false ? primaryColor : gray500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  color: widget.step4 ?? false ? primaryColor : gray200,
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
