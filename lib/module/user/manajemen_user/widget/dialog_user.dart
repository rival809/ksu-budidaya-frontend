// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogUser extends StatefulWidget {
  final DetailUserResult? data;
  final bool isDetail;
  const DialogUser({
    Key? key,
    required this.data,
    required this.isDetail,
  }) : super(key: key);

  @override
  State<DialogUser> createState() => _DialogUserState();
}

class _DialogUserState extends State<DialogUser> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataDetailUser dataEdit = DataDetailUser();

  bool obsecure = true;

  @override
  void initState() {
    dataEdit = widget.data?.data?.copyWith() ?? DataDetailUser();
    textController[0].text = trimString(widget.data?.data?.name);
    textController[1].text = trimString(widget.data?.data?.username);
    textController[2].text = trimString(widget.data?.data?.password);
    super.initState();
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    super.dispose();
  }

  final userKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: userKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Detail User" : "Tambah User",
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
                    autoValidate: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      dataEdit.name = trimString(value);
                      update();
                    },
                    validator: Validatorless.required("Data Wajib Diisi"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    enabled: widget.isDetail ? false : true,
                    label: "Username",
                    hintText: "Masukkan Username",
                    textEditingController: textController[1],
                    autoValidate: AutovalidateMode.onUserInteraction,
                    validator: Validatorless.required("Data Wajib Diisi"),
                    onChanged: (value) {
                      dataEdit.username = trimString(value);
                      update();
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
                  child: BaseDropdownButton<DataRoles>(
                    hint: "Pilih Role",
                    label: "Role",
                    itemAsString: (item) => item.roleAsString(),
                    items: RoleDatabase.dataListRole.dataRoles ?? [],
                    value: dataEdit.idRole?.isEmpty ?? true
                        ? null
                        : DataRoles(
                            idRole: dataEdit.idRole,
                            roleName: trimString(
                              getNamaRole(idRole: trimString(dataEdit.idRole)),
                            ),
                          ),
                    onChanged: (value) {
                      dataEdit.idRole = trimString(value?.idRole);
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
                    label: "Kata Sandi",
                    hintText: "Masukkan Kata Sandi",
                    obsecure: obsecure,
                    suffixIcon: obsecure ? iconEyeOff : iconEyeOn,
                    textEditingController: textController[2],
                    autoValidate: AutovalidateMode.onUserInteraction,
                    validator: widget.isDetail
                        ? null
                        : Validatorless.required("Data Wajib Diisi"),
                    onChanged: (value) {
                      dataEdit.password = trimString(value);
                      update();
                    },
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
                      if (userKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();

                        payload.removeWhere(
                          (key, value) => key == "created_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "updated_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "token",
                        );

                        if (textController[2].text.isEmpty && widget.isDetail) {
                          payload.removeWhere(
                            (key, value) => key == "password",
                          );
                        }

                        widget.isDetail
                            ? ManajemenUserController.instance
                                .postUpdateUser(payload)
                            : ManajemenUserController.instance
                                .postCreateUser(payload);
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
