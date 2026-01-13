import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogHighRisk extends StatefulWidget {
  const DialogHighRisk({
    Key? key,
    required this.isEdit,
    required this.data,
  }) : super(key: key);

  final DataListHighRisk? data;
  final bool isEdit;

  @override
  State<DialogHighRisk> createState() => _DialogHighRiskState();
}

class _DialogHighRiskState extends State<DialogHighRisk> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataListHighRisk dataEdit = DataListHighRisk();

  final highRiskKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dataEdit = widget.data?.copyWith() ?? DataListHighRisk();
    textController[0].text = trimString(dataEdit.idProduct);
    textController[1].text = trimString(dataEdit.nmProduct);
    textController[2].text = trimString(dataEdit.category);
    textController[3].text = trimString(dataEdit.reason);
  }

  List<DataDetailProduct> getSuggestions(String search, List<DataDetailProduct>? items) {
    if (items == null) return [];

    List<DataDetailProduct> suggestions = [];
    if (search.isEmpty) {
      suggestions = items;
    } else {
      for (var item in items) {
        if (item.idProduct!.toLowerCase().contains(search.toLowerCase()) ||
            item.nmProduct!.toLowerCase().contains(search.toLowerCase())) {
          suggestions.add(item);
        }
      }
    }
    return suggestions;
  }

  void update() {
    if (mounted) {
      setState(() {});
    }
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
        key: highRiskKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isEdit ? "Edit Produk Rentan" : "Tambah Produk Rentan",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: SearchForm(
                    label: "ID Produk",
                    enabled: !widget.isEdit,
                    textEditingController: textController[0],
                    items: (search) => getSuggestions(
                      search,
                      ProductDatabase.productResult.data?.dataProduct,
                    ),
                    itemBuilder: (context, dataProduct) {
                      return ListTile(
                        title: Text(
                          "${trimString(dataProduct.idProduct)} - ${trimString(dataProduct.nmProduct)}",
                        ),
                      );
                    },
                    onSelected: (data) {
                      textController[0].text = trimString(data.idProduct);
                      textController[1].text = trimString(data.nmProduct);

                      textController[2].text = trimString(getNamaDivisi(
                        idDivisi: trimString(data.idDivisi),
                      ));
                      dataEdit.idProduct = trimString(data.idProduct);
                      dataEdit.nmProduct = trimString(data.nmProduct);
                      dataEdit.category = trimString(getNamaDivisi(
                        idDivisi: trimString(data.idDivisi),
                      ));
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: BaseForm(
                    label: "Nama Produk",
                    textEditingController: textController[1],
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "Kategori",
                    enabled: false,
                    hintText: "Masukkan Kategori",
                    textEditingController: textController[2],
                    onChanged: (value) {
                      dataEdit.category = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: BaseForm(
                    label: "Alasan",
                    hintText: "Masukkan Alasan",
                    textEditingController: textController[3],
                    onChanged: (value) {
                      dataEdit.reason = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: "Batal",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: BasePrimaryButton(
                    onPressed: () async {
                      if (highRiskKey.currentState!.validate()) {
                        if (widget.isEdit) {
                          HighRiskController.instance.updateHighRisk(
                            id: dataEdit.idHighRisk.toString(),
                            category: dataEdit.category ?? '',
                            reason: dataEdit.reason ?? '',
                          );
                        } else {
                          HighRiskController.instance.createHighRisk(
                            id: dataEdit.idProduct ?? '',
                            category: dataEdit.category ?? '',
                            reason: dataEdit.reason ?? '',
                          );
                        }
                      }
                    },
                    text: "Simpan",
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
