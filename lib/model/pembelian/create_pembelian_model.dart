import 'package:ksu_budidaya/core.dart';

class CreatePembelianModel {
  String? tgPembelian;
  String? idSupplier;
  String? nmSupplier;
  String? jumlah;
  String? totalHargaBeli;
  String? totalHargaJual;
  String? jenisPembayaran;
  String? keterangan;
  List<DataDetailPembelian>? details;

  CreatePembelianModel(
      {this.tgPembelian,
      this.idSupplier,
      this.nmSupplier,
      this.jumlah,
      this.totalHargaBeli,
      this.totalHargaJual,
      this.jenisPembayaran,
      this.keterangan,
      this.details});

  CreatePembelianModel.fromJson(Map<String, dynamic> json) {
    tgPembelian = json['tg_pembelian'];
    idSupplier = json['id_supplier'];
    nmSupplier = json['nm_supplier'];
    jumlah = json['jumlah'];
    totalHargaBeli = json['total_harga_beli'];
    totalHargaJual = json['total_harga_jual'];
    jenisPembayaran = json['jenis_pembayaran'];
    keterangan = json['keterangan'];
    if (json['details'] != null) {
      details = <DataDetailPembelian>[];
      json['details'].forEach((v) {
        details!.add(DataDetailPembelian.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tg_pembelian'] = tgPembelian;
    data['id_supplier'] = idSupplier;
    data['nm_supplier'] = nmSupplier;
    data['jumlah'] = jumlah;
    data['total_harga_beli'] = totalHargaBeli;
    data['total_harga_jual'] = totalHargaJual;
    data['jenis_pembayaran'] = jenisPembayaran;
    data['keterangan'] = keterangan;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CreatePembelianModel copyWith({
    String? tgPembelian,
    String? idSupplier,
    String? nmSupplier,
    String? jumlah,
    String? totalHargaBeli,
    String? totalHargaJual,
    String? jenisPembayaran,
    String? keterangan,
    List<DataDetailPembelian>? details,
  }) =>
      CreatePembelianModel(
        tgPembelian: tgPembelian ?? this.tgPembelian,
        idSupplier: idSupplier ?? this.idSupplier,
        nmSupplier: nmSupplier ?? this.nmSupplier,
        jumlah: jumlah ?? this.jumlah,
        totalHargaBeli: totalHargaBeli ?? this.totalHargaBeli,
        totalHargaJual: totalHargaJual ?? this.totalHargaJual,
        jenisPembayaran: jenisPembayaran ?? this.jenisPembayaran,
        keterangan: keterangan ?? this.keterangan,
        details: details ?? this.details,
      );
}
