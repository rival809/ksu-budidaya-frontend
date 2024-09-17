import 'package:ksu_budidaya/core.dart';
import 'package:universal_html/html.dart' as html;

doLogout() async {
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
  html.window.location.replace("/");
}
