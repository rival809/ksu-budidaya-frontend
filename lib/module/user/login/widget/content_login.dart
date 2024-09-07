// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';

class ContentLogin extends StatefulWidget {
  const ContentLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentLogin> createState() => _ContentLoginState();
}

class _ContentLoginState extends State<ContentLogin> {
  LoginController controller = LoginController.instance;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                height: 100,
                "assets/images/logo/logo.png",
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Center(
              child: Text(
                "KSU BUDIDAYA",
                style: myTextTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            BaseForm(
              label: "Username",
              autoFocus: true,
              onChanged: (value) {
                controller.username = value;
                controller.update();
              },
              prefixIcon: iconAkun,
              hintText: "Masukkan username",
              validator: Validatorless.required("Username tidak boleh kosong"),
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              label: "Kata sandi",
              onChanged: (value) {
                controller.password = value;
                controller.update();
              },
              prefixIcon: iconKey,
              obsecure: controller.obsecure,
              suffixIcon: controller.obsecure ? iconEyeOn : iconEyeOff,
              onTapSuffix: () {
                controller.obsecure = !controller.obsecure;
                controller.update();
                update();
              },
              hintText: "Masukkan kata sandi",
              onEditComplete: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.doLogin();
                  controller.update();
                }
              },
              validator:
                  Validatorless.required("Kata sandi tidak boleh kosong"),
            ),
            const SizedBox(
              height: 24.0,
            ),
            BasePrimaryButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.doLogin();
                  controller.update();
                }
              },
              text: "Masuk",
            ),
          ],
        ),
      ),
    );
  }
}
