// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogDetailSupplier extends StatefulWidget {
  const DialogDetailSupplier({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DataDetailSupplier? data;

  @override
  State<DialogDetailSupplier> createState() => _DialogDetailSupplierState();
}

class _DialogDetailSupplierState extends State<DialogDetailSupplier> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool step1 = true;
  bool step2 = false;
  bool step3 = false;

  Future<dynamic>? dataFuture;

  @override
  void initState() {
    textController[0].text = trimString(widget.data?.idSupplier);
    textController[1].text = trimString(widget.data?.nmSupplier);
    textController[2].text = trimString(widget.data?.nmPemilik);
    textController[3].text = trimString(widget.data?.alamat);
    super.initState();
  }

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        step3 = false;
        break;
      case "2":
        step1 = false;
        step2 = true;
        step3 = false;
        break;
      case "3":
        step1 = false;
        step2 = false;
        step3 = true;
        break;
      default:
        step1 = true;
        step2 = false;
        step3 = false;
    }
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Supplier",
            style: myTextTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              color: gray100,
              border: Border.all(
                width: 1.0,
                color: blueGray50,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(iconInfo),
                const SizedBox(
                  width: 8.0,
                ),
                OneData(
                  title: "ID SUPLIER",
                  subtitle: trimString(widget.data?.idSupplier),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                OneData(
                  title: "Nama Supplier",
                  subtitle: trimString(widget.data?.nmSupplier),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
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
            textStep2: "Produk",
            step3: step3,
            onTapStep3: () {
              onSwitchStep("3");
            },
            textStep3: "Transaksi",
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (step1)
            Column(
              children: [
                BaseForm(
                  label: "Pemilik",
                  hintText: "Masukkan Pemilik",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[0],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "Nama PIC",
                  hintText: "Masukkan Pemilik",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[1],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "No. Whatsapp",
                  hintText: "Masukkan No. Whatsapp",
                  textEditingController: textController[2],
                  textInputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BaseForm(
                  label: "Alamat",
                  hintText: "Masukkan Alamat",
                  textEditingController: textController[3],
                ),
              ],
            ),
          const SizedBox(
            height: 16.0,
          ),
          BaseSecondaryButton(
            text: "Kembali",
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
