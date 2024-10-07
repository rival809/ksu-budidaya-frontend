// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogDetailProduk extends StatefulWidget {
  final DataDetailProduct? data;

  const DialogDetailProduk({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DialogDetailProduk> createState() => _DialogDetailProdukState();
}

class _DialogDetailProdukState extends State<DialogDetailProduk> {
  bool step1 = true;
  bool step2 = false;

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        break;
      case "2":
        step1 = false;
        step2 = true;
        break;

      default:
        step1 = true;
        step2 = false;
    }
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Produk",
            style: myTextTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ProsesStep(
            step1: step1,
            onTapStep1: () {
              onSwitchStep("1");
            },
            textStep1: "Detail",
            step2: step2,
            onTapStep2: () {
              onSwitchStep("2");
            },
            textStep2: "Movement",
          ),
          if (step1)
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
                  initialValue: trimString(widget.data?.idProduct),
                  enabled: false,
                ),
                BaseDropdownButton<DataDetailDivisi>(
                  hint: "Pilih Divisi",
                  enabled: false,
                  label: "Divisi",
                  itemAsString: (item) => item.divisiAsString(),
                  items: DivisiDatabase.dataDivisi.dataDivisi ?? [],
                  value: widget.data?.idDivisi?.isEmpty ?? true
                      ? null
                      : DataDetailDivisi(
                          idDivisi: widget.data?.idDivisi,
                          nmDivisi: trimString(
                            getNamaDivisi(
                              idDivisi: trimString(
                                widget.data?.idDivisi,
                              ),
                            ),
                          ),
                        ),
                  onChanged: (value) {},
                ),
                BaseForm(
                  label: "Nama Produk",
                  hintText: "Masukkan Nama Produk",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  initialValue: trimString(widget.data?.nmProduct),
                  enabled: false,
                ),
                BaseDropdownButton<DataDetailSupplier>(
                  hint: "Pilih Nama Supplier",
                  label: "Nama Supplier",
                  enabled: false,
                  itemAsString: (item) => item.supplierAsString(),
                  items: SupplierDatabase.dataSupplier.dataSupplier ?? [],
                  value: widget.data?.idSupplier?.isEmpty ?? true
                      ? null
                      : DataDetailSupplier(
                          idSupplier: widget.data?.idSupplier,
                          nmSupplier: trimString(
                            getNamaSupplier(
                                idSupplier:
                                    trimString(widget.data?.idSupplier)),
                          ),
                        ),
                  onChanged: (value) {},
                  autoValidate: AutovalidateMode.onUserInteraction,
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  label: "Harga Jual",
                  hintText: "Masukkan Harga Jual",
                  prefix: const BasePrefixRupiah(),
                  initialValue: formatMoney(trimString(widget.data?.hargaJual)),
                  enabled: false,
                ),
                BaseForm(
                  label: "Harga Beli",
                  hintText: "Masukkan Harga Beli",
                  prefix: const BasePrefixRupiah(),
                  initialValue: formatMoney(trimString(widget.data?.hargaBeli)),
                  enabled: false,
                ),
                SimpleDropdownButton(
                  label: "Status",
                  hint: "Pilih Status",
                  enabled: false,
                  items: const ["Aktif", "Nonaktif"],
                  value:
                      widget.data?.statusProduct == true ? "Aktif" : "Nonaktif",
                  onChanged: (value) {
                    widget.data?.statusProduct =
                        value == "Aktif" ? true : false;
                    update();
                  },
                ),
                BaseForm(
                  label: "Jumlah",
                  hintText: "Masukkan Jumlah",
                  initialValue: trimString(widget.data?.jumlah.toString()),
                  enabled: false,
                ),
              ],
            ),
          if (step1)
            BaseForm(
              label: "Keterangan",
              hintText: "Masukkan Keterangan",
              textInputFormater: [
                UpperCaseTextFormatter(),
              ],
              initialValue: trimString(widget.data?.keterangan),
              enabled: false,
            ),
          const SizedBox(
            height: 16.0,
          ),
          BaseSecondaryButton(
            text: "Batal",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
