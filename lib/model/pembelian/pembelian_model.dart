import 'package:ksu_budidaya/core.dart';

class PembelianResult {
  bool? success;
  DataPembelian? data;
  String? message;

  PembelianResult({this.success, this.data, this.message});

  PembelianResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataPembelian.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DataPembelian {
  List<DetailDataPembelian>? dataPembelian;
  Paging? paging;

  DataPembelian({this.dataPembelian, this.paging});

  DataPembelian.fromJson(Map<String, dynamic> json) {
    if (json['data_pembelian'] != null) {
      dataPembelian = <DetailDataPembelian>[];
      json['data_pembelian'].forEach((v) {
        dataPembelian!.add(DetailDataPembelian.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataPembelian != null) {
      data['data_pembelian'] = dataPembelian!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class DetailDataPembelian {
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
  String? updatedAt;

  DetailDataPembelian(
      {this.idPembelian,
      this.tgPembelian,
      this.idSupplier,
      this.nmSupplier,
      this.jumlah,
      this.totalHargaBeli,
      this.totalHargaJual,
      this.jenisPembayaran,
      this.keterangan,
      this.createdAt,
      this.updatedAt});

  DetailDataPembelian.fromJson(Map<String, dynamic> json) {
    idPembelian = json['id_pembelian'];
    tgPembelian = json['tg_pembelian'];
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    jumlah = json['jumlah'];
    totalHargaBeli = json['total_harga_beli'];
    totalHargaJual = json['total_harga_jual'];
    jenisPembayaran = json['jenis_pembayaran'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pembelian'] = idPembelian;
    data['tg_pembelian'] = tgPembelian;
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['jumlah'] = jumlah;
    data['total_harga_beli'] = totalHargaBeli;
    data['total_harga_jual'] = totalHargaJual;
    data['jenis_pembayaran'] = jenisPembayaran;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  DetailDataPembelian copyWith({
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
      DetailDataPembelian(
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
}
