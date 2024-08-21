import 'package:ksu_budidaya/core_package.dart';

formatingCurrency(value) {
  NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'id', symbol: '');
  return currencyFormatter.format(value).toString().replaceAll(",00", "");
}

String formatCurrency(String amountString) {
  final amount = int.tryParse(amountString) ?? 0;
  String formattedNumber =
      NumberFormat.decimalPattern('en_US').format(amount).replaceAll(',', '.');

  return formattedNumber;
}
