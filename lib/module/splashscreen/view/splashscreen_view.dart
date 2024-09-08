
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../controller/splashscreen_controller.dart';

class SplashscreenView extends StatefulWidget {
    const SplashscreenView({Key? key}) : super(key: key);

    Widget build(context, SplashscreenController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
        title: const Text("Splashscreen"),
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
    State<SplashscreenView> createState() => SplashscreenController();
}
    