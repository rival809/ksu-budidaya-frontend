class UpdateSingleModel {
  bool? success;
  DataUpdateSingleModel? data;
  String? message;

  UpdateSingleModel({this.success, this.data, this.message});

  UpdateSingleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataUpdateSingleModel.fromJson(json['data']) : null;
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

class DataUpdateSingleModel {
  int? idStocktakeItem;
  String? idStocktakeSession;
  String? idProduct;
  String? nmProduct;
  String? nmDivisi;
  String? hargaBeli;
  String? hargaJual;
  int? stokSistem;
  int? stokFisik;
  int? selisih;
  bool? isCounted;
  bool? isFlagged;
  String? flagReason;
  bool? isHighRisk;
  bool? hasTransaction;
  String? notes;
  String? countedAt;
  String? createdAt;
  String? updatedAt;

  DataUpdateSingleModel(
      {this.idStocktakeItem,
      this.idStocktakeSession,
      this.idProduct,
      this.nmProduct,
      this.nmDivisi,
      this.hargaBeli,
      this.hargaJual,
      this.stokSistem,
      this.stokFisik,
      this.selisih,
      this.isCounted,
      this.isFlagged,
      this.flagReason,
      this.isHighRisk,
      this.hasTransaction,
      this.notes,
      this.countedAt,
      this.createdAt,
      this.updatedAt});

  DataUpdateSingleModel.fromJson(Map<String, dynamic> json) {
    idStocktakeItem = json['id_stocktake_item'];
    idStocktakeSession = json['id_stocktake_session'];
    idProduct = json['id_product'];
    nmProduct = json['nm_product'];
    nmDivisi = json['nm_divisi'];
    hargaBeli = json['harga_beli'];
    hargaJual = json['harga_jual'];
    stokSistem = json['stok_sistem'];
    stokFisik = json['stok_fisik'];
    selisih = json['selisih'];
    isCounted = json['is_counted'];
    isFlagged = json['is_flagged'];
    flagReason = json['flag_reason'];
    isHighRisk = json['is_high_risk'];
    hasTransaction = json['has_transaction'];
    notes = json['notes'];
    countedAt = json['counted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_stocktake_item'] = idStocktakeItem;
    data['id_stocktake_session'] = idStocktakeSession;
    data['id_product'] = idProduct;
    data['nm_product'] = nmProduct;
    data['nm_divisi'] = nmDivisi;
    data['harga_beli'] = hargaBeli;
    data['harga_jual'] = hargaJual;
    data['stok_sistem'] = stokSistem;
    data['stok_fisik'] = stokFisik;
    data['selisih'] = selisih;
    data['is_counted'] = isCounted;
    data['is_flagged'] = isFlagged;
    data['flag_reason'] = flagReason;
    data['is_high_risk'] = isHighRisk;
    data['has_transaction'] = hasTransaction;
    data['notes'] = notes;
    data['counted_at'] = countedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
