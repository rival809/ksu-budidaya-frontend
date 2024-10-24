import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class LaporanController extends State<LaporanView> {
  static late LaporanController instance;
  late LaporanView view;

  Future<dynamic>? dataFutureHasilUsaha;
  Future<dynamic>? dataFutureRealisasiPendapatan;
  int monthNow = DateTime.now().month;
  int idLaporan = 0;
  int yearNow = DateTime.now().year;
  bool hasData = false;

  List<int> yearData = List<int>.generate(
      DateTime.now().year - 2023 + 2, (index) => 2023 + index);

  LaporanHasilUsahaResult resultHasilUsaha = LaporanHasilUsahaResult();
  LaporanRealisasiPendapatanResult resultRealisasiPendapatan =
      LaporanRealisasiPendapatanResult();

  cariDataLaporanHasilUsaha() async {
    try {
      resultHasilUsaha = LaporanHasilUsahaResult();

      resultHasilUsaha = await ApiService.laporanHasilUsaha(
        month: monthNow.toString(),
        year: yearNow.toString(),
      ).timeout(const Duration(seconds: 30));

      if (resultHasilUsaha.success == true) {
        hasData = true;
        // update();
      }

      return resultHasilUsaha;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDataLaporanRealisasiPendapatan() async {
    try {
      resultRealisasiPendapatan = LaporanRealisasiPendapatanResult();

      resultRealisasiPendapatan = await ApiService.laporanRealisasiPendapatan(
        year: yearNow.toString(),
      ).timeout(const Duration(seconds: 30));

      if (resultRealisasiPendapatan.success == true) {
        hasData = true;
      }

      return resultRealisasiPendapatan;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  Widget contentLaporan(int idLaporan) {
    switch (idLaporan) {
      case 1:
        return LaporanHasilUsaha(controller: instance);
      case 2:
        return LaporanRealisasiPendapatan(controller: instance);

      default:
        return const ContainerTidakAdaLaporan();
    }
  }

  onSearchLaporan(int idLaporan) {
    switch (idLaporan) {
      case 1:
        dataFutureHasilUsaha = cariDataLaporanHasilUsaha();
        update();
        break;
      case 2:
        dataFutureRealisasiPendapatan = cariDataLaporanRealisasiPendapatan();
        update();
        break;

      default:
        return null;
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
