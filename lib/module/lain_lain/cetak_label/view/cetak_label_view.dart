import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CetakLabelView extends StatefulWidget {
  const CetakLabelView({Key? key}) : super(key: key);

  Widget build(context, CetakLabelController controller) {
    controller.view = this;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Label Harga",
                        style: myTextTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 300,
                            child: SearchForm(
                              label: "ID Product",
                              enabled: true,
                              textEditingController: controller.textController,
                              items: (search) =>
                                  controller.getDetailSuggestions(
                                search,
                                ProductDatabase.productResult.data?.dataProduct,
                              ),
                              itemBuilder: (context, dataPembelian) {
                                return ListTile(
                                  title: Text(
                                      "${trimString(dataPembelian.idProduct)} - ${trimString(dataPembelian.nmProduct)}"),
                                );
                              },
                              onEditComplete: () async {
                                var data = ProductDatabase
                                    .productResult.data?.dataProduct;
                                for (var i = 0; i < (data?.length ?? 0); i++) {
                                  if (trimString(data?[i].idProduct) ==
                                      trimString(
                                          controller.textController.text)) {
                                    controller.dataLabel.add(
                                      data?[i] ?? DataDetailProduct(),
                                    );
                                    await controller.generatePdf();

                                    controller.update();
                                  }
                                }
                              },
                              onSelected: (data) async {
                                controller.dataLabel.add(data);
                                await controller.generatePdf();

                                controller.update();
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const HeaderCetakLabel(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.dataLabel.length,
                                  itemBuilder: (context, index) {
                                    if (controller.dataLabel.isEmpty) {
                                      return Container();
                                    } else {
                                      return BodyCetakLabel(
                                        index: index,
                                        controller: controller,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: blueGray50,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height -
                                    AppBar().preferredSize.height -
                                    200,
                                child: PdfPreview(
                                  build: (format) => controller.generatePdf(),
                                  allowPrinting: true,
                                  allowSharing: false,
                                  canChangePageFormat: false,
                                  canChangeOrientation: false,
                                  previewPageMargin: EdgeInsets.zero,
                                  pdfFileName: 'product_list.pdf',
                                ),
                              ),
                            ),
                          )
                        ],
                      )
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

  @override
  State<CetakLabelView> createState() => CetakLabelController();
}
