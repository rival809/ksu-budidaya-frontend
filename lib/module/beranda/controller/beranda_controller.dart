import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  Future<dynamic>? dataFuture;

  getReferences() async {
    if (RoleDatabase.dataListRole.dataRoles?.isEmpty ?? true) {
      await GlobalReference().roleReference();
    }
    if (SupplierDatabase.dataSupplier.dataSupplier?.isEmpty ?? true) {
      await GlobalReference().supplierReference();
    }
    if (DivisiDatabase.dataDivisi.dataDivisi?.isEmpty ?? true) {
      await GlobalReference().divisiReference();
    }
    if (AnggotaDatabase.dataAnggota.dataAnggota?.isEmpty ?? true) {
      await GlobalReference().anggotaReference();
    }
    if (RefCashDatabase.refCashResult.data?.isEmpty ?? true) {
      await GlobalReference().cashReference();
    }
  }

  IncomeDashboardResult resultDashboard = IncomeDashboardResult();
  IncomeMonthlyResult resultMonthly = IncomeMonthlyResult();

  int monthNow = DateTime.now().month;

  bool loading = true;
  postIncomeDashboard() async {
    loading = true;
    update();
    try {
      resultDashboard = await ApiService.incomeDashboard()
          .timeout(const Duration(seconds: 30));

      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postIncomeMonthly() async {
    loading = true;
    update();
    try {
      resultMonthly = await ApiService.incomeMonthly(data: {
        "month": monthNow.toString(),
        "year": DateTime.now().year.toString(),
      }).timeout(const Duration(seconds: 30));

      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  PenjualanResult result = PenjualanResult();
  DataPenjualan dataListPenjualan = DataPenjualan();

  List<String> listPenjualanView = [
    "id_penjualan",
    "jumlah",
    "total_nilai_jual",
    "total_nilai_beli",
    "nm_anggota",
    "username",
  ];
  cariDataPenjualan() async {
    try {
      result = PenjualanResult();
      DataMap dataCari = {
        "page": "1",
        "size": "10",
      };

      result = await ApiService.listPenjualan(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      update();
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  initValue() async {
    await getReferences();
    await postIncomeDashboard();
    await postIncomeMonthly();
    dataFuture = cariDataPenjualan();
    update();
  }

  @override
  void initState() {
    instance = this;
    super.initState();
    initValue();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
