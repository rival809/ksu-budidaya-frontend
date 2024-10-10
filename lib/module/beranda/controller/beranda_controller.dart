import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  int activeTab = 0;
  bool isExpand = true;
  final GlobalKey<SliderDrawerState> sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  Future<dynamic>? dataFuture;

  Widget contentMenuDrawer = const SizedBox();

  final Uri url = Uri.parse('https://sipandu-jawara.bapenda.jabarprov.go.id');
  Future<void> launchInBrowser() async {
    try {
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      showInfoDialog(e.toString(), context);
    }
  }

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

  @override
  void initState() {
    instance = this;
    super.initState();
    getReferences();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
