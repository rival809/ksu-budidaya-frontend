import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:universal_html/html.dart' as html;

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  String username = "";
  String password = "";
  bool obsecure = true;
  final formKey = GlobalKey<FormState>();

  doLogin() async {
    try {
      showCircleDialogLoading();

      LoginResult result = await ApiService.login(
        username: username,
        password: password,
      ).timeout(const Duration(seconds: 30));

      await AppSession.save(result.data?.userData?.token ?? "");
      await UserDatabase.save(result);

      ApiService.options.headers?['Authorization'] = "Bearer ${AppSession.token}";

      await Future.delayed(const Duration(seconds: 1));
      Get.back();
      if (kIsWeb) {
        html.window.location.reload();
      } else {
        router.go("/stock-opname/harian");
        update();
      }
    } catch (e) {
      Get.back();

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
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
