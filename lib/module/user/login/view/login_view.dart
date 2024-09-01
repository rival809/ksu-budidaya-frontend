import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: neutralWhite,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const ContentLogin(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
