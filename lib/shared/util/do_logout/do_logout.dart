import 'package:ksu_budidaya/core.dart';

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
  router.go("/");
}
