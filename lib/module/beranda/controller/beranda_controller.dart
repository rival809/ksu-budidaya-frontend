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
    if (await checkInternetConnectivity()) {
      try {} catch (e) {
        if (e.toString().contains("TimeoutException")) {
          showInfoDialog(
              "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
        } else {
          showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
        }
      }
    } else {
      showInfoDialog("Tidak ada koneksi internet!", context);
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
