import 'package:ksu_budidaya/core.dart';

class UserDatabase {
  static LoginResult userDatabase = LoginResult();

  static load() async {
    userDatabase = mainStorage.get("userDatabase") ?? LoginResult();
  }

  static save(LoginResult userDatabase) async {
    mainStorage.put("userDatabase", userDatabase);
    UserDatabase.userDatabase = userDatabase;
  }
}
