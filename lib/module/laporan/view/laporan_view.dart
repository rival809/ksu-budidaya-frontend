import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ksu_budidaya/core.dart';

class LaporanView extends StatefulWidget {
  const LaporanView({Key? key}) : super(key: key);

  Widget build(context, LaporanController controller) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Laporan",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 500,
                    child: BaseDropdownButton<ItemLaporan>(
                      sortItem: false,
                      hint: "Pilih Jenis Laporan",
                      itemAsString: (item) => item.itemLaporanAsString(),
                      items: JenisLaporan.fromJson(dataItemLaporan)
                          .listItemLaporan,
                      value: controller.idLaporan == 0
                          ? null
                          : ItemLaporan(
                              id: controller.idLaporan,
                              nmLaporan: trimString(
                                getNamaLaporan(controller.idLaporan),
                              ),
                            ),
                      onChanged: (value) {
                        controller.idLaporan = value?.id ?? 1;
                        controller.monthNow = DateTime.now().month;
                        controller.yearNow = DateTime.now().year;
                        controller.hasData = false;
                        controller.update();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  controller.contentLaporan(controller.idLaporan)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<LaporanView> createState() => LaporanController();
}
