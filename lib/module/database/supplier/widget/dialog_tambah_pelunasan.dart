// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahPelunasan extends StatefulWidget {
  final DataDetailSupplier? data;

  const DialogTambahPelunasan({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DialogTambahPelunasan> createState() => _DialogTambahPelunasanState();
}

class _DialogTambahPelunasanState extends State<DialogTambahPelunasan> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataDetailSupplier dataEdit = DataDetailSupplier();

  final tambahPelunasanKey = GlobalKey<FormState>();

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailSupplier();
    textController[0].text = trimString(dataEdit.idSupplier);
    textController[1].text = trimString(dataEdit.nmSupplier);
    textController[2].text = trimString(dataEdit.nmPemilik);
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
                        initValue: DateTime.now().toString(),
                      );
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
                    value: dataEdit.idSupplier?.isEmpty ?? true
                        ? null
                        : DataDetailSupplier(
                            idSupplier: dataEdit.idSupplier,
                            nmSupplier: trimString(
                              getNamaSupplier(
                                  idSupplier: trimString(dataEdit.idSupplier)),
                            ),
                          ),
                    onChanged: (value) {
                      dataEdit.idSupplier = trimString(value?.idSupplier);
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
                  child: BaseDropdownButton<DataDetailSupplier>(
                    hint: "Pilih ID Transaksi",
                    label: "ID Transaksi",
                    itemAsString: (item) => item.supplierAsString(),
                    items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                    value: dataEdit.idSupplier?.isEmpty ?? true
                        ? null
                        : DataDetailSupplier(
                            idSupplier: dataEdit.idSupplier,
                            nmSupplier: trimString(
                              getNamaSupplier(
                                  idSupplier: trimString(dataEdit.idSupplier)),
                            ),
                          ),
                    onChanged: (value) {
                      dataEdit.idSupplier = trimString(value?.idSupplier);
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
                    label: "Jumlah",
                    hintText: "Masukkan Jumlah",
                    textEditingController: textController[1],
                    validator: Validatorless.required("Data Wajib Diisi"),
                    textInputFormater: [
                      ThousandsFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) {
                      // dataEdit.limitPinjaman = removeComma(trimString(value));
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
                dataEdit.alamat = trimString(value);
                update();
              },
              validator: Validatorless.required("Data Wajib Diisi"),
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
