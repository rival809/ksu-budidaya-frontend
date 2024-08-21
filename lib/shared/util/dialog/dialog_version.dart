import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:url_launcher/url_launcher.dart';

Future showInfoVersionDialog() async {
  final Uri url = Uri.parse('http://192.168.99.14/download/SaktiJawaraApp.apk');

  Future<void> launchInBrowser() async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  await showDialog<void>(
    context: globalContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(
          'Tersedia Versi Baru',
          style: myTextTheme.displayMedium?.copyWith(color: green700),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Perbarui aplikasi Sakti Jawara App Anda ",
                    style: myTextTheme.bodyMedium?.copyWith(
                      color: gray800,
                      height: 1.25,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sekarang ",
                        style: myTextTheme.headlineSmall?.copyWith(
                          color: gray800,
                          height: 1.25,
                        ),
                      ),
                      TextSpan(
                        text: 'untuk mendapatkan pengalaman yang lebih baik.',
                        style: myTextTheme.bodyMedium?.copyWith(
                          color: gray800,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: green600,
              ),
              onPressed: () {
                launchInBrowser();
              },
              child: const Text("Perbarui Sekarang"),
            ),
          ),
        ],
      );
    },
  );
}
