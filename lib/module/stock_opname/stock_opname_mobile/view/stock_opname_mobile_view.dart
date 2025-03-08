import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameMobileView extends StatefulWidget {
  final bool? isFromHistory;
  const StockOpnameMobileView({
    Key? key,
    this.isFromHistory,
  }) : super(key: key);

  Widget build(context, StockOpnameMobileController controller) {
    controller.view = this;
    final drawerProvider = Provider.of<DrawerProvider>(context);

    return Form(
      key: controller.stockOpnameKey,
      child: BodyContainer(
        floatingActionButton: drawerProvider.isDrawerOpen
            ? kIsWeb
                ? ScreenTypeLayout.builder(
                    mobile: (context) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BaseSecondaryButton(
                              text: "Reset",
                              onPressed: () {
                                controller.resetData();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: BasePrimaryButton(
                              text: "Simpan",
                              onPressed: (controller.dataResult.data?.idProduct?.isEmpty ?? true)
                                  ? null
                                  : () {
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
                    desktop: (context) => Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: BaseSecondaryButton(
                              text: "Reset",
                              onPressed: () {
                                controller.resetData();
                              },
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
                  )
                : null
            : ScreenTypeLayout.builder(
                mobile: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: BaseSecondaryButton(
                          text: "Reset",
                          onPressed: () {
                            controller.resetData();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: BasePrimaryButton(
                          text: "Simpan",
                          onPressed: (controller.dataResult.data?.idProduct?.isEmpty ?? true)
                              ? null
                              : () {
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
                desktop: (context) => Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: BaseSecondaryButton(
                          text: "Reset",
                          onPressed: () {
                            controller.resetData();
                          },
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
                  Row(
                    children: [
                      if (isFromHistory == true)
                        BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      if (isFromHistory == true)
                        const SizedBox(
                          width: 16.0,
                        ),
                      Text(
                        "Stock Opname",
                        style: myTextTheme.headlineLarge,
                      ),
                    ],
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
                    textEditingController: controller.textCurrentStockController,
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
            desktop: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isFromHistory == true)
                        BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      if (isFromHistory == true)
                        const SizedBox(
                          width: 16.0,
                        ),
                      Text(
                        "Stock Opname",
                        style: myTextTheme.headlineLarge,
                      ),
                    ],
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
                    textEditingController: controller.textCurrentStockController,
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
          ),
        ),
      ),
    );
  }

  @override
  State<StockOpnameMobileView> createState() => StockOpnameMobileController();
}
