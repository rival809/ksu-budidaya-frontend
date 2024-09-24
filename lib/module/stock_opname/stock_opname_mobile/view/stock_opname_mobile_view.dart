import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';

class StockOpnameMobileView extends StatefulWidget {
  const StockOpnameMobileView({Key? key}) : super(key: key);

  Widget build(context, StockOpnameMobileController controller) {
    controller.view = this;

    return Form(
      key: controller.stockOpnameKey,
      child: BodyContainer(
        floatingActionButton: ScreenTypeLayout.builder(
          mobile: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    text: "Batal",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BasePrimaryButton(
                    text: "Simpan",
                    onPressed: () {
                      if (controller.stockOpnameKey.currentState!.validate()) {
                        controller.postUpdateProduct(
                          trimString(controller.dataResult.data?.idProduct),
                          controller.textStockController.text,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          desktop: (context) => Container(),
        ),
        floatingActionLocation: FloatingActionButtonLocation.centerDocked,
        contentBody: SingleChildScrollView(
          controller: ScrollController(),
          child: ScreenTypeLayout.builder(
            mobile: (BuildContext context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stock Opname",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BaseForm(
                    label: "Kode Produk",
                    textEditingController: controller.textBarcodeController,
                    suffixIcon: iconBarcodeScanner,
                    onTapSuffix: () async {
                      final result = await showDialog<String>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const BarcodeScannerDialog();
                        },
                      );

                      if (result != null) {
                        controller.textBarcodeController.text = result;
                        controller.postDetailProduct(
                          controller.textBarcodeController.text,
                        );

                        controller.update();
                      }
                    },
                    onChanged: (value) {
                      controller.dataResult = DetailProductResult();
                      controller.onBarcodeChanged(value);
                      controller.update();
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BaseForm(
                    label: "Nama Produk",
                    textEditingController: controller.textNamaProdukController,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BaseForm(
                    label: "Stok",
                    textEditingController:
                        controller.textCurrentStockController,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BaseForm(
                    label: "Stock Sebenarnya",
                    textEditingController: controller.textStockController,
                    validator: Validatorless.required("Data Wajib Diisi"),
                    hintText: "Masukkan Stock Sebenarnya",
                    textInputType: TextInputType.number,
                    onChanged: (value) {
                      controller.stockEdit = trimString(value);
                      controller.update();
                    },
                    textInputFormater: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
            desktop: (BuildContext context) => Container(),
          ),
        ),
      ),
    );
  }

  @override
  State<StockOpnameMobileView> createState() => StockOpnameMobileController();
}
