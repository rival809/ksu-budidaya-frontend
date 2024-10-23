// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahPelunasan extends StatefulWidget {
  final String? idSupplier;
  final String? idTransaksi;
  final String? idHutangDagang;
  final String? nominal;

  const DialogTambahPelunasan({
    Key? key,
    required this.idSupplier,
    required this.idTransaksi,
    required this.idHutangDagang,
    required this.nominal,
  }) : super(key: key);

  @override
  State<DialogTambahPelunasan> createState() => _DialogTambahPelunasanState();
}

class _DialogTambahPelunasanState extends State<DialogTambahPelunasan> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  BayarHutangDagangPayload dataEdit = BayarHutangDagangPayload();

  final tambahPelunasanKey = GlobalKey<FormState>();

  HutangDagangResult result = HutangDagangResult();

  cariDataHutangDagang({
    required String supplierName,
  }) async {
    try {
      result = HutangDagangResult();
      DataMap dataCari = {};

      dataCari.addAll({"id_supplier": trimString(supplierName)});

      result = await ApiService.listHutangDagang(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));
      update();
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postBayarHutangDagang(DataMap dataCreate) async {
    showCircleDialogLoading();
    try {
      BayarHutangDagangResult result = await ApiService.bayarHutangDagang(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        router.push("/database/supplier");

        update();
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

  List<DataDetailHutangDagang> getDetailSuggestions(
      String query, List<DataDetailHutangDagang>? states) {
    List<DataDetailHutangDagang> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere((s) => trimString(s.idPembelian)
          .toLowerCase()
          .contains(query.toLowerCase()));
    }

    return matches;
  }

  @override
  void initState() {
    cariDataHutangDagang(supplierName: trimString(widget.idSupplier));
    dataEdit.tgBayar = formatDate(DateTime.now().toString());
    textController[0].text = formatDate(DateTime.now().toString());
    textController[1].text = formatMoney(widget.nominal);
    textController[2].clear();
    textController[3].text = trimString(widget.idTransaksi);
    dataEdit.idHutangDagang = trimString(widget.idHutangDagang);
    dataEdit.nominalBayar = trimString(widget.nominal);
    super.initState();
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
        key: tambahPelunasanKey,
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
                        initValue: formatDateTimeNow(
                            dataEdit.tgBayar ?? DateTime.now().toString()),
                      );
                      if (selectedDate != null) {
                        dataEdit.tgBayar = selectedDate.toString();
                        textController[0].text =
                            formatDate(selectedDate.toString());
                        update();
                      }
                    },
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
                  child: BaseDropdownButton<DataDetailSupplier>(
                    hint: "Pilih Nama Supplier",
                    label: "Nama Supplier",
                    itemAsString: (item) => item.supplierAsString(),
                    items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                    value: DataDetailSupplier(
                      idSupplier: widget.idSupplier,
                      nmSupplier:
                          getNamaSupplier(idSupplier: widget.idSupplier),
                    ),
                    onChanged: (value) {
                      cariDataHutangDagang(
                          supplierName: trimString(value?.idSupplier));
                      dataEdit.idHutangDagang = null;
                      textController[3].clear();

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
                  child: SearchForm(
                    label: "ID Transaksi",
                    enabled: true,
                    validator: Validatorless.required("Data Wajib DIisi"),
                    textEditingController: textController[3],
                    items: (search) => getDetailSuggestions(
                      search,
                      result.data?.dataHutangDagang,
                    ),
                    itemBuilder: (context, dataPembelian) {
                      return ListTile(
                        title: Text(trimString(dataPembelian.idPembelian)),
                      );
                    },
                    onChanged: (value) {
                      var data = result.data?.dataHutangDagang?.firstWhere(
                          (element) =>
                              element.idPembelian == trimString(value));
                      dataEdit.idHutangDagang =
                          trimString(data?.idHutangDagang);
                      textController[3].text = trimString(data?.idPembelian);
                      textController[1].text = formatMoney(data?.nominal);
                      dataEdit.nominalBayar =
                          removeComma(trimString(data?.nominal));
                      update();
                    },
                    onSelected: (data) {
                      dataEdit.idHutangDagang = trimString(data.idHutangDagang);
                      textController[3].text = trimString(data.idPembelian);
                      textController[1].text = formatMoney(data.nominal);
                      dataEdit.nominalBayar =
                          removeComma(trimString(data.nominal));

                      update();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    prefix: const BasePrefixRupiah(),
                    label: "Jumlah",
                    hintText: "Masukkan Jumlah",
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
                      if (tambahPelunasanKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        if (trimString(dataEdit.keterangan)
                            .toString()
                            .isEmpty) {
                          payload
                              .removeWhere((key, value) => key == "keterangan");
                        }
                        postBayarHutangDagang(payload);
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
