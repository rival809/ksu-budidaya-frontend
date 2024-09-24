// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahProduk extends StatefulWidget {
  final DataDetailProduct? data;
  final bool isDetail;

  const DialogTambahProduk({
    Key? key,
    required this.data,
    required this.isDetail,
  }) : super(key: key);

  @override
  State<DialogTambahProduk> createState() => _DialogTambahProdukState();
}

class _DialogTambahProdukState extends State<DialogTambahProduk> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataDetailProduct dataEdit = DataDetailProduct();

  final productKey = GlobalKey<FormState>();

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailProduct();
    textController[0].text = trimString(widget.data?.idProduct);
    textController[1].text = trimString(widget.data?.nmProduct);
    textController[2].text = formatMoney(trimString(widget.data?.hargaJual));
    textController[3].text = formatMoney(trimString(widget.data?.hargaBeli));
    textController[4].text = trimString(widget.data?.jumlah.toString());
    textController[5].text = trimString(widget.data?.keterangan);
    super.initState();
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    textController[3].dispose();
    textController[4].dispose();
    textController[5].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: productKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Edit Produk" : "Tambah Produk",
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
                  label: "ID",
                  hintText: "Masukkan ID Product",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[0],
                  onChanged: (value) {
                    dataEdit.idProduct = trimString(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseDropdownButton<DataDetailDivisi>(
                  hint: "Pilih Divisi",
                  label: "Divisi",
                  itemAsString: (item) => item.divisiAsString(),
                  items: DivisiDatabase.dataDivisi.dataDivisi ?? [],
                  value: dataEdit.idDivisi?.isEmpty ?? true
                      ? null
                      : DataDetailDivisi(
                          idDivisi: dataEdit.idDivisi,
                          nmDivisi: trimString(
                            getNamaDivisi(
                              idDivisi: trimString(
                                dataEdit.idDivisi,
                              ),
                            ),
                          ),
                        ),
                  onChanged: (value) {
                    dataEdit.idDivisi = trimString(value?.idDivisi);
                    update();
                  },
                  autoValidate: AutovalidateMode.onUserInteraction,
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  label: "Nama Produk",
                  hintText: "Masukkan Nama Produk",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[1],
                  onChanged: (value) {
                    dataEdit.nmProduct = trimString(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseDropdownButton<DataDetailSupplier>(
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
                BaseForm(
                  label: "Harga Jual",
                  hintText: "Masukkan Harga Jual",
                  prefix: const BasePrefixRupiah(),
                  textEditingController: textController[2],
                  onChanged: (value) {
                    dataEdit.hargaJual = removeComma(trimString(value));
                    update();
                  },
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  label: "Harga Beli",
                  hintText: "Masukkan Harga Beli",
                  prefix: const BasePrefixRupiah(),
                  textEditingController: textController[3],
                  onChanged: (value) {
                    dataEdit.hargaBeli = removeComma(trimString(value));
                    update();
                  },
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                SimpleDropdownButton(
                  label: "Status",
                  hint: "Pilih Status",
                  items: const ["Aktif", "Nonaktif"],
                  value: dataEdit.statusProduct == true ? "Aktif" : "Nonaktif",
                  onChanged: (value) {
                    dataEdit.statusProduct = value == "Aktif" ? true : false;
                    update();
                  },
                ),
                BaseForm(
                  label: "Jumlah",
                  hintText: "Masukkan Jumlah",
                  textInputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textEditingController: textController[4],
                  onChanged: (value) {
                    dataEdit.jumlah = int.tryParse(trimString(value)) ?? 0;
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
              ],
            ),
            BaseForm(
              label: "Keterangan",
              hintText: "Masukkan Keterangan",
              textInputFormater: [
                UpperCaseTextFormatter(),
              ],
              textEditingController: textController[5],
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
                      if (productKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        payload.removeWhere(
                          (key, value) => key == "created_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "updated_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "total_jual",
                        );
                        payload.removeWhere(
                          (key, value) => key == "total_beli",
                        );

                        if (widget.isDetail) {
                          ProdukController.instance.postUpdateProduct(payload);
                        } else {
                          ProdukController.instance.postCreateProduct(payload);
                        }
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
