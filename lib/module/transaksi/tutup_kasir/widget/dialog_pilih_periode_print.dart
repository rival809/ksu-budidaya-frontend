// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogPilihPeriodePrint extends StatefulWidget {
  final Function(int month, int year) onPeriodSelected;

  const DialogPilihPeriodePrint({
    Key? key,
    required this.onPeriodSelected,
  }) : super(key: key);

  @override
  State<DialogPilihPeriodePrint> createState() => _DialogPilihPeriodePrintState();
}

class _DialogPilihPeriodePrintState extends State<DialogPilihPeriodePrint> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    // Generate year list from 2025 to current year + 1
    int currentYear = DateTime.now().year;
    List<int> years = [];
    for (int year = 2025; year <= currentYear + 1; year++) {
      years.add(year);
    }

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.date_range,
                color: primaryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Pilih Periode Cetak",
                  style: myTextTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            "Pilih bulan dan tahun untuk mencetak riwayat tutup kasir:",
            style: myTextTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Month Selection
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bulan",
                      style: myTextTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BaseDropdownButton<int>(
                      value: selectedMonth,
                      hint: "Pilih Bulan",
                      sortItem: false,
                      itemAsString: (item) => months[item - 1],
                      items: List.generate(12, (index) => index + 1),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value ?? DateTime.now().month;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tahun",
                      style: myTextTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BaseDropdownButton<int>(
                      value: selectedYear,
                      hint: "Pilih Tahun",
                      itemAsString: (item) => item.toString(),
                      items: years,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value ?? DateTime.now().year;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          // Content
          Text(
            "Pastikan Data Yang Ditampilkan Pada Tabel Sudah Mencakup Semua Data",
            style: myTextTheme.bodyMedium,
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: BaseSecondaryButton(
                  text: "Batal",
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: BasePrimaryButton(
                  text: "Cetak",
                  suffixIcon: iconPrint,
                  onPressed: () {
                    Get.back();
                    widget.onPeriodSelected(selectedMonth, selectedYear);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
