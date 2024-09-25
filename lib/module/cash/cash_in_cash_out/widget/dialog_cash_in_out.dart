// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogCashInOut extends StatefulWidget {
  final DataDetailCashInOut? data;
  final bool isDetail;

  const DialogCashInOut({
    Key? key,
    required this.isDetail,
    required this.data,
  }) : super(key: key);

  @override
  State<DialogCashInOut> createState() => _DialogCashInOutState();
}

class _DialogCashInOutState extends State<DialogCashInOut> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataDetailCashInOut dataEdit = DataDetailCashInOut();

  final cashInOutKey = GlobalKey<FormState>();

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailCashInOut();
    textController[0].text = formatDate(trimString(dataEdit.tgTransaksi));
    textController[1].text = formatMoney(trimString(dataEdit.nominal));
    textController[2].text = trimString(dataEdit.keterangan);
    super.initState();
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: cashInOutKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Ubah Data" : "Tambah Data",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                BaseForm(
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      iconCalendarMonth,
                      height: 16,
                      colorFilter: colorFilterPrimary,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await initSelectedDate(
                      initValue: dataEdit.tgTransaksi,
                    );

                    if (selectedDate != null) {
                      dataEdit.tgTransaksi = selectedDate.toString();
                      textController[0].text =
                          formatDate(selectedDate.toString());
                      update();
                    }
                  },
                  label: "Tanggal Transaksi",
                  hintText: "Masukkan Tanggal Transaksi",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                  textEditingController: textController[0],
                  enabled: true,
                ),
                BaseDropdownButton<DataDetailDivisi>(
                  hint: "Pilih Jenis Cash",
                  enabled: true,
                  label: "Jenis Cash",
                  itemAsString: (item) => item.divisiAsString(),
                  items: DivisiDatabase.dataDivisi.dataDivisi ?? [],
                  value:
                      trimString(widget.data?.idCash.toString()).isEmpty ?? true
                          ? null
                          : DataDetailDivisi(
                              // idDivisi: widget.data?.idDivisi,
                              // nmDivisi: trimString(
                              //   getNamaDivisi(
                              //     idDivisi: trimString(
                              //       widget.data?.idDivisi,
                              //     ),
                              //   ),
                              // ),
                              ),
                  onChanged: (value) {},
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseDropdownButton<DataDetailDivisi>(
                  hint: "Pilih Jenis Transaksi",
                  enabled: true,
                  label: "Jenis Transaksi",
                  itemAsString: (item) => item.divisiAsString(),
                  items: DivisiDatabase.dataDivisi.dataDivisi ?? [],
                  value: trimString(widget.data?.idJenis.toString()).isEmpty ??
                          true
                      ? null
                      : DataDetailDivisi(
                          // idDivisi: widget.data?.idDivisi,
                          // nmDivisi: trimString(
                          //   getNamaDivisi(
                          //     idDivisi: trimString(
                          //       widget.data?.idDivisi,
                          //     ),
                          //   ),
                          // ),
                          ),
                  onChanged: (value) {},
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseDropdownButton<DataDetailDivisi>(
                  hint: "Pilih Detail Jenis Transaksi",
                  enabled: true,
                  label: "Detail Jenis Transaksi",
                  itemAsString: (item) => item.divisiAsString(),
                  items: DivisiDatabase.dataDivisi.dataDivisi ?? [],
                  value: trimString(widget.data?.idDetail.toString()).isEmpty ??
                          true
                      ? null
                      : DataDetailDivisi(
                          // idDivisi: widget.data?.idDivisi,
                          // nmDivisi: trimString(
                          //   getNamaDivisi(
                          //     idDivisi: trimString(
                          //       widget.data?.idDivisi,
                          //     ),
                          //   ),
                          // ),
                          ),
                  onChanged: (value) {},
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                Container(),
                BaseForm(
                  prefix: const BasePrefixRupiah(),
                  label: "Nominal",
                  hintText: "Masukkan Nominal",
                  textInputFormater: [
                    ThousandsFormatter(),
                  ],
                  onChanged: (value) {
                    dataEdit.nominal = removeComma(trimString(value));
                    update();
                  },
                  textEditingController: textController[1],
                  enabled: true,
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              label: "Keterangan",
              hintText: "Masukkan Keterangan",
              textEditingController: textController[2],
              onChanged: (value) {
                dataEdit.keterangan = trimString(value);
                update();
              },
              enabled: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    text: "Batal",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BasePrimaryButton(
                    text: "Simpan",
                    onPressed: () {
                      if (cashInOutKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        payload.removeWhere(
                          (key, value) => key == "created_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "updated_at",
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
