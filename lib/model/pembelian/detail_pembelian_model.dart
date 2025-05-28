// To parse this JSON data, do
//
//     final detailPembelianResult = detailPembelianResultFromJson(jsonString);

import 'dart:convert';

import 'package:ksu_budidaya/core.dart';

DetailPembelianResult detailPembelianResultFromJson(String str) =>
    DetailPembelianResult.fromJson(json.decode(str));

String detailPembelianResultToJson(DetailPembelianResult data) => json.encode(data.toJson());

class DetailPembelianResult {
  bool? success;
  DataDetailPembelian? data;
  String? message;

  DetailPembelianResult({
    this.success,
    this.data,
    this.message,
  });

  DetailPembelianResult copyWith({
    bool? success,
    DataDetailPembelian? data,
    String? message,
  }) =>
      DetailPembelianResult(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DetailPembelianResult.fromJson(Map<String, dynamic> json) => DetailPembelianResult(
        success: json["success"],
        data: json["data"] == null ? null : DataDetailPembelian.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class DataDetailPembelian {
  ExistingPurchase? existingPurchase;
  List<DetailPurchase>? detailPurchase;

  DataDetailPembelian({
    this.existingPurchase,
    this.detailPurchase,
  });

  DataDetailPembelian copyWith({
    ExistingPurchase? existingPurchase,
    List<DetailPurchase>? detailPurchase,
  }) =>
      DataDetailPembelian(
        existingPurchase: existingPurchase ?? this.existingPurchase,
        detailPurchase: detailPurchase ?? this.detailPurchase,
      );

  factory DataDetailPembelian.fromJson(Map<String, dynamic> json) => DataDetailPembelian(
        existingPurchase: json["existing_purchase"] == null
            ? null
            : ExistingPurchase.fromJson(json["existing_purchase"]),
        detailPurchase: json["detail_purchase"] == null
            ? []
            : List<DetailPurchase>.from(
                json["detail_purchase"]!.map((x) => DetailPurchase.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "existing_purchase": existingPurchase?.toJson(),
        "detail_purchase": detailPurchase == null
            ? []
            : List<dynamic>.from(detailPurchase!.map((x) => x.toJson())),
      };
}

class DetailPurchase {
  String? idDetailPembelian;
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

  DetailPurchase({
    this.idDetailPembelian,
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
    this.updatedAt,
  });

  DetailPurchase copyWith({
    String? idDetailPembelian,
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
      DetailPurchase(
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

  factory DetailPurchase.fromJson(Map<String, dynamic> json) => DetailPurchase(
        idDetailPembelian: checkModel(json["id_detail_pembelian"]),
        idPembelian: json["id_pembelian"],
        idProduct: json["id_product"],
        nmDivisi: json["nm_divisi"],
        nmProduk: json["nm_produk"],
        hargaBeli: json["harga_beli"],
        hargaJual: json["harga_jual"],
        jumlah: json["jumlah"],
        diskon: json["diskon"],
        ppn: json["ppn"],
        totalNilaiBeli: json["total_nilai_beli"],
        totalNilaiJual: json["total_nilai_jual"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_detail_pembelian": idDetailPembelian,
        "id_pembelian": idPembelian,
        "id_product": idProduct,
        "nm_divisi": nmDivisi,
        "nm_produk": nmProduk,
        "harga_beli": hargaBeli,
        "harga_jual": hargaJual,
        "jumlah": jumlah,
        "diskon": diskon,
        "ppn": ppn,
        "total_nilai_beli": totalNilaiBeli,
        "total_nilai_jual": totalNilaiJual,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class ExistingPurchase {
  String? idPembelian;
  String? tgPembelian;
  String? idSupplier;
  String? nmSupplier;
  int? jumlah;
  String? totalHargaBeli;
  String? totalHargaJual;
  String? jenisPembayaran;
  String? keterangan;
  String? createdAt;
  dynamic updatedAt;

  ExistingPurchase({
    this.idPembelian,
    this.tgPembelian,
    this.idSupplier,
    this.nmSupplier,
    this.jumlah,
    this.totalHargaBeli,
    this.totalHargaJual,
    this.jenisPembayaran,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  ExistingPurchase copyWith({
    String? idPembelian,
    String? tgPembelian,
    String? idSupplier,
    String? nmSupplier,
    int? jumlah,
    String? totalHargaBeli,
    String? totalHargaJual,
    String? jenisPembayaran,
    String? keterangan,
    String? createdAt,
    String? updatedAt,
  }) =>
      ExistingPurchase(
        idPembelian: idPembelian ?? this.idPembelian,
        tgPembelian: tgPembelian ?? this.tgPembelian,
        idSupplier: idSupplier ?? this.idSupplier,
        nmSupplier: nmSupplier ?? this.nmSupplier,
        jumlah: jumlah ?? this.jumlah,
        totalHargaBeli: totalHargaBeli ?? this.totalHargaBeli,
        totalHargaJual: totalHargaJual ?? this.totalHargaJual,
        jenisPembayaran: jenisPembayaran ?? this.jenisPembayaran,
        keterangan: keterangan ?? this.keterangan,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ExistingPurchase.fromJson(Map<String, dynamic> json) => ExistingPurchase(
        idPembelian: json["id_pembelian"]!,
        tgPembelian: json["tg_pembelian"],
        idSupplier: json["id_supplier"],
        nmSupplier: json["nm_supplier"],
        jumlah: json["jumlah"],
        totalHargaBeli: json["total_harga_beli"],
        totalHargaJual: json["total_harga_jual"],
        jenisPembayaran: json["jenis_pembayaran"],
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_pembelian": idPembelian,
        "tg_pembelian": tgPembelian,
        "id_supplier": idSupplier,
        "nm_supplier": nmSupplier,
        "jumlah": jumlah,
        "total_harga_beli": totalHargaBeli,
        "total_harga_jual": totalHargaJual,
        "jenis_pembayaran": jenisPembayaran,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
