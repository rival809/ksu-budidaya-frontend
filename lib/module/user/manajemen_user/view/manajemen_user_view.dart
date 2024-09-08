
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../controller/manajemen_user_controller.dart';

class ManajemenUserView extends StatefulWidget {
    const ManajemenUserView({Key? key}) : super(key: key);

    Widget build(context, ManajemenUserController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
        title: const Text("ManajemenUser"),
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
    State<ManajemenUserView> createState() => ManajemenUserController();
}
    