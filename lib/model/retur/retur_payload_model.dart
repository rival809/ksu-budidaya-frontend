import 'package:ksu_budidaya/core.dart';

class ReturPayloadModel {
  String? tgRetur;
  String? idPembelian;
  String? idSupplier;
  String? nmSupplier;
  String? jumlah;
  String? totalNilaiBeli;
  String? keterangan;
  List<DetailsReturPayload>? details;

  ReturPayloadModel(
      {this.tgRetur,
      this.idPembelian,
      this.idSupplier,
      this.nmSupplier,
      this.jumlah,
      this.totalNilaiBeli,
      this.keterangan,
      this.details});

  ReturPayloadModel.fromJson(Map<String, dynamic> json) {
    tgRetur = json['tg_retur'];
    idPembelian = json['id_pembelian'];
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    jumlah = json['jumlah'];
    totalNilaiBeli = json['total_nilai_beli'];
    keterangan = json['keterangan'];
    if (json['details'] != null) {
      details = <DetailsReturPayload>[];
      json['details'].forEach((v) {
        details!.add(DetailsReturPayload.fromJson(v));
      });
    } else {
      details = [];
    }
  }

  ReturPayloadModel copyWith({
    String? tgRetur,
    String? idPembelian,
    String? idSupplier,
    String? nmSupplier,
    String? jumlah,
    String? totalNilaiBeli,
    String? keterangan,
    List<DetailsReturPayload>? details,
  }) =>
      ReturPayloadModel(
        tgRetur: tgRetur ?? this.tgRetur,
        idPembelian: idPembelian ?? this.idPembelian,
        idSupplier: idSupplier ?? this.idSupplier,
        nmSupplier: nmSupplier ?? this.nmSupplier,
        jumlah: jumlah ?? this.jumlah,
        totalNilaiBeli: totalNilaiBeli ?? this.totalNilaiBeli,
        keterangan: keterangan ?? this.keterangan,
        details: details ?? this.details,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tg_retur'] = tgRetur;
    data['id_pembelian'] = idPembelian;
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['jumlah'] = jumlah;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['keterangan'] = keterangan;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    } else {
      data['details'] = [];
    }
    return data;
  }
}

class DetailsReturPayload {
  String? nmDivisi;
  String? idProduct;
  String? nmProduk;
  String? hargaBeli;
  String? jumlah;
  String? totalNilaiBeli;

  DetailsReturPayload(
      {this.nmDivisi,
      this.idProduct,
      this.nmProduk,
      this.hargaBeli,
      this.jumlah,
      this.totalNilaiBeli});

  DetailsReturPayload.fromJson(Map<String, dynamic> json) {
    nmDivisi = json['nm_divisi'];
    idProduct = json['id_product'];
    nmProduk = json['nm_produk'];
    hargaBeli = json['harga_beli'];
    jumlah = checkModel(json['jumlah']);
    totalNilaiBeli = json['total_nilai_beli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nm_divisi'] = nmDivisi;
    data['id_product'] = idProduct;
    data['nm_produk'] = nmProduk;
    data['harga_beli'] = hargaBeli;
    data['jumlah'] = jumlah;
    data['total_nilai_beli'] = totalNilaiBeli;
    return data;
  }
}
