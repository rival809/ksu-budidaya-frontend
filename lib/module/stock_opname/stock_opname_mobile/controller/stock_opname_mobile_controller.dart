import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/model/stock_opname/stock_opname_model.dart';

class StockOpnameMobileController extends State<StockOpnameMobileView> {
  static late StockOpnameMobileController instance;
  late StockOpnameMobileView view;

  bool useId = true;

  TextEditingController textBarcodeController = TextEditingController();
  TextEditingController textnamaSearchController = TextEditingController();
  TextEditingController textNamaProdukController = TextEditingController();
  TextEditingController textCurrentStockController = TextEditingController();
  TextEditingController textStockController = TextEditingController();
  TextEditingController textHargaJualController = TextEditingController();
  TextEditingController textHargaBeliController = TextEditingController();
  String stockEdit = "";
  Timer? _debounce;

  final stockOpnameKey = GlobalKey<FormState>();

  DetailProductResult dataResult = DetailProductResult();

  List<DataDetailProduct> getDetailSuggestions(
      String query, List<DataDetailProduct>? states) {
    List<DataDetailProduct> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere((s) =>
          (trimString(s.idProduct)
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              trimString(s.nmProduct)
                  .toLowerCase()
                  .contains(query.toLowerCase())) &&
          s.statusProduct == true);
    }

    return matches;
  }

  void onBarcodeChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(seconds: 2),
      () {
        if (textBarcodeController.text.isNotEmpty) {
          postDetailProduct(value);
        }
      },
    );
  }

  postDetailProduct(String idProduct) async {
    showCircleDialogLoading();
    try {
      dataResult = DetailProductResult();
      textStockController.clear();
      textNamaProdukController.clear();
      textCurrentStockController.clear();
      textHargaJualController.clear();
      textHargaBeliController.clear();
      stockEdit = "";

      DetailProductResult result = await ApiService.detailProduct(
        data: {"id_product": idProduct},
      ).timeout(const Duration(seconds: 30));
      Navigator.pop(context);

      if (result.success == true) {
        dataResult = result;
        textNamaProdukController.text = trimString(result.data?.nmProduct);
        textCurrentStockController.text =
            trimString(result.data?.jumlah.toString());
        textHargaJualController.text = formatMoney(result.data?.hargaJual);
        textHargaBeliController.text = formatMoney(result.data?.hargaBeli);
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postUpdateProduct(String idProduct, String jumlah) async {
    showCircleDialogLoading();
    try {
      StockOpnameModel result = await ApiService.createStockOpname(
        data: {
          "tg_stocktake":
              "${formatDate(DateTime.now().toString())}, ${formatSelectedTime(DateTime.now())}",
          "id_product": idProduct,
          "nm_product": dataResult.data?.nmProduct,
          "stok_awal": dataResult.data?.jumlah,
          "stok_akhir": jumlah,
          "username": UserDatabase.userDatabase.data?.userData?.username,
          "name": UserDatabase.userDatabase.data?.userData?.name,
        },
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconStatusCheck,
                  height: 80,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Berhasil",
                  style: myTextTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: gray50,
                    border: Border.all(
                      width: 1.0,
                      color: blueGray50,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OneData(
                          title: "Stock Awal",
                          subtitle: trimString(result.data?.stokAwal),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: OneData(
                          title: "Stock Akhir",
                          subtitle: trimString(result.data?.stokAkhir),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: OneData(
                          title: "Selisih",
                          subtitle: trimString(result.data?.selisih),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                BasePrimaryButton(
                  text: "Oke, saya mengerti",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );

        resetData();
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  resetData() {
    textBarcodeController.clear();
    textnamaSearchController.clear();
    textNamaProdukController.clear();
    textCurrentStockController.clear();
    textStockController.clear();
    textHargaJualController.clear();
    textHargaBeliController.clear();
    stockEdit = "";
    dataResult = DetailProductResult();
    update();
  }

  void onSwitchChanged(bool value) {
    useId = value;
    // Reset all data when switching between search modes
    textBarcodeController.clear();
    textnamaSearchController.clear();
    textNamaProdukController.clear();
    textCurrentStockController.clear();
    textStockController.clear();
    textHargaJualController.clear();
    textHargaBeliController.clear();
    stockEdit = "";
    dataResult = DetailProductResult();
    update();
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
