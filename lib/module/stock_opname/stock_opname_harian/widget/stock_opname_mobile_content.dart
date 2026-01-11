import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class StockOpnameMobileContent extends StatelessWidget {
  final StockOpnameHarianController controller;

  const StockOpnameMobileContent({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BodyContainer(
      contentBody: FutureBuilder(
        future: controller.itemsFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading data"));
            } else if (snapshot.hasData) {
              double total = controller.sessionData?.statistics?.totalItems ?? 0;
              double sudahSO = controller.sessionData?.statistics?.countedItems ?? 0;
              double belumSO = controller.sessionData?.statistics?.pendingItems ?? 0;

              List<DetailListStocktakeItemsilDataListStocktakeItems>? listData =
                  controller.filteredData.isEmpty && controller.searchController.text.isEmpty
                      ? controller.itemsData.data ?? []
                      : controller.filteredData;

              // Initialize filteredData on first load
              if (controller.filteredData.isEmpty && controller.searchController.text.isEmpty) {
                controller.filteredData = controller.itemsData.data ?? [];
              }

              return Column(
                children: [
                  // Statistics Cards
                  Container(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    color: neutralWhite,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "Total",
                            total.toInt().toString(),
                            blue600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            "Sudah SO",
                            sudahSO.toInt().toString(),
                            primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            "Belum SO",
                            belumSO.toInt().toString(),
                            red600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search Field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: neutralWhite,
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari produk, ID, atau divisi...',
                        prefixIcon: const Icon(Icons.search, color: blueGray400),
                        suffixIcon: controller.searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: blueGray400),
                                onPressed: () {
                                  controller.searchController.clear();
                                  controller.searchItems('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: blueGray50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        controller.onSearchChanged(value);
                      },
                    ),
                  ),
                  // List Items
                  Expanded(
                    child: listData.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.search_off, size: 64, color: blueGray300),
                                const SizedBox(height: 16),
                                Text(
                                  controller.searchController.text.isNotEmpty
                                      ? "Tidak ada hasil pencarian"
                                      : "Tidak ada data",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: blueGray400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            controller: controller.scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: listData.length + (controller.isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              // Show loading indicator at the end
                              if (index == listData.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final item = listData[index];
                              final isCounted = item.isCounted ?? false;

                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: isCounted ? primaryColor : red600,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.showDialogSO(
                                      namaProduk: item.nmProduct ?? '-',
                                      idItem: item.idStocktakeItem.toString(),
                                      initialStokFisik: item.stokFisik?.toString(),
                                      initialNotes: item.notes,
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.nmProduct ?? '-',
                                          style: myTextTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          item.idProduct ?? '-',
                                          style: myTextTheme.bodyMedium?.copyWith(
                                            color: blueGray400,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.nmDivisi ?? '-',
                                          style: myTextTheme.bodyMedium?.copyWith(
                                            color: blueGray400,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isCounted ? primaryColor.withOpacity(0.1) : red100,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            isCounted ? "Sudah SO" : "Belum SO",
                                            style: myTextTheme.bodySmall?.copyWith(
                                              color: isCounted ? primaryColor : red600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Tidak ada data"));
            }
          } else {
            return const Center(child: Text("Tidak ada data"));
          }
        },
      ),
      floatingActionButton: Container(
        color: neutralWhite,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            BaseSecondaryButton(
                onPressed: () {
                  controller.refreshData();
                },
                isDense: true,
                text: "Refresh Data"),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: BasePrimaryButton(
                  onPressed: () {
                    showDialogBase(
                      content: DialogSubmit(onConfirm: (String alasan) async {
                        if (UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE001" ||
                            UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE002") {
                          await controller.submitSoManager(reason: alasan);
                        } else {
                          await controller.submitSo(reason: alasan);
                        }
                      }),
                    );
                  },
                  text: "Simpan"),
            ),
          ],
        ),
      ),
      floatingActionLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: myTextTheme.bodySmall?.copyWith(
              color: neutralWhite,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: myTextTheme.headlineMedium?.copyWith(
              color: neutralWhite,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
