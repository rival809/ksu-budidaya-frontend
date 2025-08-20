import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/laporan/widget/laporan_penjualan.dart';

class LaporanController extends State<LaporanView> {
  static late LaporanController instance;
  late LaporanView view;

  Future<dynamic>? dataFutureHasilUsaha;
  Future<dynamic>? dataFutureRealisasiPendapatan;
  Future<dynamic>? dataFutureNeracaLajur;
  Future<dynamic>? dataFutureNeraca;
  Future<dynamic>? dataFuturePenjualan;
  int monthNow = DateTime.now().month;
  int idLaporan = 0;
  int yearNow = DateTime.now().year;
  bool hasData = false;
  List<DateTime?> dates = [];

  List<int> yearData = List<int>.generate(
      DateTime.now().year - 2025 + 2, (index) => 2025 + index);

  LaporanHasilUsahaResult resultHasilUsaha = LaporanHasilUsahaResult();
  LaporanRealisasiPendapatanResult resultRealisasiPendapatan =
      LaporanRealisasiPendapatanResult();
  LaporanNeracaLajurModel resultNeracaLajur = LaporanNeracaLajurModel();
  LaporanNeracaModel resultNeraca = LaporanNeracaModel();
  LaporanPenjualanModel resultPenjualan = LaporanPenjualanModel();

  String? getDateByIndex(int i) {
    try {
      return formatSelectedDate(dates[i] ?? DateTime.now());
    } catch (e) {
      log("getDateByIndex: Index $i not exist.");
    }

    return null;
  }

  void setDefaultDates() {
    // final now = DateTime(2025, 2, 2);
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    // 1st bulan ini - kemarin
    if (now.day != 1) {
      final firstDayThisMonth = DateTime(now.year, now.month, 1);
      dates = [firstDayThisMonth, yesterday];
      return;
    }

    // 1st bulan lalu - kemarin
    final firstDayLastMonth = DateTime(now.year, now.month - 1, 1);
    dates = [firstDayLastMonth, yesterday];
  }

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

  cariDataLaporanNeracaLajur() async {
    try {
      resultNeracaLajur = LaporanNeracaLajurModel();

      resultNeracaLajur = await ApiService.laporanNeracaLajur(
        month: monthNow.toString(),
        year: yearNow.toString(),
      ).timeout(const Duration(seconds: 30));

      if (resultNeracaLajur.success == true) {
        hasData = true;
        // update();
      }

      return resultNeracaLajur;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDataLaporanNeraca() async {
    try {
      resultNeraca = LaporanNeracaModel();

      resultNeraca = await ApiService.laporanNeraca(
        month: monthNow.toString(),
        year: yearNow.toString(),
      ).timeout(const Duration(seconds: 30));

      if (resultNeraca.success == true) {
        hasData = true;
        // update();
      }

      return resultNeraca;
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

  String selectedMetodePembayaran = "SEMUA";

  cariDataLaporanPenjualan() async {
    try {
      resultPenjualan = LaporanPenjualanModel();

      String formatDate(DateTime date) =>
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      String startDate = dates[0] != null
          ? formatDate(dates[0]!)
          : formatDate(DateTime(yearNow, monthNow, 1));
      String endDate = dates[1] != null
          ? formatDate(dates[1]!)
          : formatDate(DateTime(yearNow, monthNow, 1));

      String? metodePembayaran;
      if (selectedMetodePembayaran == "SEMUA") {
        metodePembayaran = null;
      } else {
        metodePembayaran = selectedMetodePembayaran;
      }

      resultPenjualan = await ApiService.laporanPenjualan(
        startDate: startDate,
        endDate: endDate,
        metodePembayaran: metodePembayaran,
      ).timeout(const Duration(seconds: 30));

      if (resultPenjualan.success == true) {
        hasData = true;
      }

      return resultPenjualan;
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
      case 3:
        return LaporanNeracaLajur(controller: instance);
      case 4:
        return LaporanNeraca(controller: instance);
      case 5:
        return LaporanPenjualan(controller: instance);
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
      case 3:
        dataFutureNeracaLajur = cariDataLaporanNeracaLajur();
        update();
        break;
      case 4:
        dataFutureNeraca = cariDataLaporanNeraca();
        update();
        break;
      case 5:
        dataFuturePenjualan = cariDataLaporanPenjualan();
        update();
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    instance = this;
    setDefaultDates();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
