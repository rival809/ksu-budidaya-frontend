import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ListSessionView extends StatefulWidget {
  const ListSessionView({super.key});

  Widget build(context, ListSessionController controller) {
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
                    "Session",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 200,
                            child: BaseDropdownButton<String>(
                              label: "Status",
                              hint: "Pilih Status",
                              items: controller.statusOptions,
                              value: controller.statusFilter,
                              itemAsString: (item) => item,
                              onChanged: (value) {
                                controller.statusFilter = value ?? "SEMUA";
                                controller.page = "1";
                                controller.dataFuture = controller.fetchListSession(
                                  isAsc: controller.isAsc,
                                  field: controller.field,
                                );
                                controller.update();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          BasePrimaryButton(
                            text: "Refresh",
                            isDense: true,
                            onPressed: () {
                              controller.dataFuture = controller.fetchListSession(
                                isAsc: controller.isAsc,
                                field: controller.field,
                              );
                              controller.update();
                            },
                          )
                        ],
                      ),
                      if (UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE001" ||
                          UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE002") ...[
                        BasePrimaryButton(
                          onPressed: () {
                            controller.createNewSession();
                          },
                          text: "Buat Sesi",
                          isDense: true,
                        ),
                      ]
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  FutureBuilder(
                    future: controller.dataFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ContainerLoadingRole();
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const ContainerError();
                        } else if (snapshot.hasData) {
                          ListSessionModel result = snapshot.data;
                          controller.listSessionData = result.data ?? DataLListSession();
                          List<DataDetailSession>? listData =
                              controller.listSessionData.data?.cast<DataDetailSession>() ?? [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            // Create columns
                            columns.addAll([
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "ID Session",
                                field: "id_stocktake_session",
                                type: PlutoColumnType.text(),
                                width: 180,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Jenis Stock Opname",
                                field: "stocktake_type",
                                type: PlutoColumnType.text(),
                                width: 150,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Status",
                                field: "status",
                                type: PlutoColumnType.text(),
                                width: 120,
                                renderer: (rendererContext) {
                                  String status = rendererContext.row.cells['status']?.value ?? "";
                                  Color bgColor;
                                  Color textColor;
                                  Color borderColor;

                                  switch (status.toLowerCase()) {
                                    case 'draft':
                                      bgColor = yellow50;
                                      textColor = yellow900;
                                      borderColor = yellow900;
                                      break;
                                    case 'completed':
                                      bgColor = green50;
                                      textColor = green900;
                                      borderColor = green900;
                                      break;
                                    case 'in_progress':
                                      bgColor = blue50;
                                      textColor = blue900;
                                      borderColor = blue900;
                                      break;
                                    default:
                                      bgColor = blueGray50;
                                      textColor = blueGray900;
                                      borderColor = blueGray900;
                                  }

                                  return CardLabel(
                                    cardColor: bgColor,
                                    cardTitle: convertTitle(status),
                                    cardTitleColor: textColor,
                                    cardBorderColor: borderColor,
                                  );
                                },
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Dibuat Oleh",
                                field: "nama_kasir",
                                type: PlutoColumnType.text(),
                                width: 150,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Tgl",
                                field: "tg_stocktake",
                                type: PlutoColumnType.text(),
                                width: 120,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Reviewer",
                                field: "nama_reviewer",
                                type: PlutoColumnType.text(),
                                width: 150,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Total",
                                field: "total_items",
                                type: PlutoColumnType.number(),
                                width: 100,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Sudah SO",
                                field: "total_counted",
                                type: PlutoColumnType.number(),
                                width: 100,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Selisih",
                                field: "total_variance",
                                type: PlutoColumnType.number(),
                                width: 100,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "ID",
                                field: "id_tutup_kasir",
                                type: PlutoColumnType.text(),
                                width: 80,
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                title: "Shift",
                                field: "shift",
                                type: PlutoColumnType.text(),
                                width: 100,
                              ),
                              PlutoColumn(
                                width: 150,
                                backgroundColor: primaryColor,
                                frozen: PlutoColumnFrozen.end,
                                title: "Aksi",
                                field: "aksi",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  int rowIndex = rendererContext.rowIdx;
                                  DataDetailSession sessionData = listData[rowIndex];
                                  return BaseSecondaryButton(
                                    onPressed: () {
                                      controller.navigateToStockOpname(sessionData);
                                    },
                                    text: "Detail",
                                    isDense: true,
                                  );
                                },
                              ),
                            ]);

                            // Create rows
                            rows = listData.map((item) {
                              Map<String, PlutoCell> cells = {};

                              cells['id_stocktake_session'] = PlutoCell(
                                value: trimString(item.idStocktakeSession),
                              );
                              cells['stocktake_type'] = PlutoCell(
                                value: trimString(item.stocktakeType),
                              );
                              cells['status'] = PlutoCell(
                                value: trimString(item.status),
                              );
                              cells['nama_kasir'] = PlutoCell(
                                value: trimString(item.namaKasir),
                              );
                              cells['tg_stocktake'] = PlutoCell(
                                value: item.tgStocktake != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(item.tgStocktake!))
                                    : "",
                              );
                              cells['nama_reviewer'] = PlutoCell(
                                value: trimString(item.namaReviewer),
                              );
                              cells['total_items'] = PlutoCell(
                                value: item.totalItems ?? 0,
                              );
                              cells['total_counted'] = PlutoCell(
                                value: item.totalCounted ?? 0,
                              );
                              cells['total_variance'] = PlutoCell(
                                value: item.totalVariance ?? 0,
                              );
                              cells['id_tutup_kasir'] = PlutoCell(
                                value: trimString(item.idTutupKasir?.toString() ?? ""),
                              );
                              cells['shift'] = PlutoCell(
                                value: trimString(item.shift),
                              );
                              cells['aksi'] = PlutoCell(value: null);

                              return PlutoRow(cells: cells);
                            }).toList();

                            return SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  AppBar().preferredSize.height -
                                  144 -
                                  16,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: 'Session',
                                ),
                                mode: PlutoGridMode.select,
                                onLoaded: (event) {
                                  event.stateManager.setShowColumnFilter(true);
                                },
                                onSorted: (event) {
                                  if (event.column.field != "aksi") {
                                    controller.isAsc = !controller.isAsc;
                                    controller.field = event.column.field;
                                    controller.update();
                                    controller.dataFuture = controller.fetchListSession(
                                      isAsc: controller.isAsc,
                                      field: event.column.field,
                                    );
                                    controller.update();
                                  }
                                },
                                configuration: PlutoGridConfiguration(
                                  columnSize: const PlutoGridColumnSizeConfig(
                                    autoSizeMode: PlutoAutoSizeMode.scale,
                                  ),
                                  style: PlutoGridStyleConfig(
                                    columnTextStyle:
                                        myTextTheme.titleSmall?.copyWith(color: neutralWhite) ??
                                            const TextStyle(),
                                    gridBorderColor: blueGray50,
                                    gridBorderRadius: BorderRadius.circular(8),
                                  ),
                                  localeText: configLocale,
                                ),
                                columns: columns,
                                rows: rows,
                                createFooter: (stateManager) {
                                  return FooterTableWidget(
                                    page: controller.page,
                                    itemPerpage: controller.size,
                                    maxPage: controller.listSessionData.pagination?.totalPages ?? 0,
                                    onChangePage: (value) {
                                      controller.page = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.fetchListSession(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    onChangePerPage: (value) {
                                      controller.page = "1";
                                      controller.size = trimString(value);
                                      controller.update();
                                      controller.dataFuture = controller.fetchListSession(
                                        isAsc: controller.isAsc,
                                        field: controller.field,
                                      );
                                      controller.update();
                                    },
                                    totalRow: controller.listSessionData.pagination?.total ?? 0,
                                    onPressLeft: () {
                                      if (int.parse(controller.page) > 1) {
                                        controller.page =
                                            (int.parse(controller.page) - 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.fetchListSession(
                                          isAsc: controller.isAsc,
                                          field: controller.field,
                                        );
                                        controller.update();
                                      }
                                    },
                                    onPressRight: () {
                                      if (int.parse(controller.page) <
                                          (controller.listSessionData.pagination?.totalPages ??
                                              0)) {
                                        controller.page =
                                            (int.parse(controller.page) + 1).toString();
                                        controller.update();
                                        controller.dataFuture = controller.fetchListSession(
                                          isAsc: controller.isAsc,
                                          field: controller.field,
                                        );
                                        controller.update();
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const ContainerTidakAda(
                              entity: 'Session',
                            );
                          }
                        } else {
                          return const ContainerError();
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "Session",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<ListSessionView> createState() => ListSessionController();
}
