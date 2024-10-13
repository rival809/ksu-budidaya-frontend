// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LaporanHasilUsaha extends StatefulWidget {
  final LaporanController controller;

  const LaporanHasilUsaha({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LaporanHasilUsaha> createState() => _LaporanHasilUsahaState();
}

class _LaporanHasilUsahaState extends State<LaporanHasilUsaha> {
  @override
  Widget build(BuildContext context) {
    LaporanController controller = widget.controller;
    return FutureBuilder(
      future: controller.dataFutureHasilUsaha,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ContainerLoadingRole();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const ContainerError();
          } else if (snapshot.hasData) {
            // CashInOutResult result = snapshot.data;
            // controller.dataCashInOut =
            //     result.data ?? DataCashInOut();
            List<dynamic> listData = [];
            // List<dynamic> listData = controller.dataCashInOut
            //         .toJson()["data_cash_in_out"] ??
            //     [];

            if (listData.isNotEmpty) {
              List<PlutoRow> rows = [];
              List<PlutoColumn> columns = [];

              return SizedBox(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    144 -
                    16 -
                    64 -
                    38,
                child: PlutoGrid(
                  noRowsWidget: const ContainerTidakAda(
                    entity: 'Laporan Hasil Usaha',
                  ),
                  mode: PlutoGridMode.select,
                  onLoaded: (event) {
                    event.stateManager.setShowColumnFilter(true);
                  },
                  configuration: PlutoGridConfiguration(
                    columnSize: const PlutoGridColumnSizeConfig(
                      autoSizeMode: PlutoAutoSizeMode.scale,
                    ),
                    style: PlutoGridStyleConfig(
                      columnTextStyle: myTextTheme.titleSmall
                              ?.copyWith(color: neutralWhite) ??
                          const TextStyle(),
                      gridBorderColor: blueGray50,
                      gridBorderRadius: BorderRadius.circular(8),
                    ),
                    localeText: configLocale,
                  ),
                  columns: columns,
                  rows: rows,
                ),
              );
            } else {
              return const ContainerTidakAda(
                entity: 'Laporan Hasil Usaha',
              );
            }
          } else {
            return const ContainerError();
          }
        } else {
          return const ContainerTidakAda(
            entity: "Laporan Hasil Usaha",
          );
        }
      },
    );
  }
}
