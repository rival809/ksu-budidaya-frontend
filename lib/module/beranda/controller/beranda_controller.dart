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

  String getNamaMonth(int angkaBulan) {
    var data = Year.fromJson(monthData).months;
    for (var i = 0; i < data.length; i++) {
      if (data[i].id == angkaBulan) {
        return data[i].month;
      }
    }
    return "";
  }

  bool loading = false;
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

  @override
  void initState() {
    instance = this;
    super.initState();
    getReferences();
    postIncomeDashboard();
    postIncomeMonthly();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
