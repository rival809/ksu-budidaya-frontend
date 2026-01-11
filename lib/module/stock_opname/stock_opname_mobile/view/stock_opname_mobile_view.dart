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
                  Row(
                    children: [
                      Text(
                        "Mode Pencarian:",
                        style: myTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        controller.useId ? "Kode Produk" : "Nama Produk",
                        style: myTextTheme.bodyMedium?.copyWith(
                          color: controller.useId ? primaryColor : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Switch(
                        activeColor: primaryColor,
                        value: controller.useId,
                        onChanged: (value) {
                          controller.onSwitchChanged(value);
                        },
                      ),
                    ],
                  ),
                  if (controller.useId)
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
                  if (!controller.useId)
                    SearchForm(
                      label: "Nama Produk",
                      enabled: true,
                      suffixIcon: iconSearch,
                      textEditingController: controller.textnamaSearchController,
                      items: (search) => controller.getDetailSuggestions(
                        search,
                        ProductDatabase.productResult.data?.dataProduct,
                      ),
                      itemBuilder: (context, dataPembelian) {
                        return ListTile(
                          title: Text(
                              "${trimString(dataPembelian.idProduct)} - ${trimString(dataPembelian.nmProduct)}"),
                        );
                      },
                      onChanged: (value) {
                        controller.dataResult = DetailProductResult();
                        controller.update();
                      },
                      onEditComplete: () async {
                        var data = ProductDatabase.productResult.data?.dataProduct;
                        for (var i = 0; i < (data?.length ?? 0); i++) {
                          if (trimString(data?[i].idProduct) ==
                                  trimString(controller.textnamaSearchController.text) ||
                              trimString(data?[i].nmProduct) ==
                                  trimString(controller.textnamaSearchController.text)) {
                            controller.postDetailProduct(
                              trimString(data?[i].idProduct),
                            );
                            controller.update();
                            break;
                          }
                        }
                      },
                      onSelected: (data) async {
                        controller.textnamaSearchController.text = trimString(data.nmProduct);
                        controller.postDetailProduct(
                          trimString(data.idProduct),
                        );
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
                    label: "Harga Jual",
                    textEditingController: controller.textHargaJualController,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BaseForm(
                    label: "Harga Beli",
                    textEditingController: controller.textHargaBeliController,
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
                  Row(
                    children: [
                      Text(
                        "Mode Pencarian:",
                        style: myTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text(
                        controller.useId ? "Kode Produk" : "Nama Produk",
                        style: myTextTheme.bodyMedium?.copyWith(
                          color: controller.useId ? primaryColor : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Switch(
                        activeColor: primaryColor,
                        value: controller.useId,
                        onChanged: (value) {
                          controller.onSwitchChanged(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  if (controller.useId)
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
                  if (!controller.useId)
                    SearchForm(
                      label: "Nama Produk",
                      enabled: true,
                      suffixIcon: iconSearch,
                      textEditingController: controller.textnamaSearchController,
                      items: (search) => controller.getDetailSuggestions(
                        search,
                        ProductDatabase.productResult.data?.dataProduct,
                      ),
                      itemBuilder: (context, dataPembelian) {
                        return ListTile(
                          title: Text(
                              "${trimString(dataPembelian.idProduct)} - ${trimString(dataPembelian.nmProduct)}"),
                        );
                      },
                      onChanged: (value) {
                        controller.dataResult = DetailProductResult();
                        controller.update();
                      },
                      onEditComplete: () async {
                        var data = ProductDatabase.productResult.data?.dataProduct;
                        for (var i = 0; i < (data?.length ?? 0); i++) {
                          if (trimString(data?[i].idProduct) ==
                                  trimString(controller.textnamaSearchController.text) ||
                              trimString(data?[i].nmProduct) ==
                                  trimString(controller.textnamaSearchController.text)) {
                            controller.postDetailProduct(
                              trimString(data?[i].idProduct),
                            );
                            controller.update();
                            break;
                          }
                        }
                      },
                      onSelected: (data) async {
                        controller.textnamaSearchController.text = trimString(data.nmProduct);
                        controller.postDetailProduct(
                          trimString(data.idProduct),
                        );
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
                    label: "Harga Jual",
                    textEditingController: controller.textHargaJualController,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BaseForm(
                    label: "Harga Beli",
                    textEditingController: controller.textHargaBeliController,
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
