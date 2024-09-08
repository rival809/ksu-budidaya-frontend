import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

final GoRouter router = GoRouter(
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
          return const SelectionArea(
            child: BerandaView(),
          );
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
