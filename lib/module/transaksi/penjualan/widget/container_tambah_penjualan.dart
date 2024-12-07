// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';

class ContainerTambahPenjualan extends StatefulWidget {
  final PenjualanController controller;

  const ContainerTambahPenjualan({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerTambahPenjualan> createState() =>
      _ContainerTambahPenjualanState();
}

class _ContainerTambahPenjualanState extends State<ContainerTambahPenjualan> {
  @override
  void initState() {
    super.initState();
    widget.controller.focusNodeInputPenjualan.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 105,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.isList = true;
                    controller.isDetail = false;
                    controller.dataPenjualan = CreatePenjualanModel();
                    controller.dataFuture = controller.cariDataPenjualan();
                    controller.update();
                    update();
                  },
                  child: SvgPicture.asset(
                    iconChevronLeft,
                    height: 24,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  controller.isDetail ? "Detail Penjualan" : "Tambah Penjualan",
                  style: myTextTheme.headlineLarge,
                ),
              ],
            ),
            if (!controller.isDetail)
              const SizedBox(
                height: 16.0,
              ),
            if (!controller.isDetail)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    child: SearchForm(
                      label: "ID Product",
                      enabled: true,
                      focusNode: controller.focusNodeInputPenjualan,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BasePrimaryButton(
                          onPressed: () {
                            controller.postDetailProduct(
                                controller.cariProdukController.text);
                            controller.update();
                          },
                          text: "Cari",
                          suffixIcon: iconSearch,
                          isDense: true,
                        ),
                      ),
                      textEditingController: controller.cariProdukController,
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
                        controller.onProdctSearch(value);
                        controller.update();
                      },
                      onEditComplete: () async {
                        var data =
                            ProductDatabase.productResult.data?.dataProduct;
                        for (var i = 0; i < (data?.length ?? 0); i++) {
                          if (trimString(data?[i].idProduct) ==
                              trimString(
                                  controller.cariProdukController.text)) {
                            controller
                                .onProdctSearch(trimString(data?[i].idProduct));
                            controller.update();
                          }
                        }
                      },
                      onSelected: (data) async {
                        controller.onProdctSearch(trimString(data.idProduct));
                        controller.cariProdukController.text =
                            trimString(data.idProduct);
                        controller.update();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  BasePrimaryButton(
                      text: "Bayar",
                      isDense: true,
                      onPressed:
                          (controller.dataPenjualan.details?.isEmpty ?? true)
                              ? null
                              : () {
                                  controller.onInitDialog();
                                  controller.update();
                                  update();

                                  showDialogBase(
                                    width: 700,
                                    content: DialogProsesPembayaran(
                                      controller: controller,
                                    ),
                                  );
                                }),
                ],
              ),
            if (controller.isDetail)
              const SizedBox(
                height: 16.0,
              ),
            if (controller.isDetail)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BasePrimaryButton(
                    text: "Cetak",
                    isDense: true,
                    onPressed: () {
                      controller.doGeneratePdfAndPrint();
                    },
                  ),
                ],
              ),
            const SizedBox(
              height: 16.0,
            ),
            ScreenTypeLayout.builder(
              desktop: (context) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const HeaderPenjualan(),
                        Container(
                          // height: 300,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height - 310,
                          ),
                          child: ListView.builder(
                            itemCount: controller.dataPenjualan.details?.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (controller.dataPenjualan.details?.isEmpty ??
                                  true) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 1.0,
                                        color: blueGray50,
                                      ),
                                      right: BorderSide(
                                        width: 1.0,
                                        color: blueGray50,
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(24.0),
                                  child: Center(
                                    child: Text(
                                      "Silakan Tambahkan Produk",
                                      style: myTextTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return BodyPenjualan(
                                  index: index,
                                  controller: controller,
                                );
                              }
                            },
                          ),
                        ),
                        FooterPenjualan(
                          controller: controller,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ContainerNota(
                    controller: controller,
                  ),
                ],
              ),
              mobile: (context) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 2000,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const HeaderPenjualan(),
                            Container(
                              // height: 300,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 310,
                              ),
                              child: ListView.builder(
                                itemCount:
                                    controller.dataPenjualan.details?.length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (controller
                                          .dataPenjualan.details?.isEmpty ??
                                      true) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            width: 1.0,
                                            color: blueGray50,
                                          ),
                                          right: BorderSide(
                                            width: 1.0,
                                            color: blueGray50,
                                          ),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(24.0),
                                      child: Center(
                                        child: Text(
                                          "Silakan Tambahkan Produk",
                                          style:
                                              myTextTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return BodyPenjualan(
                                      index: index,
                                      controller: controller,
                                    );
                                  }
                                },
                              ),
                            ),
                            FooterPenjualan(
                              controller: controller,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      ContainerNota(
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
