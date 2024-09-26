class DetailPembelianResult {
  bool? success;
  List<DataDetailPembelian>? data;
  String? message;

  DetailPembelianResult({this.success, this.data, this.message});

  DetailPembelianResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataDetailPembelian>[];
      json['data'].forEach((v) {
        data!.add(DataDetailPembelian.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class DataDetailPembelian {
  int? idDetailPembelian;
  String? idPembelian;
  String? idProduct;
  String? nmDivisi;
  String? nmProduk;
  String? hargaBeli;
  String? hargaJual;
  int? jumlah;
  String? diskon;
  String? ppn;
  String? totalNilaiBeli;
  String? totalNilaiJual;
  String? createdAt;
  String? updatedAt;

  DataDetailPembelian(
      {this.idDetailPembelian,
      this.idPembelian,
      this.idProduct,
      this.nmDivisi,
      this.nmProduk,
      this.hargaBeli,
      this.hargaJual,
      this.jumlah,
      this.diskon,
      this.ppn,
      this.totalNilaiBeli,
      this.totalNilaiJual,
      this.createdAt,
      this.updatedAt});

  DataDetailPembelian.fromJson(Map<String, dynamic> json) {
    idDetailPembelian = json['id_detail_pembelian'];
    idPembelian = json['id_pembelian'];
    idProduct = json['id_product'];
    nmDivisi = json['nm_divisi'];
    nmProduk = json['nm_produk'];
    hargaBeli = json['harga_beli'];
    hargaJual = json['harga_jual'];
    jumlah = json['jumlah'];
    diskon = json['diskon'];
    ppn = json['ppn'];
    totalNilaiBeli = json['total_nilai_beli'];
    totalNilaiJual = json['total_nilai_jual'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_detail_pembelian'] = idDetailPembelian;
    data['id_pembelian'] = idPembelian;
    data['id_product'] = idProduct;
    data['nm_divisi'] = nmDivisi;
    data['nm_produk'] = nmProduk;
    data['harga_beli'] = hargaBeli;
    data['harga_jual'] = hargaJual;
    data['jumlah'] = jumlah;
    data['diskon'] = diskon;
    data['ppn'] = ppn;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['total_nilai_jual'] = totalNilaiJual;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  DataDetailPembelian copyWith({
    int? idDetailPembelian,
    String? idPembelian,
    String? idProduct,
    String? nmDivisi,
    String? nmProduk,
    String? hargaBeli,
    String? hargaJual,
    int? jumlah,
    String? diskon,
    String? ppn,
    String? totalNilaiBeli,
    String? totalNilaiJual,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataDetailPembelian(
        idDetailPembelian: idDetailPembelian ?? this.idDetailPembelian,
        idPembelian: idPembelian ?? this.idPembelian,
        idProduct: idProduct ?? this.idProduct,
        nmDivisi: nmDivisi ?? this.nmDivisi,
        nmProduk: nmProduk ?? this.nmProduk,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaJual: hargaJual ?? this.hargaJual,
        jumlah: jumlah ?? this.jumlah,
        diskon: diskon ?? this.diskon,
        ppn: ppn ?? this.ppn,
        totalNilaiBeli: totalNilaiBeli ?? this.totalNilaiBeli,
        totalNilaiJual: totalNilaiJual ?? this.totalNilaiJual,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
