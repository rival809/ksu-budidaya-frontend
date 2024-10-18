import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

final GoRouter router = GoRouter(
  navigatorKey: Get.navigatorKey,
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) {
        ////////USER MANAGEMENT//////////
        // if (state.fullPath!.contains("user-management")) {
        // if (GetPermissionDatabase.getPermissionResult.data?.stsUserMngmt ==
        //         "1" ||
        //     GetPermissionDatabase.getPermissionResult.data?.stsInfoUser ==
        //         "1") {
        //   return state.uri.toString();
        // }
        // return "/beranda";
        // }

        return state.uri.toString();
      },
      builder: (BuildContext context, GoRouterState state) {
        if (AppSession.token.isEmpty) {
          return const SelectionArea(
            child: LoginView(),
          );
        } else {
          if (kIsWeb) {
            return const SelectionArea(
              child: BerandaView(),
            );
          } else {
            return const SelectionArea(
              child: StockOpnameMobileView(),
            );
          }
        }
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          redirect: (context, state) {
            if (AppSession.token.isNotEmpty) {
              return "/";
            }
            return null;
          },
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: LoginView(),
            );
          },
        ),
        GoRoute(
          path: 'beranda',
          builder: (BuildContext context, GoRouterState state) {
            if (kIsWeb) {
              return const SelectionArea(
                child: BerandaView(),
              );
            } else {
              return const SelectionArea(
                child: StockOpnameMobileView(),
              );
            }
          },
        ),
        GoRoute(
          path: 'ubah-kata-sandi',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: UbahKataSandiView(),
            );
          },
        ),
        GoRoute(
          path: 'stock-opname/mobile',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: StockOpnameMobileView(),
            );
          },
        ),
        GoRoute(
          path: 'user-management/role',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: ManajemenRoleView(),
            );
          },
        ),
        GoRoute(
          path: 'user-management/user',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: ManajemenUserView(),
            );
          },
        ),
        GoRoute(
          path: 'database/supplier',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: SupplierView(),
            );
          },
        ),
        GoRoute(
          path: 'database/divisi',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: DivisiView(),
            );
          },
        ),
        GoRoute(
          path: 'database/produk',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: ProdukView(),
            );
          },
        ),
        GoRoute(
          path: 'cash/cash-in-cash-out',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: CashInCashOutView(),
            );
          },
        ),
        GoRoute(
          path: 'koperasi/anggota',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: AnggotaView(),
            );
          },
        ),
        GoRoute(
          path: 'transaksi/pembelian',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: PembelianView(),
            );
          },
        ),
        GoRoute(
          path: 'transaksi/penjualan',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: PenjualanView(),
            );
          },
        ),
        GoRoute(
          path: 'transaksi/retur',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: ReturView(),
            );
          },
        ),
        GoRoute(
          path: 'laporan',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionArea(
              child: LaporanView(),
            );
          },
        ),

        // GoRoute(
        //   path: 'pdf-viewer',
        //   builder: (BuildContext context, GoRouterState state) {
        //     final id = trimString(state.uri.queryParameters['id']);

        //     return const SelectionArea(
        //       child: PdfViewerView(),
        //     );
        //   },
        // ),
      ],
    ),
  ],
);
