import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

Future<Uint8List> getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}
