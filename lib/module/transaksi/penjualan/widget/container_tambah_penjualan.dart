// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

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
                    child: BaseForm(
                      focusNode: controller.focusNodeInputPenjualan,
                      autoFocus: true,
                      textEditingController: controller.cariProdukController,
                      onChanged: (value) {
                        controller.onProdctSearch(value);
                        controller.update();
                      },
                      hintText: "Cari Produk",
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
