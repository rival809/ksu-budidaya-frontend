import 'package:flutter/foundation.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:universal_html/html.dart' as html;

doLogout() async {
  showCircleDialogLoading();
  // UserDatabase.save(LoginResult());
  // ReferencesDatabase.saveBbm(BbmResult());
  // ReferencesDatabase.saveJenisKb(JenisKbResult());
  // ReferencesDatabase.saveJenisKepemilikan(JenisKepemilikanResult());
  // ReferencesDatabase.saveKodeBlockir(KodeBlockirResult());
  // ReferencesDatabase.saveKodeMohon(KodeMohonResult());
  // ReferencesDatabase.saveSubjekPajak(SubjekPajakTypeResult());
  // ReferencesDatabase.saveWilPusat(WilPusatResult());
  // ReferencesDatabase.saveWilUppd(WilUppdResult());
  // IpDatabase.save("192.168.99.195", "8080");
  //MAKE ERROR IF ERASER DEVICE DATABASE
  // DeviceDatabase.save("", "");
  AppSession.save("");
  await Future.delayed(const Duration(seconds: 2));
  Get.back();
  if (kIsWeb) {
    html.window.location.replace("/");
  } else {
    Get.to(const LoginView());
  }
}
