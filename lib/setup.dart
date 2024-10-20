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
  }

  mainStorage = await Hive.openBox('mainStorage');

  await UserDatabase.load();
  await RoleDatabase.load();
  await SupplierDatabase.load();
  await DivisiDatabase.load();
  await AnggotaDatabase.load();
  await RefCashDatabase.load();
  // await PembelianDatabase.load();
  // await UserDatabase.load();
  // await PenetapanDatabase.load();
  // await ReferencesDatabase.load();
  // await ProsesPenetapanDatabase.load();
  // await MetodeBayarDatabase.load();
  // await InfoAbDatabase.load();
  // await SubjekPajakDatabase.load();
  // await TambahPotensiDatabase.load();
  // await GetPermissionDatabase.load();
  // await NilaiJualDatabase.load();
  // await ModelAbDatabase.load();
  // await ColumnTableDatabase.load();
  // await DetailControlTableDatabase.load();
  // await EditConfigDatabase.load();
  // await ControlInfoDatabase.load();

  AppSession.token = mainStorage.get("token") ?? "";
}
