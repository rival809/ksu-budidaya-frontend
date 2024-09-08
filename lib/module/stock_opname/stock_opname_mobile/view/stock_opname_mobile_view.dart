import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../controller/stock_opname_mobile_controller.dart';

class StockOpnameMobileView extends StatefulWidget {
  const StockOpnameMobileView({Key? key}) : super(key: key);

  Widget build(context, StockOpnameMobileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("StockOpnameMobile"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }

  @override
  State<StockOpnameMobileView> createState() => StockOpnameMobileController();
}
