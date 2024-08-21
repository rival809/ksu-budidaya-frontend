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

  if (!Hive.isAdapterRegistered(1)) {}

  mainStorage = await Hive.openBox('mainStorage');

  // await PathDatabase.load();
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
