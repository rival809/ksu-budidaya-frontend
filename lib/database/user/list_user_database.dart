import 'package:ksu_budidaya/core.dart';

class ListUserDatabase {
  static DataListUser dataListUser = DataListUser();

  static load() async {
    dataListUser = mainStorage.get("dataListUser") ?? DataListUser();
  }

  static save(DataListUser dataListUser) async {
    mainStorage.put("dataListUser", dataListUser);
    ListUserDatabase.dataListUser = dataListUser;
  }
}
