import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameMobileView extends StatefulWidget {
  const StockOpnameMobileView({Key? key}) : super(key: key);

  Widget build(context, StockOpnameMobileController controller) {
    controller.view = this;

    return BodyContainer(
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
                    showDialogBase(
                      content: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              iconStatusCheck,
                              width: 80,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Berhasil",
                              style: myTextTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            BasePrimaryButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: "Oke, saya mengerti",
                            )
                          ],
                        ),
                      ),
                    );
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
                      controller.update();
                    }
                  },
                  onChanged: (value) {
                    print(value);
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const BaseForm(
                  label: "Stok",
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const BaseForm(
                  label: "Stock Sebenarnya",
                ),
              ],
            ),
          ),
          desktop: (BuildContext context) => Container(),
        ),
      ),
    );
  }

  @override
  State<StockOpnameMobileView> createState() => StockOpnameMobileController();
}
