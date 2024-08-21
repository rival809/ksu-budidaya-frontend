import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  String username = "";
  String password = "";
  final formKey = GlobalKey<FormState>();

  doLogin() async {
    if (await checkInternetConnectivity()) {
      try {
        showCircleDialogLoading(context);

        // LoginResult result = await ApiService.login(
        //   username: username,
        //   password: password,
        // ).timeout(const Duration(seconds: 30));

        // router.pop();

        // AppSession.save(result.data?.token ?? "");
        // UserDatabase.save(result);

        // GetPermissionResult getPermissionResult =
        //     await ApiService.getPermission()
        //         .timeout(const Duration(seconds: 30));

        // GetPermissionDatabase.save(getPermissionResult);

        router.go("/beranda");
      } catch (e) {
        router.pop();

        if (e.toString().contains("TimeoutException")) {
          showInfoDialog(
              "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
        } else {
          showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
        }
      }
    } else {
      showInfoDialog("Tidak ada koneksi internet!", context);
    }
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
