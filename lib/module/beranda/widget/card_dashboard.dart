// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CardDashboard extends StatefulWidget {
  final String label;
  final String tooltip;
  final String nominal;
  final double? percentage;

  const CardDashboard({
    Key? key,
    required this.label,
    required this.nominal,
    required this.tooltip,
    this.percentage,
  }) : super(key: key);

  @override
  State<CardDashboard> createState() => _CardDashboardState();
}

class _CardDashboardState extends State<CardDashboard> {
  @override
  Widget build(BuildContext context) {
    String label = widget.label;
    String nominal = widget.nominal;
    double? percentageIncome = widget.percentage;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: neutralWhite,
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: myTextTheme.bodyLarge?.copyWith(
                    color: gray700,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Tooltip(
                message: widget.tooltip,
                triggerMode: TooltipTriggerMode.tap,
                margin: EdgeInsets.zero,
                enableTapToDismiss: false,
                padding: const EdgeInsets.all(8),
                preferBelow: false,
                verticalOffset: 12,
                child: SvgPicture.asset(
                  iconInfo,
                  colorFilter: colorFilterPrimary,
                  width: 24,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  // "Rp. ${formatMoney(controller.resultMonthly.data?.totalIncome.toString())}",
                  nominal,
                  style: myTextTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              if (percentageIncome != null)
                Row(
                  children: [
                    SvgPicture.asset(
                      isPositive(percentageIncome) ? iconArrowDropUp : iconArrowDropDown,
                      colorFilter:
                          isPositive(percentageIncome) ? colorFilterPrimary : colorFilterRed800,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "${formatMoney(percentageIncome.toString())} %",
                      style: myTextTheme.titleMedium?.copyWith(
                        color: isPositive(percentageIncome) ? primaryColor : red800,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
