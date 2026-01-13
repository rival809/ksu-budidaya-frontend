import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class HighRiskView extends StatefulWidget {
  const HighRiskView({super.key});

  Widget build(context, HighRiskController controller) {
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
                    "Produk Rentan",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: Provider.of<DrawerProvider>(context).isDrawerOpen
                            ? MediaQuery.of(context).size.width - 32 - 265
                            : MediaQuery.of(context).size.width - 32,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BaseSecondaryButton(
                                onPressed: () {
                                  controller.field = null;
                                  controller.dataFuture = controller.fetchHighRiskProducts();
                                  controller.update();
                                },
                                text: "Refresh",
                                suffixIcon: iconCached,
                                isDense: true,
                              ),
                              const SizedBox(width: 16.0),
                            ],
                          ),
                          BasePrimaryButton(
                            onPressed: () {
                              showDialogBase(
                                width: 700,
                                content: DialogHighRisk(
                                  isEdit: false,
                                  data: DataListHighRisk(),
                                ),
                              );
                            },
                            text: "Tambah",
                            suffixIcon: iconAdd,
                            isDense: true,
                          ),
                        ],
                      ),
                    ),
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
                          ListHighRiskModel result = snapshot.data;
                          List<DataListHighRisk> listData = result.data ?? [];

                          if (listData.isNotEmpty) {
                            List<PlutoRow> rows = [];
                            List<PlutoColumn> columns = [];

                            columns.addAll([
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText: "Cari ID",
                                title: "ID",
                                field: "id_high_risk",
                                type: PlutoColumnType.number(),
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText: "Cari ID Produk",
                                title: "ID Produk",
                                field: "id_product",
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText: "Cari Nama Produk",
                                title: "Nama Produk",
                                field: "nm_product",
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText: "Cari Kategori",
                                title: "Kategori",
                                field: "category",
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                backgroundColor: primaryColor,
                                filterHintText: "Cari Alasan",
                                title: "Alasan",
                                field: "reason",
                                type: PlutoColumnType.text(),
                              ),
                            ]);

                            columns.add(
                              PlutoColumn(
                                width: 150,
                                backgroundColor: primaryColor,
                                frozen: PlutoColumnFrozen.end,
                                title: "AKSI",
                                field: "aksi",
                                filterHintText: "",
                                type: PlutoColumnType.text(),
                                enableEditingMode: false,
                                renderer: (rendererContext) {
                                  final rowIndex = rendererContext.rowIdx;
                                  DataListHighRisk detailData = listData[rowIndex];

                                  return DropdownAksi(
                                    text: "Aksi",
                                    listItem: [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(iconEditSquare),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                'Edit Data',
                                                style: myTextTheme.bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              iconDelete,
                                              colorFilter: colorFilter(color: red600),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Hapus',
                                              style: myTextTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onChange: (value) {
                                      if (value == 1) {
                                        showDialogBase(
                                          width: 700,
                                          content: DialogHighRisk(
                                            isEdit: true,
                                            data: detailData,
                                          ),
                                        );
                                      } else if (value == 2) {
                                        showDialogBase(
                                          content: DialogKonfirmasi(
                                            textKonfirmasi:
                                                "Apakah Anda Yakin Ingin Menghapus Data?",
                                            onConfirm: () {
                                              controller.deleteHighRisk(
                                                detailData.idHighRisk.toString(),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            );

                            for (var item in listData) {
                              Map<String, dynamic> data = {
                                "id_high_risk": item.idHighRisk,
                                "id_product": item.idProduct,
                                "nm_product": item.nmProduct,
                                "category": item.category ?? "-",
                                "reason": item.reason ?? "-",
                                "aksi": item.idHighRisk,
                              };

                              rows.add(PlutoRow(cells: {
                                "id_high_risk": PlutoCell(value: data["id_high_risk"]),
                                "id_product": PlutoCell(value: data["id_product"]),
                                "nm_product": PlutoCell(value: data["nm_product"]),
                                "category": PlutoCell(value: data["category"]),
                                "reason": PlutoCell(value: data["reason"]),
                                "aksi": PlutoCell(value: data["aksi"]),
                              }));
                            }

                            return SizedBox(
                              height: MediaQuery.of(context).size.height - 250,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: "High Risk",
                                ),
                                columns: columns,
                                rows: rows,
                                onLoaded: (PlutoGridOnLoadedEvent event) {},
                                configuration: PlutoGridConfiguration(
                                  columnSize: const PlutoGridColumnSizeConfig(
                                    autoSizeMode: PlutoAutoSizeMode.equal,
                                  ),
                                  style: PlutoGridStyleConfig(
                                    columnTextStyle: myTextTheme.titleSmall!.copyWith(
                                      color: neutralWhite,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const ContainerTidakAda(
                              entity: "High Risk",
                            );
                          }
                        } else {
                          return const ContainerTidakAda(
                            entity: "High Risk",
                          );
                        }
                      } else {
                        return const ContainerTidakAda(
                          entity: "High Risk",
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
  State<HighRiskView> createState() => HighRiskController();
}
