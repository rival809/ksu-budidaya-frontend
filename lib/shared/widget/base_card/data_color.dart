import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

enum DataColorType {
  info,
  warning,
  success,
  error,
}

class DataColor {
  final DataColorType type;
  final Color borderColor;
  final ColorFilter borderColorFilter;
  final Color backgroundColor;

  const DataColor({
    required this.type,
    required this.borderColor,
    required this.borderColorFilter,
    required this.backgroundColor,
  });

  static List<DataColor> dataColors = [
    const DataColor(
      type: DataColorType.info,
      borderColor: blue800,
      borderColorFilter: colorFilterBlue800,
      backgroundColor: blue50,
    ),
    const DataColor(
      type: DataColorType.warning,
      borderColor: yellow800,
      borderColorFilter: colorFilterYellow800,
      backgroundColor: yellow50,
    ),
    const DataColor(
      type: DataColorType.success,
      borderColor: green800,
      borderColorFilter: colorFilterGreen800,
      backgroundColor: green50,
    ),
    const DataColor(
      type: DataColorType.error,
      borderColor: red800,
      borderColorFilter: colorFilterRed800,
      backgroundColor: red50,
    ),
  ];

  static DataColor? getColorByType(DataColorType type) {
    try {
      return dataColors.firstWhere((color) => color.type == type);
    } catch (e) {
      return null;
    }
  }
}
