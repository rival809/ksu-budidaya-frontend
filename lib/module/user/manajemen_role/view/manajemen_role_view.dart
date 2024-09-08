
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../controller/manajemen_role_controller.dart';

class ManajemenRoleView extends StatefulWidget {
    const ManajemenRoleView({Key? key}) : super(key: key);

    Widget build(context, ManajemenRoleController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
        title: const Text("ManajemenRole"),
        actions: const [],
        ),
        body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            children: const [],
            ),
        ),
        ),
    );
    }

    @override
    State<ManajemenRoleView> createState() => ManajemenRoleController();
}
    