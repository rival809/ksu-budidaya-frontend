import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/pdf_viewer_view.dart';

class PdfViewerController extends State<PdfViewerView> {
  static late PdfViewerController instance;
  late PdfViewerView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
