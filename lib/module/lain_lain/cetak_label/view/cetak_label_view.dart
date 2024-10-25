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
                                  title:
                                      Text(trimString(dataPembelian.idProduct)),
                                );
                              },
                              onSelected: (data) {},
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          BasePrimaryButton(
                            onPressed: () {},
                            isDense: true,
                            text: "Cetak",
                            suffixIcon: iconPrint,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: HeaderCetakLabel(),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Container(),
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
