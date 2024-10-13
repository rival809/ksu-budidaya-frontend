import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class LaporanController extends State<LaporanView> {
  static late LaporanController instance;
  late LaporanView view;

  Future<dynamic>? dataFutureHasilUsaha;
  int monthNow = DateTime.now().month;
  int idLaporan = 0;
  int yearNow = DateTime.now().year;

  List<int> yearData = List<int>.generate(
      DateTime.now().year - 2023 + 2, (index) => 2023 + index);

  Widget contentLaporan(int idLaporan) {
    switch (idLaporan) {
      case 1:
        return LaporanHasilUsaha(controller: instance);

      default:
        return const ContainerTidakAdaLaporan();
    }
  }

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
