// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTutupKasir extends StatefulWidget {
  final DetailDataTutupKasir detail;
  final bool? isEdit;

  const DialogTutupKasir({
    Key? key,
    required this.detail,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<DialogTutupKasir> createState() => _DialogTutupKasirState();
}

class _DialogTutupKasirState extends State<DialogTutupKasir> {
  DetailDataTutupKasir dataEdit = DetailDataTutupKasir();
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  void initState() {
    dataEdit = widget.detail;
    textController[0].text = trimString(dataEdit.tgTutupKasir);
    textController[1].text = formatMoney(dataEdit.uangTunai);
    super.initState();
  }

  List<String> getSuggestions(String query, List<String>? states) {
    List<String> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere(
          (s) => trimString(s).toLowerCase().contains(query.toLowerCase()));
    }

    return matches;
  }

  final tutupKasirKey = GlobalKey<FormState>();

  postCreateTutupKasir(DataMap dataCreate) async {
    showCircleDialogLoading();
    try {
      TutupKasirResult result = await ApiService.createTutupKasir(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        router.push("/transaksi/tutup-kasir");
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postUpdateTutupKasir(DataMap dataCreate) async {
    showCircleDialogLoading();
    try {
      TutupKasirResult result = await ApiService.updateTutupKasir(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        router.push("/transaksi/tutup-kasir");
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: neutralWhite,
      ),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: tutupKasirKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tutup Kasir",
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
                        initValue: dataEdit.tgTutupKasir,
                      );

                      if (selectedDate != null) {
                        dataEdit.tgTutupKasir =
                            formatDateTime(selectedDate.toString());
                        textController[0].text =
                            formatDateTime(selectedDate.toString());
                        update();
                      }
                    },
                    label: "Tanggal",
                    hintText: "Masukkan Tanggal",
                    textInputFormater: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: Validatorless.required("Data Wajib Diisi"),
                    autoValidate: AutovalidateMode.onUserInteraction,
                    textEditingController: textController[0],
                    enabled: UserDatabase.userDatabase.data?.roleData?.idRole ==
                            "ROLE001"
                        ? widget.isEdit ?? true
                        : false,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseDropdownButton<String>(
                    label: "Shift",
                    hint: "Pilih Shift",
                    enabled: UserDatabase.userDatabase.data?.roleData?.idRole ==
                            "ROLE001"
                        ? widget.isEdit ?? true
                        : false,
                    sortItem: false,
                    itemAsString: (item) => item,
                    items: const ["PAGI", "SIANG"],
                    value: dataEdit.shift,
                    onChanged: (value) {
                      dataEdit.shift = value;
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
                  child: BaseDropdownButton<DataUsers>(
                    hint: "Pilih Kasir",
                    label: "Kasir",
                    enabled: UserDatabase.userDatabase.data?.roleData?.idRole ==
                            "ROLE001"
                        ? widget.isEdit ?? true
                        : false,
                    itemAsString: (item) => item.userAsString(),
                    items: ListUserDatabase.dataListUser.dataUsers ?? [],
                    value: dataEdit.namaKasir?.isEmpty ?? true
                        ? null
                        : DataUsers(username: dataEdit.namaKasir),
                    onChanged: (value) {
                      dataEdit.namaKasir = trimString(value?.username);
                      dataEdit.username = trimString(value?.username);
                      update();
                    },
                    autoValidate: AutovalidateMode.onUserInteraction,
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    prefix: const BasePrefixRupiah(),
                    label: "Nominal",
                    hintText: "Masukkan Nominal",
                    textInputFormater: [
                      ThousandsFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) {
                      dataEdit.uangTunai = removeComma(trimString(value));
                      update();
                    },
                    textEditingController: textController[1],
                    enabled: widget.isEdit ?? true,
                    validator: Validatorless.required("Data Wajib Diisi"),
                    autoValidate: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              width: Get.width,
              color: blueGray50,
              height: 1,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "Hasil Penjualan",
              style: myTextTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "TUNAI",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.tunai),
                    style: myTextTheme.bodyMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "QRIS",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.qris),
                    style: myTextTheme.bodyMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "KREDIT",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.kredit),
                    textAlign: TextAlign.end,
                    style: myTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            const DashedLinePriceCard(),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "TOTAL",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.total),
                    textAlign: TextAlign.end,
                    style: myTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              "Total Keuntungan",
              style: myTextTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Total Harga Beli",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.totalNilaiBeli),
                    textAlign: TextAlign.end,
                    style: myTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Total Harga Jual",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.totalNilaiJual),
                    textAlign: TextAlign.end,
                    style: myTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            const DashedLinePriceCard(),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "TOTAL KEUNTUNGAN",
                    style: myTextTheme.bodyMedium,
                  ),
                ),
                Text(
                  ":",
                  style: myTextTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    formatMoney(dataEdit.totalKeuntungan),
                    textAlign: TextAlign.end,
                    style: myTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    text: "Batal",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BasePrimaryButton(
                      text: "Simpan",
                      onPressed: widget.isEdit ?? true
                          ? () {
                              if (tutupKasirKey.currentState!.validate()) {
                                DataMap payload = dataEdit.toJson();
                                payload.removeWhere(
                                    (key, value) => key == "created_at");
                                payload.removeWhere(
                                    (key, value) => key == "updated_at");

                                if (widget.isEdit == true) {
                                  payload.removeWhere(
                                      (key, value) => key == "shift");
                                  payload.removeWhere(
                                      (key, value) => key == "tg_tutup_kasir");
                                  payload.removeWhere(
                                      (key, value) => key == "tunai");
                                  payload.removeWhere(
                                      (key, value) => key == "qris");
                                  payload.removeWhere(
                                      (key, value) => key == "kredit");
                                  payload.removeWhere((key, value) =>
                                      key == "total_nilai_jual");
                                  payload.removeWhere(
                                      (key, value) => key == "total");
                                  payload.removeWhere((key, value) =>
                                      key == "total_nilai_beli");
                                  payload.removeWhere((key, value) =>
                                      key == "total_keuntungan");
                                  postUpdateTutupKasir(payload);
                                } else {
                                  payload.removeWhere(
                                      (key, value) => key == "id_tutup_kasir");
                                  postCreateTutupKasir(payload);
                                }
                              }
                            }
                          : null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
