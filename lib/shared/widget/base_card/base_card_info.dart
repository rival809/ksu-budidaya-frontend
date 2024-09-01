// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BaseCardInfo extends StatefulWidget {
  final DataColorType? type;
  final Color? cardColor;
  final Color? borderColor;
  final String text;
  final String? pathIconPrefix;
  final String? pathIconSuffix;
  final Function()? onTapSuffix;
  final String? labelAksi1;
  final Function()? onTapAksi1;
  final String? labelAksi2;
  final Function()? onTapAksi2;
  final String? labelAksi3;
  final Function()? onTapAksi3;

  const BaseCardInfo({
    super.key,
    this.type,
    this.cardColor,
    this.borderColor,
    required this.text,
    this.pathIconPrefix,
    this.onTapSuffix,
    this.pathIconSuffix,
    this.labelAksi1,
    this.onTapAksi1,
    this.labelAksi2,
    this.onTapAksi2,
    this.labelAksi3,
    this.onTapAksi3,
  });

  @override
  State<BaseCardInfo> createState() => _BaseCardInfoState();
}

class _BaseCardInfoState extends State<BaseCardInfo> {
  @override
  Widget build(BuildContext context) {
    final DataColor? dataColor =
        widget.type != null ? DataColor.getColorByType(widget.type!) : null;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor == lowEmphasis
            ? Theme.of(context).cardColor
            : dataColor != null
                ? dataColor.backgroundColor
                : widget.cardColor,
        border: Border.all(
          color: Theme.of(context).cardColor == lowEmphasis
              ? Theme.of(context).cardColor
              : dataColor != null
                  ? dataColor.borderColor
                  : widget.borderColor ?? gray800,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (trimString(widget.pathIconPrefix).toString().isNotEmpty)
                  SvgPicture.asset(
                    widget.pathIconPrefix ?? "",
                    colorFilter: dataColor != null
                        ? dataColor.borderColorFilter
                        : ColorFilter.mode(widget.borderColor ?? neutralWhite,
                            BlendMode.srcIn),
                  ),
                if (trimString(widget.pathIconPrefix).toString().isNotEmpty)
                  const SizedBox(
                    width: 16.0,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SingleChildScrollView(
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (trimString(widget.labelAksi3)
                                .toString()
                                .isNotEmpty)
                              InkWell(
                                onTap: widget.onTapAksi3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    trimString(widget.labelAksi3),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: dataColor != null
                                              ? dataColor.borderColor
                                              : widget.borderColor,
                                        ),
                                  ),
                                ),
                              ),
                            if (trimString(widget.labelAksi2)
                                    .toString()
                                    .isNotEmpty &&
                                trimString(widget.labelAksi3)
                                    .toString()
                                    .isNotEmpty)
                              const SizedBox(
                                width: 16.0,
                              ),
                            if (trimString(widget.labelAksi2)
                                .toString()
                                .isNotEmpty)
                              InkWell(
                                onTap: widget.onTapAksi2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    trimString(widget.labelAksi2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: dataColor != null
                                              ? dataColor.borderColor
                                              : widget.borderColor,
                                        ),
                                  ),
                                ),
                              ),
                            if (trimString(widget.labelAksi1)
                                    .toString()
                                    .isNotEmpty &&
                                trimString(widget.labelAksi2)
                                    .toString()
                                    .isNotEmpty)
                              const SizedBox(
                                width: 16.0,
                              ),
                            if (trimString(widget.labelAksi1)
                                .toString()
                                .isNotEmpty)
                              InkWell(
                                onTap: widget.onTapAksi1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    trimString(widget.labelAksi1),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: dataColor != null
                                              ? dataColor.borderColor
                                              : widget.borderColor,
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.pathIconSuffix?.isNotEmpty ?? false)
                  const SizedBox(
                    width: 16.0,
                  ),
                if (widget.pathIconSuffix?.isNotEmpty ?? false)
                  InkWell(
                    onTap: widget.onTapSuffix,
                    child: SvgPicture.asset(
                      widget.pathIconSuffix ?? "",
                      colorFilter: dataColor != null
                          ? dataColor.borderColorFilter
                          : ColorFilter.mode(widget.borderColor ?? neutralWhite,
                              BlendMode.srcIn),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
