import 'package:ksu_budidaya/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  await initialize();
  usePathUrlStrategy();

  Get.mainTheme.value = getDefaultTheme();

  runMainApp();
}

runMainApp() async {
  return runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Get.mainTheme,
      builder: (context, value, child) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'KSU Budidaya',
          debugShowCheckedModeBanner: false,
          theme: value,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('id', 'ID'),
          ],
        );
      },
    );
  }
}
