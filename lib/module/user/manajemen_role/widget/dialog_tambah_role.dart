// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';

class DialogTambahRole extends StatefulWidget {
  const DialogTambahRole({
    Key? key,
    this.dataRole,
    required this.isDetail,
  }) : super(key: key);

  final DataRoles? dataRole;
  final bool isDetail;

  @override
  State<DialogTambahRole> createState() => _DialogTambahRoleState();
}

class _DialogTambahRoleState extends State<DialogTambahRole> {
  TextEditingController namaRole = TextEditingController();

  GlobalKey<FormState> keyRole = GlobalKey<FormState>();

  DataRoles dataEdit = DataRoles();

  @override
  void initState() {
    dataEdit = widget.dataRole?.copyWith() ?? DataRoles();
    namaRole.text = trimString(widget.dataRole?.roleName);
    super.initState();
  }

  @override
  void dispose() {
    namaRole.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DataMap payload = {};
    dataEdit.toJson().forEach((key, value) {
      if (widget.dataRole?.toJson()[key] != value) {
        payload.addAll({key: value});
      }
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: keyRole,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Detail Role" : "Tambah Role",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            BaseForm(
              autoFocus: true,
              textEditingController: namaRole,
              label: "Nama Role",
              hintText: "Masukkan Nama Role",
              validator: Validatorless.required("Harus Diisi"),
              onChanged: (value) {
                dataEdit.roleName = trimString(value);
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: blueGray50,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "Aksesibilitas Menu",
              style: myTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsAnggota ?? (dataEdit.stsAnggota = false),
                    title: "Anggota",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsAnggota = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsStocktakeHarian ??
                        (dataEdit.stsStocktakeHarian = false),
                    title: "Stocktake Harian",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsStocktakeHarian = value;
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
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsPembayaranPinjaman ??
                        (dataEdit.stsPembayaranPinjaman = false),
                    title: "Pembayaran Pinjaman",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsPembayaranPinjaman = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsStockOpname ??
                        (dataEdit.stsStockOpname = false),
                    title: "Stock Opname",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsStockOpname = value;
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
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsKartuPiutang ??
                        (dataEdit.stsKartuPiutang = false),
                    title: "Kartu Piutang",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsKartuPiutang = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsCashInCashOut ??
                        (dataEdit.stsCashInCashOut = false),
                    title: "Cash In Cash Out",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsCashInCashOut = value;
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
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsSupplier ?? (dataEdit.stsSupplier = false),
                    title: "Supplier",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsSupplier = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsCashMovement ??
                        (dataEdit.stsCashMovement = false),
                    title: "Cash Movement",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsCashMovement = value;
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
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsDivisi ?? (dataEdit.stsDivisi = false),
                    title: "Divisi",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsDivisi = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsUser ?? (dataEdit.stsUser = false),
                    title: "User",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsUser = value;
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
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsProduk ?? (dataEdit.stsProduk = false),
                    title: "Produk",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsProduk = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsRole ?? (dataEdit.stsRole = false),
                    title: "Role",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsRole = value;
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
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsPembelian ??
                        (dataEdit.stsPembelian = false),
                    title: "Pembelian",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsPembelian = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsCetakLabel ??
                        (dataEdit.stsCetakLabel = false),
                    title: "Cetak Label",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsCetakLabel = value;
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
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsPenjualan ??
                        (dataEdit.stsPenjualan = false),
                    title: "Penjualan",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsPenjualan = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsCetakBarcode ??
                        (dataEdit.stsCetakBarcode = false),
                    title: "Cetak Barcode",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsCetakBarcode = value;
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
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsRetur ?? (dataEdit.stsRetur = false),
                    title: "Retur",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsRetur = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsAwalAkhirHari ??
                        (dataEdit.stsAwalAkhirHari = false),
                    title: "Awal dan Akhir Hari",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsAwalAkhirHari = value;
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
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsPembayaranHutang ??
                        (dataEdit.stsPembayaranHutang = false),
                    title: "Pembayaran Hutang Dagang",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsPembayaranHutang = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox: dataEdit.stsDashboard ??
                        (dataEdit.stsDashboard = false),
                    title: "Dashboard",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsDashboard = value;
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
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsEstimasi ?? (dataEdit.stsEstimasi = false),
                    title: "Estimasi",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsEstimasi = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: RowCheckbox(
                    statusCheckbox:
                        dataEdit.stsLaporan ?? (dataEdit.stsLaporan = false),
                    title: "Laporan",
                    onChanged: (value) {
                      setState(() {
                        dataEdit.stsLaporan = value;
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
                      Navigator.pop(context);
                      if (keyRole.currentState!.validate()) {
                        widget.isDetail
                            ? ManajemenRoleController.instance.postUpdateRole(
                                payload, trimString(dataEdit.idRole))
                            : ManajemenRoleController.instance
                                .postCreateRole(dataEdit);
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
