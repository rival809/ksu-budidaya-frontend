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
    final drawerProvider = Provider.of<DrawerProvider>(context);

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

              return Container(
                color: appLightBackground,
                child: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    // Statistics Cards - Collapsible Header
                    SliverAppBar(
                      expandedHeight: 118,
                      floating: false,
                      pinned: false,
                      foregroundColor: appLightBackground,
                      backgroundColor: appLightBackground,
                      automaticallyImplyLeading: false,
                      toolbarHeight: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          padding: const EdgeInsets.all(16),
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
                      ),
                    ),
                    // Search Field - Sticky
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SearchHeaderDelegate(
                        child: Container(
                            color: appLightBackground,
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                            child: BaseForm(
                              hintText: 'Cari produk, ID, atau divisi',
                              prefixIcon: iconSearch,
                              onChanged: (value) {
                                controller.onSearchChanged(value);
                              },
                              textEditingController: controller.searchController,
                            )),
                      ),
                    ),
                    // List Items
                    listData.isEmpty
                        ? SliverFillRemaining(
                            child: Center(
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
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
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
                                                color: isCounted
                                                    ? primaryColor.withOpacity(0.1)
                                                    : red100,
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
                                childCount: listData.length + (controller.isLoadingMore ? 1 : 0),
                              ),
                            ),
                          ),
                    // Bottom spacing for floating action button
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 60),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Tidak ada data"));
            }
          } else {
            return const Center(child: Text("Tidak ada data"));
          }
        },
      ),
      floatingActionButton: drawerProvider.isDrawerOpen
          ? null
          : Container(
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
                  if (!(controller.itemsData.data?.isEmpty ?? true))
                    Expanded(
                      child: BasePrimaryButton(
                          onPressed: () {
                            showDialogBase(
                              content: DialogSubmit(onConfirm: (String alasan) async {
                                if (UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE001" ||
                                    UserDatabase.userDatabase.data?.roleData?.idRole == "ROLE004") {
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

// Custom Delegate for Search Header
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate({
    required this.child,
  });

  @override
  double get minExtent => 72.0;

  @override
  double get maxExtent => 72.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: 72.0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) => false;
}
