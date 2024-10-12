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

  String monthNow = DateTime.now().month.toString();

  String? selectedMonth;

  List<String> month = const [
    "1 - Januari",
    "2 - Februari",
    "3 - Maret",
    "4 - April",
    "5 - Mei",
    "6 - Juni",
    "7 - Juli",
    "8 - Agustus",
    "9 - September",
    "10 - Oktober",
    "11 - November",
    "12 - Desember",
  ];

  String getNamaMonth(String angkaBulan) {
    for (var i = 0; i < month.length; i++) {
      if (splitString(month[i], true) == angkaBulan) {
        return month[i];
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
        "month": splitString(selectedMonth, true),
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
    selectedMonth = getNamaMonth(monthNow);
    getReferences();
    postIncomeDashboard();
    postIncomeMonthly();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
