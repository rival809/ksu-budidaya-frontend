class Dictionary {
  static List<Map<String, dynamic>> kodeMohonToKode = [
    {
      "kd_mohon1": "1",
      "kd_singkat": "P.U",
    },
    {
      "kd_mohon1": "2",
      "kd_singkat": "P.U.2",
    },
    {
      "kd_mohon1": "3",
      "kd_singkat": "B.R",
    },
    {
      "kd_mohon1": "4",
      "kd_singkat": "M.M",
    },
    {
      "kd_mohon1": "5",
      "kd_singkat": "P.U",
    },
    {
      "kd_mohon1": "6",
      "kd_singkat": "M.K",
    }
  ];

  static List<Map<String, dynamic>> kodeStatus = [
    {
      "value": "1",
      "label": "1 - Daftar",
    },
    {
      "value": "2",
      "label": "2 - Penetapan",
    },
    {
      "value": "3",
      "label": "3 - Bayar",
    },
    {
      "value": "4",
      "label": "4 - Sudah Cetak Sticker",
    },
  ];
  static List<Map<String, dynamic>> prosesEdit = [
    {
      "value": "ADD",
      "label": "Tambah",
    },
    {
      "value": "DELETE",
      "label": "Hapus",
    },
    {
      "value": "EDIT",
      "label": "Edit",
    },
  ];

  static List<String> defaultSubjek = [
    "id_subjek_pajak",
    "nm_pemilik",
    "al_pemilik",
    "no_ktp",
    "npwp",
    "nib",
    "npwpd",
    "kd_wil_subjek_pajak"
  ];
  static List<String> defaultObjek = [
    "id_objek_pajak",
    "no_ab1",
    "no_ab2",
    "no_ab3",
    "nm_merek_ab",
    "nm_model_ab",
    "th_buatan",
    "kd_merek_ab",
    "kd_wil"
  ];
  static List<String> defaultTransaksi = [
    "id_trnab",
    "no_ab1",
    "no_ab2",
    "no_ab3",
    "kd_status"
  ];
  static List<String> defaultReport = [
    "id_trnab",
    "kd_wil_proses",
    "nm_pemilik",
    "nm_user_koreksi",
    "kd_status"
  ];
  static List<String> defaultVerif = [
    "id_edit",
    "id_user_req",
    "ket1_req",
    "kd_wil_req",
    "table_edit_name",
    "proses_edit"
  ];

  static List<Map<String, dynamic>> namaLayanan = [
    {
      "kd_mohon": "100000",
      "nm_mohon": "Daftar Ulang",
      "nm_mohon_eri": "TELITI ULANG",
      "cardColor": 0xffE3F2FD,
      "cardTitleColor": 0xff1565C0,
      "cardBorderColor": 0xff1E88E5,
    },
    {
      "kd_mohon": "110000",
      "nm_mohon": "Daftar Ulang Pot Baru",
      "nm_mohon_eri": "TELITI ULANG",
      "cardColor": 0xffE3F2FD,
      "cardTitleColor": 0xff1565C0,
      "cardBorderColor": 0xff1E88E5,
    },
    {
      "kd_mohon": "210000",
      "nm_mohon": "Perubahan (Ubah Bentuk)",
      "nm_mohon_eri": "RUBAH BENTUK",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "220000",
      "nm_mohon": "Perubahan (Ubah Status)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "230000",
      "nm_mohon": "Perubahan (Ganti Nama)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "241000",
      "nm_mohon": "Perubahan (BBN-II -> Jual Beli)",
      "nm_mohon_eri": "GANTI PEMILIK",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "242000",
      "nm_mohon": "Perubahan (BBN-II -> Waris)",
      "nm_mohon_eri": "GANTI PEMILIK",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "243000",
      "nm_mohon": "Perubahan (BBN-II -> Hibah)",
      "nm_mohon_eri": "GANTI PEMILIK",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "250000",
      "nm_mohon": "Perubahan (Ganti Alamat)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "260000",
      "nm_mohon": "Perubahan (Ganti Warna)",
      "nm_mohon_eri": "RUBAH BENTUK",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "270000",
      "nm_mohon": "Perubahan (Ganti Nomor Polisi)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "280000",
      "nm_mohon": "Perubahan (Ganti Mesin)",
      "nm_mohon_eri": "RUBAH BENTUK",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "291000",
      "nm_mohon": "Perubahan (Duplikat -> STNK Hilang)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "292000",
      "nm_mohon": "Perubahan (Duplikat -> STNK Rusak)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "293000",
      "nm_mohon": "Perubahan (Ganti - TNKB)",
      "nm_mohon_eri": "PERGANTIAN",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "310000",
      "nm_mohon": "Kendaraan Baru (CKD)",
      "nm_mohon_eri": "KENDARAAN BARU",
      "cardColor": 0xffE6F6EC,
      "cardTitleColor": 0xff008444,
      "cardBorderColor": 0xff9BDBB3,
    },
    {
      "kd_mohon": "320000",
      "nm_mohon": "Kendaraan Baru (Build Up)",
      "nm_mohon_eri": "KENDARAAN BARU",
      "cardColor": 0xffE6F6EC,
      "cardTitleColor": 0xff008444,
      "cardBorderColor": 0xff9BDBB3,
    },
    {
      "kd_mohon": "330000",
      "nm_mohon": "EX Dump (TNI-POLRI)",
      "nm_mohon_eri": "KENDARAAN BARU DUMP TNI POLRI",
      "cardColor": 0xffE6F6EC,
      "cardTitleColor": 0xff008444,
      "cardBorderColor": 0xff9BDBB3,
    },
    {
      "kd_mohon": "411000",
      "nm_mohon": "Mutasi Masuk (Dalam Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffFFEBEE,
      "cardTitleColor": 0xffC62828,
      "cardBorderColor": 0xffEF9A9A,
    },
    {
      "kd_mohon": "412000",
      "nm_mohon": "Mutasi Masuk (Dalam Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffFFEBEE,
      "cardTitleColor": 0xffC62828,
      "cardBorderColor": 0xffEF9A9A,
    },
    {
      "kd_mohon": "421000",
      "nm_mohon": "Mutasi Masuk (Luar Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffFFEBEE,
      "cardTitleColor": 0xffC62828,
      "cardBorderColor": 0xffEF9A9A,
    },
    {
      "kd_mohon": "422000",
      "nm_mohon": "Mutasi Masuk (Luar Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffFFEBEE,
      "cardTitleColor": 0xffC62828,
      "cardBorderColor": 0xffEF9A9A,
    },
    {
      "kd_mohon": "500000",
      "nm_mohon": "Kurang Bayar",
      "nm_mohon_eri": "TELITI ULANG",
      "cardColor": 0xffFFF9E1,
      "cardTitleColor": 0xffFF7500,
      "cardBorderColor": 0xffFFE483,
    },
    {
      "kd_mohon": "611000",
      "nm_mohon": "Mutasi Keluar (Dalam Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffF3E5F5,
      "cardTitleColor": 0xff691B9A,
      "cardBorderColor": 0xffCE93D8,
    },
    {
      "kd_mohon": "612000",
      "nm_mohon": "Mutasi Keluar (Dalam Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffF3E5F5,
      "cardTitleColor": 0xff691B9A,
      "cardBorderColor": 0xffCE93D8,
    },
    {
      "kd_mohon": "621000",
      "nm_mohon": "Mutasi Keluar (Luar Provinsi -> Pemilik Tetap)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffF3E5F5,
      "cardTitleColor": 0xff691B9A,
      "cardBorderColor": 0xffCE93D8,
    },
    {
      "kd_mohon": "622000",
      "nm_mohon": "Mutasi Keluar (Luar Provinsi -> Ganti Pemilik)",
      "nm_mohon_eri": "MUTASI",
      "cardColor": 0xffF3E5F5,
      "cardTitleColor": 0xff691B9A,
      "cardBorderColor": 0xffCE93D8,
    },
  ];
}
