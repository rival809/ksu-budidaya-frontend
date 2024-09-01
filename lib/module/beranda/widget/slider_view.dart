import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';

class SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo/logo.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      "KSU Budidaya",
                      style: myTextTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 21,
                ),
                child: Column(
                  children: [
                    // DrawerMenu(
                    //   title: "Pengaturan Pencetakan",
                    //   pathIcon:
                    //       "assets/icons/layanan/print_setting.svg",
                    //   onTap: () {
                    //     router.go("/pengaturan-pencetakan");
                    //   },
                    //   isChildren: false,
                    // ),
                    // dataPermission?.stsUserMngmt == "1" ||
                    //         dataPermission?.stsInfoUser == "1"
                    //     ? DrawerMenu(
                    //         title: "User Management",
                    //         pathIcon:
                    //             "assets/icons/layanan/edit_data_wp.svg",
                    //         onTap: () {
                    //           router.go("/user-management");
                    //         },
                    //         isChildren: false,
                    //       )
                    //     : const SizedBox(),

                    // DrawerMenu(
                    //   title: "Tabel Operasional",
                    //   pathIcon:
                    //       "assets/icons/layanan/manajemen_njab.svg",
                    //   onTap: () {
                    //     router.go("/tabel-operasional");
                    //   },
                    //   isChildren: false,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    minLeadingWidth: 0,
                    title: Text(
                      "Keluar",
                      style: myTextTheme.bodyMedium?.copyWith(
                        color: red500,
                      ),
                    ),
                    onTap: () {
                      showDialogBase(
                        context: context,
                        content: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Keluar dari akun",
                                  style: myTextTheme.headlineLarge,
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  "Apakah Anda yakin untuk keluar dari akun ini?",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray900,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: BaseSecondaryButton(
                                        onPressed: () {
                                          router.pop();
                                        },
                                        text: "Kembali",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BaseDangerButton(
                                        onPressed: () {
                                          doLogout();
                                        },
                                        text: "Ya, Saya yakin",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
