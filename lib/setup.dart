import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ksu_budidaya/core.dart';

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    var path = await getTemporaryDirectory();
    Hive.init(path.path);
  }

  if (!Hive.isAdapterRegistered(1)) {
    //0
    Hive.registerAdapter(LoginResultAdapter());
    Hive.registerAdapter(DataLoginAdapter());
    Hive.registerAdapter(UserDataLoginAdapter());
    Hive.registerAdapter(RoleDataLoginAdapter());
    Hive.registerAdapter(DataListRoleAdapter());
    Hive.registerAdapter(DataRolesAdapter());
    Hive.registerAdapter(PagingAdapter());
    Hive.registerAdapter(DataSupplierAdapter());
    Hive.registerAdapter(DataDetailSupplierAdapter());
    Hive.registerAdapter(DataDivisiAdapter());
    Hive.registerAdapter(DataDetailDivisiAdapter());
    //11
    Hive.registerAdapter(RefCashResultAdapter());
    Hive.registerAdapter(DataRefCashAdapter());
    Hive.registerAdapter(AnggotaResultAdapter());
    Hive.registerAdapter(DataAnggotaAdapter());
    Hive.registerAdapter(DataDetailAnggotaAdapter());
    Hive.registerAdapter(ProductResultAdapter());
    Hive.registerAdapter(DataProductAdapter());
    Hive.registerAdapter(DataDetailProductAdapter());
    Hive.registerAdapter(TotalKeseluruhanAdapter());
    Hive.registerAdapter(DataListUserAdapter());
    //21
    Hive.registerAdapter(DataUsersAdapter());
  }

  mainStorage = await Hive.openBox('mainStorage');

  await UserDatabase.load();
  await RoleDatabase.load();
  await SupplierDatabase.load();
  await DivisiDatabase.load();
  await AnggotaDatabase.load();
  await RefCashDatabase.load();
  await ProductDatabase.load();

  AppSession.token = mainStorage.get("token") ?? "";
}
