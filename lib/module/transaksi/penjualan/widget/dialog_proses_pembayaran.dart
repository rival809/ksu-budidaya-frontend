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
  FocusNode bayarFocus = FocusNode();

  final inputPenjualanKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bayarFocus.requestFocus();
    widget.controller.textControllerDialog[1].text =
        formatMoney(trimString(widget.controller.dataPenjualan.totalNilaiJual));
    widget.controller.hitBayar();
  }

  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;

    controller.hitBayar();
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
                controller.dataPenjualan.nmAnggota =
                    splitString(trimString(value), false);
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
              textEditingController: controller.textControllerDialog[1],
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
                controller.totalBayar =
                    removeComma(trimString(value.toString()));
                controller.update();
                update();
              },
              textEditingController: controller.textControllerDialog[2],
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
              textEditingController: controller.textControllerDialog[3],
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
              textEditingController: controller.textControllerDialog[4],
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
                      controller.dataPenjualan.jenisPembayaran = null;
                      controller.update();

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
                    onPressed: controller.totalKembali < 0
                        ? null
                        : () {
                            if (inputPenjualanKey.currentState!.validate()) {
                              controller.postCreatePenjualan();
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
