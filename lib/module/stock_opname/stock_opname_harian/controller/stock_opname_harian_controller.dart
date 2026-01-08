import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameHarianController extends State<StockOpnameHarianView> {
  static late StockOpnameHarianController instance;
  late StockOpnameHarianView view;

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
