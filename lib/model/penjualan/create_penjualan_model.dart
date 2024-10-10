class CreatePenjualanModel {
  String? tgPenjualan;
  String? jumlah;
  String? totalNilaiBeli;
  String? totalNilaiJual;
  String? idAnggota;
  String? nmAnggota;
  String? jenisPembayaran;
  String? username;
  String? keterangan;
  List<DetailsCreatePenjualan>? details;

  CreatePenjualanModel(
      {this.tgPenjualan,
      this.jumlah,
      this.totalNilaiBeli,
      this.totalNilaiJual,
      this.idAnggota,
      this.nmAnggota,
      this.jenisPembayaran,
      this.username,
      this.keterangan,
      this.details});

  CreatePenjualanModel.fromJson(Map<String, dynamic> json) {
    tgPenjualan = json['tg_penjualan'];
    jumlah = json['jumlah'];
    totalNilaiBeli = json['total_nilai_beli'];
    totalNilaiJual = json['total_nilai_jual'];
    idAnggota = json['id_anggota'];
    nmAnggota = json['nm_anggota'];
    jenisPembayaran = json['jenis_pembayaran'];
    username = json['username'];
    keterangan = json['keterangan'];
    if (json['details'] != null) {
      details = <DetailsCreatePenjualan>[];
      json['details'].forEach((v) {
        details!.add(DetailsCreatePenjualan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tg_penjualan'] = tgPenjualan;
    data['jumlah'] = jumlah;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['total_nilai_jual'] = totalNilaiJual;
    data['id_anggota'] = idAnggota;
    data['nm_anggota'] = nmAnggota;
    data['jenis_pembayaran'] = jenisPembayaran;
    data['username'] = username;
    data['keterangan'] = keterangan;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CreatePenjualanModel copyWith({
    String? tgPenjualan,
    String? jumlah,
    String? totalNilaiBeli,
    String? totalNilaiJual,
    String? idAnggota,
    String? nmAnggota,
    String? jenisPembayaran,
    String? username,
    String? keterangan,
    List<DetailsCreatePenjualan>? details,
  }) =>
      CreatePenjualanModel(
        tgPenjualan: tgPenjualan ?? this.tgPenjualan,
        jumlah: jumlah ?? this.jumlah,
        totalNilaiBeli: totalNilaiBeli ?? this.totalNilaiBeli,
        totalNilaiJual: totalNilaiJual ?? this.totalNilaiJual,
        idAnggota: idAnggota ?? this.idAnggota,
        nmAnggota: nmAnggota ?? this.nmAnggota,
        jenisPembayaran: jenisPembayaran ?? this.jenisPembayaran,
        username: username ?? this.username,
        keterangan: keterangan ?? this.keterangan,
        details: details ?? this.details,
      );
}

class DetailsCreatePenjualan {
  String? idProduct;
  String? nmDivisi;
  String? nmProduk;
  String? harga;
  String? hargaBeli;
  String? jumlah;
  String? diskon;
  String? total;

  DetailsCreatePenjualan(
      {this.idProduct,
      this.nmDivisi,
      this.nmProduk,
      this.harga,
      this.hargaBeli,
      this.jumlah,
      this.diskon,
      this.total});

  DetailsCreatePenjualan.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    nmDivisi = json['nm_divisi'];
    nmProduk = json['nm_produk'];
    harga = json['harga'];
    hargaBeli = json['harga_beli'];
    jumlah = json['jumlah'];
    diskon = json['diskon'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['nm_divisi'] = nmDivisi;
    data['nm_produk'] = nmProduk;
    data['harga'] = harga;
    data['harga_beli'] = hargaBeli;
    data['jumlah'] = jumlah;
    data['diskon'] = diskon;
    data['total'] = total;
    return data;
  }

  DetailsCreatePenjualan copyWith({
    String? idProduct,
    String? nmDivisi,
    String? nmProduk,
    String? harga,
    String? hargaBeli,
    String? jumlah,
    String? diskon,
    String? total,
  }) =>
      DetailsCreatePenjualan(
        idProduct: idProduct ?? this.idProduct,
        nmDivisi: nmDivisi ?? this.nmDivisi,
        nmProduk: nmProduk ?? this.nmProduk,
        harga: harga ?? this.harga,
        hargaBeli: harga ?? this.hargaBeli,
        jumlah: jumlah ?? this.jumlah,
        diskon: diskon ?? this.diskon,
        total: total ?? this.total,
      );
}
