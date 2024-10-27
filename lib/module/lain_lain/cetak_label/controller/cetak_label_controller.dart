import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pdf/widgets.dart' as pw;

class CetakLabelController extends State<CetakLabelView> {
  static late CetakLabelController instance;
  late CetakLabelView view;

  TextEditingController textController = TextEditingController();

  List<DataDetailProduct> getDetailSuggestions(
      String query, List<DataDetailProduct>? states) {
    List<DataDetailProduct> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere((s) =>
          trimString(s.idProduct).toLowerCase().contains(query.toLowerCase()) &&
          s.statusProduct == true);
    }

    return matches;
  }

  List<DataDetailProduct> dataLabel = [];
  File? pdfFile;
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    final ttfBold = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
    final ttfRegular = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");

    final boldFont = pw.Font.ttf(ttfBold);
    final regularFont = pw.Font.ttf(ttfRegular);

    pdf.addPage(
      pw.MultiPage(
        orientation: pw.PageOrientation.portrait,
        margin: const pw.EdgeInsets.all(12),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(dataLabel.length, (index) {
                return pw.Container(
                  width: ((PdfPageFormat.a4.width - 32 - 12) / 2),
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: const PdfColor.fromInt(0xffFFD026),
                    border: pw.Border.all(color: PdfColors.yellow600),
                    borderRadius: pw.BorderRadius.circular(12),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        trimString(dataLabel[index].nmProduct),
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Rp.",
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            formatMoney(dataLabel[index].hargaJual),
                            style: pw.TextStyle(
                              fontSize: 26,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  @override
  void initState() {
    instance = this;
    GlobalReference().productReference();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
