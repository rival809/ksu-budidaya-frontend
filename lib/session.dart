import 'package:ksu_budidaya/core.dart';

class AppSession {
  static String token = "";

  static load() async {
    token = mainStorage.get("token");
  }

  static save(String token) async {
    mainStorage.put("token", token);
    AppSession.token = token;
  }
}
