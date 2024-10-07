// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerNota extends StatefulWidget {
  final PenjualanController controller;

  const ContainerNota({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerNota> createState() => _ContainerNotaState();
}

class _ContainerNotaState extends State<ContainerNota> {
  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;
    controller.sumTotal();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: neutralWhite,
      ),
      width: 400,
      child: Column(
        children: [
          Text(
            "KSU BUDI DAYA",
            style: myTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "KASIR 1",
                  style: myTextTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  formatDateTime(DateTime.now().toString()),
                  textAlign: TextAlign.end,
                  style: myTextTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          const LineDash(),
          const SizedBox(
            height: 8.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.dataPenjualan.details?.length,
            itemBuilder: (context, index) {
              if (controller.dataPenjualan.details?.isEmpty ?? true) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 1.0,
                        color: blueGray50,
                      ),
                      right: BorderSide(
                        width: 1.0,
                        color: blueGray50,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      "Silakan Tambahkan Produk",
                      style: myTextTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else {
                return BodyNota(index: index, controller: controller);
              }
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          const LineDash(),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Text(
                "Total",
                style: myTextTheme.bodyMedium,
              ),
              Text(
                ":",
                style: myTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  formatMoney(
                      trimString(controller.dataPenjualan.totalNilaiJual)),
                  style: myTextTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Bayar",
                style: myTextTheme.bodyMedium,
              ),
              Text(
                ":",
                style: myTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  formatMoney(trimString(controller.bayar.toString())),
                  style: myTextTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Kembali",
                style: myTextTheme.bodyMedium,
              ),
              Text(
                ":",
                style: myTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  formatMoney(trimString(controller.kembali.toString())),
                  style: myTextTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
