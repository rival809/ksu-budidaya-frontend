import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class PdfViewerView extends StatefulWidget {
  const PdfViewerView({
    Key? key,
  }) : super(key: key);

  Widget build(context, PdfViewerController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
          title: const Text("PdfViewer"),
          actions: const [],
        ),
        body: Container()

        // PdfPreview(
        //   build: (format) {
        //     return generateLaporanHarian(
        //       const PdfPageFormat(33 * PdfPageFormat.cm, 21 * PdfPageFormat.cm),
        //       tabelLaporanController,
        //     );
        //     // return generateRekapKasir(
        //     //   const PdfPageFormat(33 * PdfPageFormat.cm, 21 * PdfPageFormat.cm),
        //     // );
        //   },
        //   canChangeOrientation: false,
        //   canChangePageFormat: false,
        //   canDebug: false,
        // ),
        );
  }

  @override
  State<PdfViewerView> createState() => PdfViewerController();
}
