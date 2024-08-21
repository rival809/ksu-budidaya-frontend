import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => Container(
          color: neutralWhite,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: const IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ContentLogin(),
              ),
            ),
          ),
        ),
        desktop: (BuildContext context) => SingleChildScrollView(
          controller: ScrollController(),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const ContainerBody(
                isAppbar: false,
                child: ContentLogin(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
