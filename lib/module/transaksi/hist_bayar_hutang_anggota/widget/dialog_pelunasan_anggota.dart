// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/controller/hist_bayar_hutang_anggota_controller.dart';

class DialogPelunasanAnggotaNew extends StatefulWidget {
  final DetailDataHutangAnggota? dataHutang;
  final List<DetailDataHutangAnggota>? listHutang;

  const DialogPelunasanAnggotaNew({
    Key? key,
    required this.dataHutang,
    required this.listHutang,
  }) : super(key: key);

  @override
  State<DialogPelunasanAnggotaNew> createState() => _DialogPelunasanAnggotaNewState();
}

class _DialogPelunasanAnggotaNewState extends State<DialogPelunasanAnggotaNew> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  BayarHutangAnggotaPayload dataEdit = BayarHutangAnggotaPayload();
  DetailDataHutangAnggota valueHutang = DetailDataHutangAnggota();

  final pelunasanHutangAnggotaKey = GlobalKey<FormState>();

  postBayarHutangAnggota(DataMap dataCreate) async {
    showCircleDialogLoading();
    try {
      BayarHutangAnggotaResult result = await ApiService.bayarHutangAnggota(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Get.back();

      if (result.success == true) {
        Get.back();
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        HistBayarHutangAnggotaController.instance.dataFuture =
            HistBayarHutangAnggotaController.instance.cariDataHutangDagang();
        HistBayarHutangAnggotaController.instance.update();
      }
    } catch (e) {
      Get.back();

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  List<DetailDataHutangAnggota> getDetailSuggestions(
      String query, List<DetailDataHutangAnggota>? states) {
    List<DetailDataHutangAnggota> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches
          .retainWhere((s) => trimString(s.nmAnggota).toLowerCase().contains(query.toLowerCase()));
    }

    return matches;
  }

  @override
  void initState() {
    super.initState();

    dataEdit = BayarHutangAnggotaPayload(
      idHutangAnggota: widget.dataHutang?.idHutangAnggota,
      nominalBayar: widget.dataHutang?.nominal,
      tgBayar: formatDate(DateTime.now().toString()),
    );
    valueHutang = DetailDataHutangAnggota(
      idAnggota: widget.dataHutang?.idAnggota,
      idHutangAnggota: widget.dataHutang?.idHutangAnggota,
      nmAnggota: widget.dataHutang?.nmAnggota,
      tgHutang: widget.dataHutang?.tgHutang,
      idPenjualan: widget.dataHutang?.idPenjualan,
      nominal: widget.dataHutang?.nominal,
    );
    textController[0].text = formatDate(DateTime.now().toString());
    textController[1].text = formatMoney(dataEdit.nominalBayar);
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    textController[3].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: pelunasanHutangAnggotaKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tambah Pelunasan",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "Tanggal Pelunasan",
                    hintText: "Masukkan Tanggal Pelunasan",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    suffixIcon: iconCalendarMonth,
                    onTap: () async {
                      DateTime? selectedDate = await initSelectedDate(
                        initValue: formatDateTimeNow(dataEdit.tgBayar ?? DateTime.now().toString()),
                      );
                      if (selectedDate != null) {
                        dataEdit.tgBayar = selectedDate.toString();
                        textController[0].text = formatDate(selectedDate.toString());
                        update();
                      }
                    },
                    enabled: false,
                    readOnly: true,
                    textEditingController: textController[0],
                    // onChanged: (value) {
                    //   dataEdit.idSupplier = trimString(value);
                    //   update();
                    // },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseDropdownButton<DetailDataHutangAnggota>(
                    hint: "Pilih Nama Anggota",
                    label: "Nama Anggota",
                    sortItem: false,
                    itemAsString: (item) => item.hutangAnggotaAsString(),
                    items: widget.listHutang ?? [],
                    value: valueHutang,
                    enabled: true,
                    onChanged: (value) {
                      dataEdit = BayarHutangAnggotaPayload.fromJson(value?.toJson() ?? {});
                      dataEdit.tgBayar = formatDate(DateTime.now().toString());
                      textController[0].text = formatDate(DateTime.now().toString());
                      update();
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    prefix: const BasePrefixRupiah(),
                    label: "Nominal Pembayaran",
                    hintText: "Masukkan Nominal Pembayaran",
                    textEditingController: textController[1],
                    validator: Validatorless.required("Data Wajib Diisi"),
                    textInputFormater: [
                      ThousandsFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) {
                      dataEdit.nominalBayar = removeComma(trimString(value));
                      update();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    label: "Keterangan",
                    hintText: "Masukkan Keterangan",
                    textEditingController: textController[2],
                    onChanged: (value) {
                      dataEdit.keterangan = trimString(value);
                      update();
                    },
                  ),
                ),
              ],
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
                      if (pelunasanHutangAnggotaKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        if (trimString(dataEdit.keterangan).toString().isEmpty) {
                          payload.removeWhere((key, value) => key == "keterangan");
                        }
                        postBayarHutangAnggota(payload);
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
