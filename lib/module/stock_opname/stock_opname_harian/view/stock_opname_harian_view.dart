import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameHarianView extends StatefulWidget {
  const StockOpnameHarianView({super.key});

  Widget build(context, StockOpnameHarianController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Opname Harian"),
        actions: const [],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  @override
  State<StockOpnameHarianView> createState() => StockOpnameHarianController();
}
