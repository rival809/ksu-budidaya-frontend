import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/stock_opname/cek_ulang/widget/dialog_cek_ulang.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CekUlangView extends StatefulWidget {
  const CekUlangView({super.key});

  Widget build(BuildContext context, CekUlangController controller) {
    controller.view = this;
    return BodyContainer(
      contentBody: Container(
        color: neutralWhite,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (context.canPop())
                          BackButton(
                            onPressed: () {
                              if (context.canPop()) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        const SizedBox(width: 16),
                        Text(
                          "Review Cek Ulang - Stock Opname Harian",
                          style: myTextTheme.headlineLarge,
                        ),
                      ],
                    ),
                    BasePrimaryButton(
                      text: "Kirim",
                      isDense: true,
                      onPressed: () {
                        showDialogBase(
                          content: DialogCekUlang(onConfirm: (String alasan) async {
                            await controller.submitReview(alasan: alasan);
                          }),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: blue50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: blue200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: blue600),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Pilih item untuk direview ulang. Centang checkbox pada item yang ingin direview.",
                          style: myTextTheme.bodyMedium?.copyWith(
                            color: blue900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),

                // Table
                if (controller.items.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        "Tidak ada item",
                        style: myTextTheme.titleMedium,
                      ),
                    ),
                  )
                else
                  Container(
                    height:
                        MediaQuery.of(context).size.height - AppBar().preferredSize.height - 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: blueGray50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: PlutoGrid(
                      columns: _buildColumns(controller),
                      rows: _buildRows(controller),
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        controller.stateManager = event.stateManager;
                        event.stateManager.setShowColumnFilter(true);
                      },
                      onRowChecked: controller.onRowChecked,
                      onChanged: (PlutoGridOnChangedEvent event) {
                        print("=== PlutoGrid onChanged triggered ===");
                        print("Column field: ${event.column.field}");
                        print("New value: ${event.value}");

                        if (event.column.field == 'notes') {
                          final itemId = event.row.cells['id_stocktake_item']?.value;
                          print("Item ID from row: $itemId");

                          if (itemId != null) {
                            controller.onNotesChanged(itemId, event.value.toString());
                          } else {
                            print("ERROR: itemId is null!");
                          }
                        }
                      },
                      mode: PlutoGridMode.normal,
                      configuration: PlutoGridConfiguration(
                        style: PlutoGridStyleConfig(
                          gridBackgroundColor: neutralWhite,
                          activatedColor: blue50,
                          gridBorderColor: blueGray50,
                          borderColor: blueGray50,
                          activatedBorderColor: primaryColor,
                          rowColor: neutralWhite,
                          columnTextStyle: myTextTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: neutralWhite,
                          ),
                          cellTextStyle: myTextTheme.bodyMedium!,
                        ),
                        columnSize: const PlutoGridColumnSizeConfig(
                          autoSizeMode: PlutoAutoSizeMode.scale,
                          resizeMode: PlutoResizeMode.normal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PlutoColumn> _buildColumns(CekUlangController controller) {
    return [
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "ID Produk",
        field: "id_product",
        type: PlutoColumnType.text(),
        width: 150,
        enableRowChecked: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Nama Produk",
        field: "nm_product",
        type: PlutoColumnType.text(),
        width: 250,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Divisi",
        field: "nm_divisi",
        type: PlutoColumnType.text(),
        width: 150,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Stock Sistem (Jml)",
        field: "stok_sistem_jml",
        type: PlutoColumnType.number(),
        width: 150,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Stock Sistem (Harga)",
        field: "stok_sistem_harga",
        type: PlutoColumnType.number(format: "#,###"),
        width: 180,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Stock Fisik (Jml)",
        field: "stok_fisik_jml",
        type: PlutoColumnType.number(),
        width: 150,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Stock Fisik (Harga)",
        field: "stok_fisik_harga",
        type: PlutoColumnType.number(format: "#,###"),
        width: 180,
        enableEditingMode: false,
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Selisih (Jml)",
        field: "selisih_jml",
        type: PlutoColumnType.number(),
        width: 120,
        enableEditingMode: false,
        renderer: (rendererContext) {
          final value = rendererContext.cell.value;
          final isNegative = value < 0;
          return Container(
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: myTextTheme.bodyMedium?.copyWith(
                color: isNegative ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Selisih (Harga)",
        field: "selisih_harga",
        type: PlutoColumnType.number(format: "#,###"),
        width: 150,
        enableEditingMode: false,
        renderer: (rendererContext) {
          final value = rendererContext.cell.value;
          final isNegative = value < 0;
          return Container(
            alignment: Alignment.center,
            child: Text(
              rendererContext.cell.value.toString(),
              style: myTextTheme.bodyMedium?.copyWith(
                color: isNegative ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        title: "Catatan",
        field: "notes",
        type: PlutoColumnType.text(),
        width: 200,
        enableEditingMode: true,
      ),
    ];
  }

  List<PlutoRow> _buildRows(CekUlangController controller) {
    return controller.items.map((item) {
      return PlutoRow(
        cells: {
          'id_stocktake_item': PlutoCell(value: item.idStocktakeItem ?? 0),
          'id_product': PlutoCell(value: item.idProduct ?? '-'),
          'nm_product': PlutoCell(value: item.nmProduct ?? '-'),
          'nm_divisi': PlutoCell(value: item.nmDivisi ?? '-'),
          'stok_sistem_jml': PlutoCell(value: item.stokSistem ?? 0),
          'stok_sistem_harga': PlutoCell(value: item.valuasi?.valuasiSistemJual ?? 0),
          'stok_fisik_jml': PlutoCell(value: item.stokFisik ?? 0),
          'stok_fisik_harga': PlutoCell(value: item.valuasi?.valuasiFisikJual ?? 0),
          'selisih_jml': PlutoCell(value: item.selisih ?? 0),
          'selisih_harga': PlutoCell(value: item.valuasi?.valuasiSelisihJual ?? 0),
          'notes': PlutoCell(value: item.notes ?? '-'),
        },
      );
    }).toList();
  }

  @override
  State<CekUlangView> createState() => CekUlangController();
}
