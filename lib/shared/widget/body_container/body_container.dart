import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:ksu_budidaya/core.dart';

class BodyContainer extends StatefulWidget {
  final Widget contentBody;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionLocation;

  const BodyContainer({
    Key? key,
    required this.contentBody,
    this.floatingActionButton,
    this.floatingActionLocation,
  }) : super(key: key);

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (drawerProvider.isDrawerOpen) {
        sliderDrawerKey.currentState!.openSlider();
      }
    });

    final GoRouter router = GoRouter.of(context);
    final String currentRoute = router.routerDelegate.currentConfiguration.uri.toString();

    bool isParentSelected(String parentRoute, List<String> childRoutes) {
      return currentRoute == parentRoute ||
          childRoutes.any((route) => currentRoute.startsWith(route));
    }

    DataLogin dataLogin = UserDatabase.userDatabase.data ?? DataLogin();

    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionLocation,
      body: SafeArea(
        child: SliderDrawer(
          animationDuration: 0,
          key: sliderDrawerKey,
          isDraggable: false,
          appBar: SliderAppBar(
            appBarPadding: EdgeInsets.zero,
            appBarColor: neutralWhite,
            drawerIcon: InkWell(
              onTap: () {
                sliderDrawerKey.currentState!.isDrawerOpen
                    ? drawerProvider.toggleDrawer(false)
                    : drawerProvider.toggleDrawer(true);

                sliderDrawerKey.currentState!.openOrClose();
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 24.0,
                  ),
                  SvgPicture.asset(
                    drawerProvider.isDrawerOpen ? iconMenuOpen : iconMenu,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Menu",
                      style: myTextTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            title: const Text(""),
            trailing: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        trimString(UserDatabase.userDatabase.data?.userData?.name),
                        style: myTextTheme.titleSmall,
                      ),
                      Text(
                        trimString(UserDatabase.userDatabase.data?.roleData?.roleName),
                        style: bodyXSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  drawerProvider.isDrawerOpen
                      ? Container(
                          width: 265,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          slider: Container(
            decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(
                color: blueGray50,
              )),
              color: Colors.white,
            ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        children: [
                          if (kIsWeb)
                            DrawerMenu(
                              title: "Dashboard",
                              isSelected: currentRoute == "/",
                              onTap: () {
                                router.pushReplacement("/");
                              },
                            ),
                          if (kIsWeb)
                            if (dataLogin.roleData?.stsSupplier == true ||
                                dataLogin.roleData?.stsDivisi == true ||
                                dataLogin.roleData?.stsProduk == true)
                              DrawerMenu(
                                title: "Database",
                                isSelected: isParentSelected(
                                  "/database",
                                  [
                                    "/database/supplier",
                                    "/database/divisi",
                                    "/database/produk",
                                  ],
                                ),
                                onTap: () {},
                                children: [
                                  if (dataLogin.roleData?.stsSupplier == true)
                                    DrawerMenu(
                                      title: "Supplier",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/database/supplier",
                                      onTap: () {
                                        router.go(
                                          "/database/supplier",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsDivisi == true)
                                    DrawerMenu(
                                      title: "Divisi",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/database/divisi",
                                      onTap: () {
                                        router.go(
                                          "/database/divisi",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsProduk == true)
                                    DrawerMenu(
                                      title: "Produk",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/database/produk",
                                      onTap: () {
                                        router.go(
                                          "/database/produk",
                                        );
                                      },
                                    ),
                                ],
                              ),
                          if (kIsWeb)
                            if (dataLogin.roleData?.stsPembelian == true ||
                                dataLogin.roleData?.stsPenjualan == true ||
                                dataLogin.roleData?.stsRetur == true ||
                                dataLogin.roleData?.stsPembayaranHutang == true ||
                                dataLogin.roleData?.stsAwalAkhirHari == true)
                              DrawerMenu(
                                title: "Transaksi",
                                isSelected: isParentSelected(
                                  "/transaksi",
                                  [
                                    "/transaksi/pembelian",
                                    "/transaksi/penjualan",
                                    "/transaksi/retur",
                                    "/transaksi/bayar-hutang-anggota",
                                    "/transaksi/bayar-hutang-dagang",
                                    "/transaksi/tutup-kasir",
                                  ],
                                ),
                                onTap: () {},
                                children: [
                                  if (dataLogin.roleData?.stsPembelian == true)
                                    DrawerMenu(
                                      title: "Pembelian",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/transaksi/pembelian",
                                      onTap: () {
                                        router.go(
                                          "/transaksi/pembelian",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsPenjualan == true)
                                    DrawerMenu(
                                      title: "Penjualan",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/transaksi/penjualan",
                                      onTap: () {
                                        drawerProvider.toggleDrawer(false);

                                        sliderDrawerKey.currentState!.closeSlider();
                                        router.go(
                                          "/transaksi/penjualan",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsRetur == true)
                                    DrawerMenu(
                                      title: "Retur",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/transaksi/retur",
                                      onTap: () {
                                        router.go(
                                          "/transaksi/retur",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsPembayaranHutang == true)
                                    DrawerMenu(
                                      title: "Bayar Hutang Anggota",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/transaksi/bayar-hutang-anggota",
                                      onTap: () {
                                        router.go(
                                          "/transaksi/bayar-hutang-anggota",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsPembayaranHutang == true)
                                    DrawerMenu(
                                      title: "Bayar Hutang Dagang",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/transaksi/bayar-hutang-dagang",
                                      onTap: () {
                                        router.go(
                                          "/transaksi/bayar-hutang-dagang",
                                        );
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsAwalAkhirHari == true)
                                    DrawerMenu(
                                      title: "Tutup Kasir",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/transaksi/tutup-kasir",
                                      onTap: () {
                                        router.go(
                                          "/transaksi/tutup-kasir",
                                        );
                                      },
                                    ),
                                ],
                              ),
                          if (kIsWeb)
                            if (dataLogin.roleData?.stsCashInCashOut == true)
                              DrawerMenu(
                                title: "Cash",
                                isSelected: isParentSelected(
                                  "/cash",
                                  [
                                    "/cash/cash-in-cash-out",
                                  ],
                                ),
                                onTap: () {},
                                children: [
                                  if (dataLogin.roleData?.stsCashInCashOut == true)
                                    DrawerMenu(
                                      title: "Cash In dan Cash Out",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/cash/cash-in-cash-out",
                                      onTap: () {
                                        router.go(
                                          "/cash/cash-in-cash-out",
                                        );
                                      },
                                    ),
                                ],
                              ),
                          if (kIsWeb)
                            DrawerMenu(
                              title: "Laporan",
                              isSelected: currentRoute == "/laporan",
                              onTap: () {
                                router.go("/laporan");
                              },
                            ),
                          if (dataLogin.roleData?.stsStockOpname == true)
                            DrawerMenu(
                              title: "Stock Opname",
                              isSelected: isParentSelected(
                                "/stock-opname",
                                [
                                  // "/user-management/roles",
                                  "/stock-opname/mobile",
                                  "/stock-opname/riwayat",
                                ],
                              ),
                              onTap: () {},
                              children: [
                                // DrawerMenu(
                                //   title: "Stocktake Harian",
                                //   isSubMenu: true,
                                //   isSelected:
                                //       currentRoute == "/stock-opname/stocktake-harian",
                                //   onTap: () {
                                //     // router.go("/stock-opname/cetak-harian");
                                //   },
                                // ),
                                if (dataLogin.roleData?.stsStockOpname == true)
                                  DrawerMenu(
                                    title: "Stock Opname",
                                    isSubMenu: true,
                                    isSelected: currentRoute == "/stock-opname/mobile",
                                    onTap: () {
                                      router.go("/stock-opname/mobile");
                                    },
                                  ),
                                if (dataLogin.roleData?.stsStockOpname == true)
                                  DrawerMenu(
                                    title: "Riwayat Stock Opname",
                                    isSubMenu: true,
                                    isSelected: currentRoute == "/stock-opname/riwayat",
                                    onTap: () {
                                      router.go("/stock-opname/riwayat");
                                    },
                                  ),
                              ],
                            ),
                          if (kIsWeb)
                            if (dataLogin.roleData?.stsAnggota == true)
                              DrawerMenu(
                                title: "Koperasi",
                                isSelected: isParentSelected(
                                  "/koperasi",
                                  [
                                    "/koperasi/anggota",
                                    "/koperasi/anggota/pembayaran-hutang",
                                  ],
                                ),
                                onTap: () {},
                                children: [
                                  if (dataLogin.roleData?.stsAnggota == true)
                                    DrawerMenu(
                                      title: "Anggota",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/koperasi/anggota",
                                      onTap: () {
                                        router.go("/koperasi/anggota");
                                      },
                                    ),
                                  // if (dataLogin.roleData?.stsPembayaranHutang == true)
                                  //   DrawerMenu(
                                  //     title: "Pembayaran Hutang",
                                  //     isSubMenu: true,
                                  //     isSelected: currentRoute.contains(
                                  //         "/koperasi/anggota/pembayaran-hutang"),
                                  //     onTap: () {
                                  //       // router.go("/koperasi/pembayaran-hutang");
                                  //     },
                                  //   ),
                                  // DrawerMenu(
                                  //   title: "Stock Opname",
                                  //   isSubMenu: true,
                                  //   isSelected: currentRoute == "/stock-opname/mobile",
                                  //   onTap: () {
                                  //     router.go("/stock-opname/mobile");
                                  //   },
                                  // ),
                                ],
                              ),
                          if (dataLogin.roleData?.stsCetakLabel == true)
                            DrawerMenu(
                              title: "Lain - lain",
                              isSelected: isParentSelected(
                                "/lain-lain",
                                [
                                  "/lain-lain/cetak-label",
                                  // "/user-management/role",
                                ],
                              ),
                              onTap: () {},
                              children: [
                                if (dataLogin.roleData?.stsCetakLabel == true)
                                  DrawerMenu(
                                    title: "Cetak Label",
                                    isSubMenu: true,
                                    isSelected: currentRoute == "/lain-lain/cetak-label",
                                    onTap: () {
                                      router.go("/lain-lain/cetak-label");
                                    },
                                  ),
                                // if (dataLogin.roleData?.stsRole == true)
                                //   DrawerMenu(
                                //     title: "Role",
                                //     isSubMenu: true,
                                //     isSelected:
                                //         currentRoute == "/user-management/role",
                                //     onTap: () {
                                //       router.go("/user-management/role");
                                //     },
                                // ),
                              ],
                            ),
                          if (kIsWeb)
                            if (dataLogin.roleData?.stsUser == true)
                              DrawerMenu(
                                title: "User Management",
                                isSelected: isParentSelected(
                                  "/user-management",
                                  [
                                    "/user-management/user",
                                    "/user-management/role",
                                  ],
                                ),
                                onTap: () {},
                                children: [
                                  if (dataLogin.roleData?.stsUser == true)
                                    DrawerMenu(
                                      title: "User",
                                      isSubMenu: true,
                                      isSelected: currentRoute == "/user-management/user",
                                      onTap: () {
                                        router.go("/user-management/user");
                                      },
                                    ),
                                  if (dataLogin.roleData?.stsRole == true)
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
                              content: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: blueGray50,
                      ),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
                  child: widget.contentBody,
                ),
              ),
              drawerProvider.isDrawerOpen
                  ? Container(
                      width: 265,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
