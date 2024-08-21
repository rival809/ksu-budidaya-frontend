import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogHasilVoucherDiskon extends StatefulWidget {
  final bool statusVoucher;

  const DialogHasilVoucherDiskon({
    Key? key,
    required this.statusVoucher,
  }) : super(key: key);

  @override
  State<DialogHasilVoucherDiskon> createState() => _DialogVoucherDiskonState();
}

class _DialogVoucherDiskonState extends State<DialogHasilVoucherDiskon> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 450,
          maxHeight: 284,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: ScrollController(),
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        widget.statusVoucher
                            ? "assets/images/illustration/voucher_ok.svg"
                            : "assets/images/illustration/voucher_fail.svg",
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        widget.statusVoucher
                            ? "Voucher berhasil digunakan"
                            : "Kode voucher tidak dapat digunakan",
                        style: myTextTheme.displaySmall?.copyWith(
                          color: gray900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      widget.statusVoucher
                          ? RichText(
                              text: TextSpan(
                                text: 'Diskon Bebas BBNKB II ',
                                style: myTextTheme.titleMedium?.copyWith(
                                  color: gray900,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Berhasil diterapkan',
                                    style: myTextTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              "Silakan periksa kembali kode voucher Anda.",
                              style: myTextTheme.bodyLarge,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color: gray50,
                    padding: const EdgeInsets.all(16),
                    child: PrimaryButton(
                      onPressed: () {
                        Get.back();
                      },
                      text: widget.statusVoucher
                          ? "Oke, saya mengerti"
                          : "Periksa Kembali",
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
