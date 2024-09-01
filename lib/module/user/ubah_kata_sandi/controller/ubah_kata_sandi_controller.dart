import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class UbahKataSandiController extends State<UbahKataSandiView> {
  static late UbahKataSandiController instance;
  late UbahKataSandiView view;

  GlobalKey<FormState> keyInputPassword = GlobalKey<FormState>();

  bool isOldPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool statusModal = false;

  TextEditingController passwordValidasiController = TextEditingController();
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordBaruController = TextEditingController();
  TextEditingController konfirmasiPasswordBaruController =
      TextEditingController();

  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?).{6,}$');

  doUpdateUser() async {
    if (await checkInternetConnectivity()) {
      try {
        Map<String, dynamic> payload = {};
        Map<String, dynamic> dataCrud = {};
        Map<String, dynamic> dataEdit = {};

        // dataEdit["password"] = trimString(passwordBaruController.text);
        // dataCrud["id"] = trimString(UserDatabase.loginResult.data?.id);
        // dataCrud["data_edit"] = dataEdit;

        // update();

        // payload = {
        //   "id_user": trimString(UserDatabase.loginResult.data?.id),
        //   "method": "E",
        //   "data_crud": dataCrud,
        // };

        // UpdateUserResult result = await ApiService.getUpdateUser(
        //   data: payload,
        // ).timeout(const Duration(seconds: 30));

        // showBaseDialog(
        //   title: "Perubahan Kata Sandi Berhasil",
        //   message:
        //       "Perubahan kata sandi berhasil, silahkan masuk kembali menggunakan kata sandi baru Anda.",
        //   context: context,
        // );

        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);

        doLogout();

        update();
      } catch (e) {
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
