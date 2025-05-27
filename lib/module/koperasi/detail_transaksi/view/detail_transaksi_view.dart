import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DetailTransaksiView extends StatefulWidget {
  final String idPenjualan;
  const DetailTransaksiView({
    Key? key,
    required this.idPenjualan,
  }) : super(key: key);

  Widget build(context, DetailTransaksiController controller) {
    controller.view = this;

    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // DetailDataPenjualan? dataPenjualan = controller
                            //     .result.data?.dataPenjualan
                            //     ?.firstWhere(
                            //   (element) =>
                            //       trimString(element.idPenjualan) ==
                            //       trimString(controller.widget.idPenjualan),
                            // );
                            // router.go(
                            //   Uri(
                            //     path: "/koperasi/anggota/pembayaran-hutang",
                            //     queryParameters: {
                            //       'id': trimString(dataPenjualan?.idAnggota)
                            //     },
                            //   ).toString(),
                            // );
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
                        Expanded(
                          child: Text(
                            "Detail Transaksi",
                            style: myTextTheme.headlineLarge,
                          ),
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
                                const HeaderPenjualanDetail(),
                                Container(
                                  // height: 300,
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height - 310,
                                  ),
                                  child: ListView.builder(
                                    itemCount: controller.dataPenjualan.details?.length ?? 0,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (controller.dataPenjualan.details?.isEmpty ?? true) {
                                        return Container();
                                      } else {
                                        return BodyPenjualanDetail(
                                          index: index,
                                          controller: controller,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                FooterPenjualanDetail(
                                  controller: controller,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          ContainerNotaDetail(
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
                                    const HeaderPenjualanDetail(),
                                    Container(
                                      // height: 300,
                                      constraints: BoxConstraints(
                                        maxHeight: MediaQuery.of(context).size.height - 310,
                                      ),
                                      child: ListView.builder(
                                        itemCount: controller.dataPenjualan.details?.length ?? 0,
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
                                            return BodyPenjualanDetail(
                                              index: index,
                                              controller: controller,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    FooterPenjualanDetail(
                                      controller: controller,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              ContainerNotaDetail(
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
    );
  }

  @override
  State<DetailTransaksiView> createState() => DetailTransaksiController();
}
