// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogUser extends StatefulWidget {
  const DialogUser({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogUser> createState() => _DialogUserState();
}

class _DialogUserState extends State<DialogUser> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  bool obsecure = true;

  @override
  void initState() {
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tambah User",
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
                  label: "Nama",
                  hintText: "Masukkan Nama",
                  textEditingController: textController[0],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: BaseForm(
                  label: "Username",
                  hintText: "Masukkan Username",
                  textEditingController: textController[1],
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
                child: BaseForm(
                  label: "Role",
                  hintText: "Masukkan Role",
                  textEditingController: textController[2],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: BaseForm(
                  label: "Kata Sandi",
                  hintText: "Masukkan Kata Sandi",
                  obsecure: obsecure,
                  suffixIcon: obsecure ? iconEyeOff : iconEyeOn,
                  textEditingController: textController[3],
                  onTapSuffix: () {
                    setState(() {
                      obsecure = !obsecure;
                      // update();
                    });
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
                    showDialogBase(
                      context: context,
                      content: const DialogBerhasil(),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
