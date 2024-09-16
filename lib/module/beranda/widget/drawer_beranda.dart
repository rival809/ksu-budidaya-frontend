// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DrawerBeranda extends StatefulWidget {
  final bool isBeranda;

  const DrawerBeranda({
    Key? key,
    this.isBeranda = false,
  }) : super(key: key);

  @override
  State<DrawerBeranda> createState() => _DrawerBerandaState();
}

class _DrawerBerandaState extends State<DrawerBeranda> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.isBeranda
          ? const BorderRadius.horizontal(
              right: Radius.circular(
                24.0,
              ),
            )
          : const BorderRadius.horizontal(
              left: Radius.circular(
                24.0,
              ),
            ),
      child: Drawer(
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
            ),
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
                            "assets/images/illustration/profile_picture.png",
                            width: 45,
                            height: 45,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trimStringStrip(
                                      "UserDatabase.loginResult.data?.surName"),
                                  style: myTextTheme.labelLarge?.copyWith(
                                    color: blueGray700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  trimStringStrip(
                                      "UserDatabase.loginResult.data?.username"),
                                  style: myTextTheme.bodySmall?.copyWith(
                                    color: blueGray400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    controller: ScrollController(),
                    thumbVisibility: true,
                    trackVisibility: true,
                    interactive: true,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                  ),
                  child: Column(
                    children: [
                      const Divider(),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        minLeadingWidth: 0,
                        leading: SvgPicture.asset(
                          "assets/icons/misc/shield_password.svg",
                        ),
                        title: Text(
                          "Ubah Kata Sandi",
                          style: myTextTheme.labelLarge?.copyWith(
                            color: gray800,
                          ),
                        ),
                        onTap: () {
                          router.go("/ubah-kata-sandi");
                        },
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        minLeadingWidth: 0,
                        leading: SvgPicture.asset(
                          "assets/icons/misc/logout.svg",
                          colorFilter: colorFilter(color: red600),
                        ),
                        title: Text(
                          "Keluar",
                          style: myTextTheme.bodyMedium?.copyWith(
                            color: red500,
                          ),
                        ),
                        onTap: () {
                          // showConfirmationDialogNegative(
                          //   title: "Keluar dari akun",
                          //   subtitle:
                          //       "Apakah Anda yakin untuk keluar dari akun ini?",
                          //   onPressedSecondaryButton: () {
                          //     router.pop();
                          //   },
                          //   secondaryButtonText: "Kembali",
                          //   onPressedPrimaryButton: () {
                          //     doLogout();
                          //   },
                          //   primaryButtonText: "Ya, Saya yakin",
                          //   context: context,
                          // );
                        },
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
