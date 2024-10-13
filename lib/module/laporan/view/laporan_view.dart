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
                        controller.update();
                        controller.update();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth:
                            Provider.of<DrawerProvider>(context).isDrawerOpen
                                ? MediaQuery.of(context).size.width - 32 - 260
                                : MediaQuery.of(context).size.width - 32,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 500,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: BaseDropdownButton<Month>(
                                    sortItem: false,
                                    label: "Bulan",
                                    itemAsString: (item) =>
                                        item.monthAsString(),
                                    items: Year.fromJson(monthData).months,
                                    value: Month(
                                      id: controller.monthNow,
                                      month: trimString(
                                          getNamaMonth(controller.monthNow)),
                                    ),
                                    onChanged: (value) {
                                      controller.monthNow = value?.id ?? 1;
                                      controller.update();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: BaseDropdownButton<int>(
                                    sortItem: false,
                                    label: "Tahun",
                                    items: controller.yearData,
                                    value: controller.yearNow,
                                    itemAsString: (item) => item.toString(),
                                    onChanged: (value) {
                                      controller.yearNow = value ?? 2023;
                                      controller.update();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                BasePrimaryButton(
                                  onPressed: () {
                                    controller
                                        .onSearchLaporan(controller.idLaporan);
                                    controller.update();
                                  },
                                  text: "Lihat Data",
                                  isDense: true,
                                ),
                              ],
                            ),
                          ),
                          BaseSecondaryButton(
                            onPressed: controller.hasData
                                ? () {
                                    doGenerateLaporanHasilUsaha(
                                        controller: controller);
                                  }
                                : null,
                            text: "Cetak Laporan",
                            suffixIcon: iconPrint,
                            isDense: true,
                          ),
                        ],
                      ),
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
