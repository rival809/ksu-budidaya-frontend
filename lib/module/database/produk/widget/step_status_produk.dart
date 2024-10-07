import 'package:flutter/material.dart';
import 'package:ksu_budidaya/shared/theme/theme_config.dart';

class StepStatusProduk extends StatefulWidget {
  final bool step1;
  final Function()? onTapStep1;
  final String textStep1;
  final bool step2;
  final Function()? onTapStep2;
  final String textStep2;

  const StepStatusProduk({
    Key? key,
    required this.step1,
    required this.onTapStep1,
    required this.textStep1,
    required this.step2,
    required this.onTapStep2,
    required this.textStep2,
  }) : super(key: key);

  @override
  State<StepStatusProduk> createState() => _StepStatusProdukState();
}

class _StepStatusProdukState extends State<StepStatusProduk> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
