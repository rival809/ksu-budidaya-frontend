// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogProsesPembayaran extends StatefulWidget {
  final PenjualanController controller;
  const DialogProsesPembayaran({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DialogProsesPembayaran> createState() => _DialogProsesPembayaranState();
}

class _DialogProsesPembayaranState extends State<DialogProsesPembayaran> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  FocusNode bayarFocus = FocusNode();

  String? totalBayar = "0";
  final inputPenjualanKey = GlobalKey<FormState>();

  hitBayar() {
    var totalKembali = int.parse(removeComma(totalBayar ?? "0")) -
        int.parse(
            removeComma(widget.controller.dataPenjualan.totalNilaiJual ?? "0"));
    if (totalKembali < 0) {
      totalBayar = "0";
      textController[3].text = totalBayar ?? "0";
    } else {
      totalBayar = formatMoney(removeComma(totalKembali.toString()));
      textController[3].text = totalBayar ?? "0";
    }
  }

  @override
  void initState() {
    super.initState();
    bayarFocus.requestFocus();
    textController[1].text =
        formatMoney(trimString(widget.controller.dataPenjualan.totalNilaiJual));
  }

  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;

    hitBayar();
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: inputPenjualanKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Proses Pembayaran",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            SimpleDropdownButton(
              hint: "Pilih Anggota",
              label: "Anggota",
              onClear: () {
                controller.dataPenjualan.idAnggota = null;
                controller.dataPenjualan.nmAnggota = null;
                bayarFocus.requestFocus();
                controller.update();
                update();
              },
              items: setItemAnggota(),
              value: widget.controller.dataPenjualan.idAnggota?.isEmpty ?? true
                  ? null
                  : "${trimString(widget.controller.dataPenjualan.idAnggota)} - ${getNamaAnggota(idAnggota: trimString(widget.controller.dataPenjualan.idAnggota))}",
              onChanged: (value) {
                controller.dataPenjualan.idAnggota =
                    splitString(trimString(value), true);
                // controller.dataPenjualan.nmAnggota =
                //     splitString(trimString(value), false);
                bayarFocus.requestFocus();
                controller.update();
                update();
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ButtonFilter(
                  status: controller.statusTunai,
                  onTapFIlter: () {
                    controller.onSwitchStep("1");
                    bayarFocus.requestFocus();

                    update();
                  },
                  textFilter: "Tunai",
                  icon: iconUniversalCurrencyAlt,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                ButtonFilter(
                  status: controller.statusQris,
                  onTapFIlter: () {
                    controller.onSwitchStep("2");
                    bayarFocus.requestFocus();

                    update();
                  },
                  textFilter: "QRIS",
                  icon: iconQrCodeScanner,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                ButtonFilter(
                  status: controller.statusKredit,
                  onTapFIlter: () {
                    controller.onSwitchStep("3");
                    bayarFocus.requestFocus();

                    update();
                  },
                  textFilter: "Kredit",
                  icon: iconCreditCard,
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              prefix: const BasePrefixRupiah(),
              label: "Total",
              hintText: "Masukkan Total",
              textInputFormater: [
                ThousandsFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              textEditingController: textController[1],
              readOnly: true,
              enabled: true,
              validator: Validatorless.required("Data Wajib Diisi"),
              autoValidate: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              prefix: const BasePrefixRupiah(),
              label: "Bayar",
              focusNode: bayarFocus,
              hintText: "Masukkan Bayar",
              autoFocus: true,
              textInputFormater: [
                ThousandsFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              onChanged: (value) {
                totalBayar = removeComma(trimString(trimString(value)));
                update();
              },
              textEditingController: textController[2],
              enabled: true,
              validator: Validatorless.required("Data Wajib Diisi"),
              autoValidate: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              prefix: const BasePrefixRupiah(),
              label: "Kembali",
              hintText: "Masukkan Kembali",
              textInputFormater: [
                ThousandsFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              textEditingController: textController[3],
              enabled: false,
              validator: Validatorless.required("Data Wajib Diisi"),
              autoValidate: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              label: "Keterangan",
              hintText: "Masukkan Keterangan",
              textInputFormater: [
                UpperCaseTextFormatter(),
              ],
              textEditingController: textController[4],
              onChanged: (value) {
                controller.dataPenjualan.keterangan = trimString(value);
                controller.update();
                update();
              },
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
                    onPressed: () {
                      if (inputPenjualanKey.currentState!.validate()) {
                        controller.dataPenjualan.username = trimString(
                            UserDatabase.userDatabase.data?.userData?.username);
                        controller.dataPenjualan.jenisPembayaran =
                            trimString(controller.metodeBayar);
                        controller.dataPenjualan.tgPenjualan =
                            formatDateTimePayload(DateTime.now().toString());

                        showInfoDialog(
                            controller.dataPenjualan.toJson().toString(),
                            context);
                        print(controller.dataPenjualan.toJson());
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
