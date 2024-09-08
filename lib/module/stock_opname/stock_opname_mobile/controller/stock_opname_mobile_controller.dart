import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/stock_opname_mobile_view.dart';

class StockOpnameMobileController extends State<StockOpnameMobileView> {
  static late StockOpnameMobileController instance;
  late StockOpnameMobileView view;

  TextEditingController textBarcodeController = TextEditingController();

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
