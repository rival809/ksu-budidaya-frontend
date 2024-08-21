// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                getValueForScreenType(
                  context: context,
                  mobile: 12,
                  desktop: 64,
                ),
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/logo/logo_siberat.svg",
                    height: 93,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Text(
                  "Wilujeng Sumping di SIBERAT JAWARA",
                  style: myTextTheme.titleMedium,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  "Sistem KSU BUDIDAYA Jawa Barat",
                  style: myTextTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                BaseForm(
                  label: "Username",
                  autoFocus: true,
                  onChanged: ((value) {
                    controller.username = value;
                  }),
                  prefixIcon: "assets/icons/input/akun.svg",
                  hintText: "Masukkan username",
                  validator:
                      Validatorless.required("Username tidak boleh kosong"),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "Kata sandi",
                  onChanged: ((value) {
                    controller.password = value;
                  }),
                  prefixIcon: "assets/icons/input/kunci_non_aktif.svg",
                  obsecure: true,
                  hintText: "Masukkan kata sandi",
                  onEditComplete: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.doLogin();
                    }
                  },
                  validator:
                      Validatorless.required("Kata sandi tidak boleh kosong"),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                PrimaryButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.doLogin();
                    }
                  },
                  text: "Masuk",
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
