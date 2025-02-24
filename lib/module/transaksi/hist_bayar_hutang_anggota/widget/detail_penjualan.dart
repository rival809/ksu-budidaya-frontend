// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/controller/hist_bayar_hutang_anggota_controller.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/widget/body_penjualan.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/widget/container_nota.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/widget/footer_penjualan.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/widget/header_penjualan.dart';

class DetailPenjualan extends StatefulWidget {
  final HistBayarHutangAnggotaController controller;

  const DetailPenjualan({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DetailPenjualan> createState() => _DetailPenjualanState();
}

class _DetailPenjualanState extends State<DetailPenjualan> {
  @override
  Widget build(BuildContext context) {
    HistBayarHutangAnggotaController controller = widget.controller;
    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 105,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
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
                      ScreenTypeLayout.builder(
                        desktop: (context) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const HeaderPenjualanHist(),
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
                                          return BodyPenjualanHist(
                                            index: index,
                                            controller: controller,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  FooterPenjualanHist(
                                    controller: controller,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            ContainerNotaHist(
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
                                      const HeaderPenjualanHist(),
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
                                              return BodyPenjualanHist(
                                                index: index,
                                                controller: controller,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      FooterPenjualanHist(
                                        controller: controller,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                ContainerNotaHist(
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
