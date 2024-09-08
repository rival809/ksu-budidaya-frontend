import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter.of(context);
    final String currentRoute =
        router.routerDelegate.currentConfiguration.uri.toString();

    bool isParentSelected(String parentRoute, List<String> childRoutes) {
      return currentRoute == parentRoute ||
          childRoutes.any((route) => currentRoute.startsWith(route));
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    DrawerMenu(
                      title: "Dashboard",
                      isSelected: currentRoute == "/",
                      onTap: () {
                        router.pushReplacement("/");
                      },
                    ),
                    DrawerMenu(
                      title: "Stock Opname",
                      isSelected: isParentSelected(
                        "/stock-opname",
                        [
                          "/user-management/roles",
                          "/stock-opname/mobile",
                        ],
                      ),
                      onTap: () {
                        // Route navigation logic here
                      },
                      children: [
                        DrawerMenu(
                          title: "Cetak Harian",
                          isSubMenu: true,
                          isSelected:
                              currentRoute == "/stock-opname/cetak-harian",
                          onTap: () {
                            // router.go("/stock-opname/cetak-harian");
                          },
                        ),
                        DrawerMenu(
                          title: "Stocktake",
                          isSubMenu: true,
                          isSelected: currentRoute == "/stock-opname/mobile",
                          onTap: () {
                            router.go("/stock-opname/mobile");
                          },
                        ),
                      ],
                    ),
                    DrawerMenu(
                      title: "User Management",
                      isSelected: isParentSelected(
                        "/user-management",
                        [
                          "/user-management/user",
                          "/user-management/role",
                        ],
                      ),
                      onTap: () {
                        // Route navigation logic here
                      },
                      children: [
                        DrawerMenu(
                          title: "User",
                          isSubMenu: true,
                          isSelected: currentRoute == "/user-management/user",
                          onTap: () {
                            // router.go("/user-management/user");
                          },
                        ),
                        DrawerMenu(
                          title: "Role",
                          isSubMenu: true,
                          isSelected: currentRoute == "/user-management/role",
                          onTap: () {
                            router.go("/user-management/role");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    minLeadingWidth: 0,
                    title: Text(
                      "Keluar Akun",
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
                                const SizedBox(height: 32),
                                Text(
                                  "Apakah Anda yakin untuk keluar dari akun ini?",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray900,
                                  ),
                                ),
                                const SizedBox(height: 32),
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
                                    const SizedBox(width: 16),
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
