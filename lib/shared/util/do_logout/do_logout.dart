import 'package:ksu_budidaya/core.dart';

doLogout() {
  // UserDatabase.save(LoginResult());
  // IpDatabase.save("192.168.99.195", "8080");
  //MAKE ERROR IF ERASER DEVICE DATABASE
  // DeviceDatabase.save("", "");
  AppSession.save("");
  router.pushReplacement("/login");
}
