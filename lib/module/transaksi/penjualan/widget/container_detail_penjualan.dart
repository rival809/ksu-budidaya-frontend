// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/penjualan/widget/body_penjualan_detail.dart';
import 'package:ksu_budidaya/module/transaksi/penjualan/widget/footer_penjualan_detail.dart';
import 'package:ksu_budidaya/module/transaksi/penjualan/widget/header_penjualan_detail.dart';

class ContainerDetailPenjualan extends StatefulWidget {
  final PenjualanController controller;

  const ContainerDetailPenjualan({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerDetailPenjualan> createState() => _ContainerDetailPenjualanState();
}

class _ContainerDetailPenjualanState extends State<ContainerDetailPenjualan> {
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
                  onTap: () async {
                    print("object");
                    controller.dataPenjualan = CreatePenjualanModel();
                    controller.update();
                    await Future.delayed(Duration.zero);
                    Get.back();
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
                  "Detail Penjualan",
                  style: myTextTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
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
                        const DetailTransaksiHeaderPenjualan(),
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
                              if (controller.dataPenjualan.details?.isEmpty ?? true) {
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
                                return DetailTransaksiBodyPenjualan(
                                  index: index,
                                  controller: controller,
                                );
                              }
                            },
                          ),
                        ),
                        DetailTransaksiFooterPenjualan(
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
                            const DetailTransaksiHeaderPenjualan(),
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
                                  if (controller.dataPenjualan.details?.isEmpty ?? true) {
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
                                    return DetailTransaksiBodyPenjualan(
                                      index: index,
                                      controller: controller,
                                    );
                                  }
                                },
                              ),
                            ),
                            DetailTransaksiFooterPenjualan(
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
