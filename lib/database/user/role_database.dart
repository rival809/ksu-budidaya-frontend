import 'package:ksu_budidaya/core.dart';

class RoleDatabase {
  static DataListRole dataListRole = DataListRole();

  static load() async {
    dataListRole = mainStorage.get("dataListRole") ?? DataListRole();
  }

  static save(DataListRole dataListRole) async {
    mainStorage.put("dataListRole", dataListRole);
    RoleDatabase.dataListRole = dataListRole;
  }
}
