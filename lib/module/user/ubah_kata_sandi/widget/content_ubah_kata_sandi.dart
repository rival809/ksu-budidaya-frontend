import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContentUbahKataSandi extends StatefulWidget {
  final UbahKataSandiController controller;
  const ContentUbahKataSandi({super.key, required this.controller});

  @override
  State<ContentUbahKataSandi> createState() => _ContentUbahKataSandiState();
}

class _ContentUbahKataSandiState extends State<ContentUbahKataSandi> {
  @override
  Widget build(BuildContext context) {
    UbahKataSandiController controller = widget.controller;
    return Form(
      key: widget.controller.keyInputPassword,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    10 -
                    kToolbarHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Buat kata sandi baru",
                      style: myTextTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    BaseForm(
                      onChanged: (value) {},
                      textEditingController: controller.passwordBaruController,
                      label: "Kata sandi baru",
                      hintText: "Masukan kata sandi baru Anda disini",
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required("Tidak Boleh Kosong"),
                          Validatorless.min(6, "Kata Sandi Minimal 6 Karakter"),
                        ],
                      ),
                      suffixIcon: widget.controller.isNewPasswordVisible
                          ? "assets/icons/input/eye_on.svg"
                          : "assets/icons/input/eye_off.svg",
                      onTapSuffix: () {
                        widget.controller.isNewPasswordVisible =
                            !widget.controller.isNewPasswordVisible;
                        widget.controller.update();
                      },
                      obsecure: widget.controller.isNewPasswordVisible,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    BaseForm(
                      onChanged: (value) {},
                      label: "Konfirmasi kata sandi baru",
                      textEditingController:
                          controller.konfirmasiPasswordBaruController,
                      validator: Validatorless.multiple([
                        Validatorless.required("Tidak Boleh Kosong"),
                        Validatorless.min(6, "Kata Sandi Minimal 6 Karakter"),
                        Validatorless.compare(
                          controller.passwordBaruController,
                          "Kata Sandi Baru Tidak Sama",
                        ),
                      ]),
                      hintText: "Konfirmasi kata sandi baru Anda disini",
                      suffixIcon: widget.controller.isConfirmPasswordVisible
                          ? "assets/icons/input/eye_on.svg"
                          : "assets/icons/input/eye_off.svg",
                      onTapSuffix: () {
                        widget.controller.isConfirmPasswordVisible =
                            !widget.controller.isConfirmPasswordVisible;
                        widget.controller.update();
                      },
                      obsecure: widget.controller.isConfirmPasswordVisible,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: blue50,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        border: Border.all(color: blue100),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/info/info.svg"),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Text(
                              "Kata sandi minimal 6 karakter dengan kombinasi huruf kapital dan angka.",
                              style: myTextTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        if (controller.keyInputPassword.currentState!
                            .validate()) {
                          controller.doUpdateUser();
                          controller.update();
                        }
                      },
                      text: "Submit",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
