// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahRole extends StatefulWidget {
  const DialogTambahRole({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogTambahRole> createState() => _DialogTambahRoleState();
}

class _DialogTambahRoleState extends State<DialogTambahRole> {
  TextEditingController namaRole = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    namaRole.dispose();
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
            "Tambah Role",
            style: myTextTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          BaseForm(
            textEditingController: namaRole,
            label: "Nama Role",
            hintText: "Masukkan Nama Role",
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
                  statusCheckbox: false,
                  title: "Anggota",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Stocktake Harian",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Pembayaran Pinjaman",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Stock Opname",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Kartu Piutang",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Cash In Cash Out",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Supplier",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Cash Movement",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Divisi",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "User",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Produk",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Role",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Pembelian",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Cetak Label",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Penjualan",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Cetak Barcode",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Retur",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Awal dan Akhir Hari",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Pembayaran Hutang Dagang",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Dashboard",
                  onChanged: (value) {},
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
                  statusCheckbox: false,
                  title: "Estimasi",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: RowCheckbox(
                  statusCheckbox: false,
                  title: "Laporan",
                  onChanged: (value) {},
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
