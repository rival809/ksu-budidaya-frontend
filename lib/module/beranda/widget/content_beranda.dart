// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContentBeranda extends StatefulWidget {
  final BerandaController controller;
  const ContentBeranda({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContentBeranda> createState() => _ContentBerandaState();
}

class _ContentBerandaState extends State<ContentBeranda> {
  @override
  Widget build(BuildContext context) {
    BerandaController controller = widget.controller;
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: gray300,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const HeaderCard(
                  pathIcon: "assets/icons/layanan/digger.svg",
                  title: "Layanan KSU BUDIDAYA",
                ),
                const SizedBox(
                  height: 12.0,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: MenuCard(
                    title: "Daftar Ulang Potensi Baru",
                    onTap: () {
                      router.go(
                        "/pendaftaran",
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: MenuCard(
                    title: "Kirim Ulang E-SKPD",
                    onTap: () {
                      router.go("/kirim-ulang-eskpd");
                    },
                  ),
                ),
                PrimaryButton(
                  onPressed: () {},
                  text: "Button",
                  pathIcon: ,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SecondaryButton(
                  onPressed: () {},
                  text: "Button",
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TertiaryButton(
                  onPressed: () {},
                  text: "Button",
                ),
                const SizedBox(
                  height: 16.0,
                ),
                DangerButton(
                  onPressed: () {},
                  text: "Button",
                ),
                // trimString(dataPermission?.stsKirimU lgSkkp) == "1"
                //     ? Padding(
                //         padding: const EdgeInsets.only(bottom: 8.0),
                //         child: MenuCard(
                //           title: "Cek Status Bayar",
                //           onTap: () {
                //             router.go("/cek-status-bayar");
                //           },
                //         ),
                //       )
                //     : const SizedBox(),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
