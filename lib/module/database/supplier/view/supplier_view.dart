import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../controller/supplier_controller.dart';

class SupplierView extends StatefulWidget {
  const SupplierView({Key? key}) : super(key: key);

  Widget build(context, SupplierController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Supplier"),
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
  State<SupplierView> createState() => SupplierController();
}
