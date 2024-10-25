// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerNotaDetail extends StatefulWidget {
  final DetailTransaksiController controller;

  const ContainerNotaDetail({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContainerNotaDetail> createState() => _ContainerNotaDetailState();
}

class _ContainerNotaDetailState extends State<ContainerNotaDetail> {
  @override
  Widget build(BuildContext context) {
    DetailTransaksiController controller = widget.controller;
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
          if (controller.dataPenjualan.idAnggota?.isNotEmpty ?? false)
            const SizedBox(
              height: 8.0,
            ),
          if (controller.dataPenjualan.idAnggota?.isNotEmpty ?? false)
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Nama Anggota",
                    style: myTextTheme.bodySmall,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    trimString(
                      getNamaAnggota(
                          idAnggota: controller.dataPenjualan.idAnggota),
                    ),
                    style: myTextTheme.bodySmall,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          if (controller.dataPenjualan.jenisPembayaran?.isNotEmpty ?? false)
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Metode Bayar",
                    style: myTextTheme.bodySmall,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    trimString(controller.dataPenjualan.jenisPembayaran)
                        .toUpperCase(),
                    style: myTextTheme.bodySmall,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          if ((controller.dataPenjualan.idAnggota?.isNotEmpty ?? false) ||
              (controller.dataPenjualan.jenisPembayaran?.isNotEmpty ?? false))
            const SizedBox(
              height: 8.0,
            ),
          if ((controller.dataPenjualan.idAnggota?.isNotEmpty ?? false) ||
              (controller.dataPenjualan.jenisPembayaran?.isNotEmpty ?? false))
            const LineDash(),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  trimString(UserDatabase.userDatabase.data?.userData?.name),
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
            itemCount: controller.dataPenjualan.details?.length ?? 0,
            itemBuilder: (context, index) {
              if (controller.dataPenjualan.details?.isEmpty ?? true) {
                return Container();
              } else {
                return BodyNotaDetail(index: index, controller: controller);
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
              Expanded(
                child: Text(
                  "Total",
                  style: myTextTheme.bodyMedium,
                ),
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
              Expanded(
                child: Text(
                  "Bayar",
                  style: myTextTheme.bodyMedium,
                ),
              ),
              Text(
                ":",
                style: myTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  formatMoney(trimString(
                      removeComma(controller.textControllerDialog[2].text))),
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
              Expanded(
                child: Text(
                  "Kembali",
                  style: myTextTheme.bodyMedium,
                ),
              ),
              Text(
                ":",
                style: myTextTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Text(
                  formatMoney(trimString(
                      removeComma(controller.textControllerDialog[3].text))),
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
