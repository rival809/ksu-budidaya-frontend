class DetailSessionModel {
  bool? success;
  DataDetailSession? data;
  String? message;

  DetailSessionModel({this.success, this.data, this.message});

  DetailSessionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataDetailSession.fromJson(json['data']) : null;
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

class DataDetailSession {
  String? idStocktakeSession;
  String? stocktakeType;
  String? status;
  double? idTutupKasir;
  String? shift;
  String? tgStocktake;
  String? usernameKasir;
  String? namaKasir;
  String? usernameReviewer;
  String? namaReviewer;
  double? totalItems;
  double? totalCounted;
  double? totalVariance;
  String? notesKasir;
  String? notesReviewer;
  String? submittedAt;
  String? reviewedAt;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  TutupKasir? tutupKasir;
  Statistics? statistics;
  ValuasiSummary? valuasiSummary;

  DataDetailSession(
      {this.idStocktakeSession,
      this.stocktakeType,
      this.status,
      this.idTutupKasir,
      this.shift,
      this.tgStocktake,
      this.usernameKasir,
      this.namaKasir,
      this.usernameReviewer,
      this.namaReviewer,
      this.totalItems,
      this.totalCounted,
      this.totalVariance,
      this.notesKasir,
      this.notesReviewer,
      this.submittedAt,
      this.reviewedAt,
      this.completedAt,
      this.createdAt,
      this.updatedAt,
      this.tutupKasir,
      this.statistics,
      this.valuasiSummary});

  DataDetailSession.fromJson(Map<String, dynamic> json) {
    idStocktakeSession = json['id_stocktake_session'];
    stocktakeType = json['stocktake_type'];
    status = json['status'];
    idTutupKasir = json['id_tutup_kasir'];
    shift = json['shift'];
    tgStocktake = json['tg_stocktake'];
    usernameKasir = json['username_kasir'];
    namaKasir = json['nama_kasir'];
    usernameReviewer = json['username_reviewer'];
    namaReviewer = json['nama_reviewer'];
    totalItems = json['total_items'];
    totalCounted = json['total_counted'];
    totalVariance = json['total_variance'];
    notesKasir = json['notes_kasir'];
    notesReviewer = json['notes_reviewer'];
    submittedAt = json['submitted_at'];
    reviewedAt = json['reviewed_at'];
    completedAt = json['completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tutupKasir = json['tutupKasir'] != null ? TutupKasir.fromJson(json['tutupKasir']) : null;
    statistics = json['statistics'] != null ? Statistics.fromJson(json['statistics']) : null;
    valuasiSummary =
        json['valuasi_summary'] != null ? ValuasiSummary.fromJson(json['valuasi_summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_stocktake_session'] = idStocktakeSession;
    data['stocktake_type'] = stocktakeType;
    data['status'] = status;
    data['id_tutup_kasir'] = idTutupKasir;
    data['shift'] = shift;
    data['tg_stocktake'] = tgStocktake;
    data['username_kasir'] = usernameKasir;
    data['nama_kasir'] = namaKasir;
    data['username_reviewer'] = usernameReviewer;
    data['nama_reviewer'] = namaReviewer;
    data['total_items'] = totalItems;
    data['total_counted'] = totalCounted;
    data['total_variance'] = totalVariance;
    data['notes_kasir'] = notesKasir;
    data['notes_reviewer'] = notesReviewer;
    data['submitted_at'] = submittedAt;
    data['reviewed_at'] = reviewedAt;
    data['completed_at'] = completedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (tutupKasir != null) {
      data['tutupKasir'] = tutupKasir!.toJson();
    }
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    if (valuasiSummary != null) {
      data['valuasi_summary'] = valuasiSummary!.toJson();
    }
    return data;
  }
}

class TutupKasir {
  double? idTutupKasir;
  String? tgTutupKasir;
  String? shift;
  String? namaKasir;
  String? username;
  String? tunai;
  String? qris;
  String? kredit;
  String? total;
  String? uangTunai;
  String? totalNilaiJual;
  String? totalNilaiBeli;
  String? totalKeuntungan;
  String? createdAt;
  String? updatedAt;

  TutupKasir(
      {this.idTutupKasir,
      this.tgTutupKasir,
      this.shift,
      this.namaKasir,
      this.username,
      this.tunai,
      this.qris,
      this.kredit,
      this.total,
      this.uangTunai,
      this.totalNilaiJual,
      this.totalNilaiBeli,
      this.totalKeuntungan,
      this.createdAt,
      this.updatedAt});

  TutupKasir.fromJson(Map<String, dynamic> json) {
    idTutupKasir = json['id_tutup_kasir'];
    tgTutupKasir = json['tg_tutup_kasir'];
    shift = json['shift'];
    namaKasir = json['nama_kasir'];
    username = json['username'];
    tunai = json['tunai'];
    qris = json['qris'];
    kredit = json['kredit'];
    total = json['total'];
    uangTunai = json['uang_tunai'];
    totalNilaiJual = json['total_nilai_jual'];
    totalNilaiBeli = json['total_nilai_beli'];
    totalKeuntungan = json['total_keuntungan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_tutup_kasir'] = idTutupKasir;
    data['tg_tutup_kasir'] = tgTutupKasir;
    data['shift'] = shift;
    data['nama_kasir'] = namaKasir;
    data['username'] = username;
    data['tunai'] = tunai;
    data['qris'] = qris;
    data['kredit'] = kredit;
    data['total'] = total;
    data['uang_tunai'] = uangTunai;
    data['total_nilai_jual'] = totalNilaiJual;
    data['total_nilai_beli'] = totalNilaiBeli;
    data['total_keuntungan'] = totalKeuntungan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Statistics {
  double? totalItems;
  double? countedItems;
  double? pendingItems;
  double? flaggedItems;
  double? totalVariance;
  String? progressPercentage;

  Statistics(
      {this.totalItems,
      this.countedItems,
      this.pendingItems,
      this.flaggedItems,
      this.totalVariance,
      this.progressPercentage});

  Statistics.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    countedItems = json['counted_items'];
    pendingItems = json['pending_items'];
    flaggedItems = json['flagged_items'];
    totalVariance = json['total_variance'];
    progressPercentage = json['progress_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['counted_items'] = countedItems;
    data['pending_items'] = pendingItems;
    data['flagged_items'] = flaggedItems;
    data['total_variance'] = totalVariance;
    data['progress_percentage'] = progressPercentage;
    return data;
  }
}

class ValuasiSummary {
  double? totalValuasiSistemBeli;
  double? totalValuasiSistemJual;
  double? totalValuasiFisikBeli;
  double? totalValuasiFisikJual;
  double? totalValuasiSelisihBeli;
  double? totalValuasiSelisihJual;

  ValuasiSummary(
      {this.totalValuasiSistemBeli,
      this.totalValuasiSistemJual,
      this.totalValuasiFisikBeli,
      this.totalValuasiFisikJual,
      this.totalValuasiSelisihBeli,
      this.totalValuasiSelisihJual});

  ValuasiSummary.fromJson(Map<String, dynamic> json) {
    totalValuasiSistemBeli = json['total_valuasi_sistem_beli'];
    totalValuasiSistemJual = json['total_valuasi_sistem_jual'];
    totalValuasiFisikBeli = json['total_valuasi_fisik_beli'];
    totalValuasiFisikJual = json['total_valuasi_fisik_jual'];
    totalValuasiSelisihBeli = json['total_valuasi_selisih_beli'];
    totalValuasiSelisihJual = json['total_valuasi_selisih_jual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_valuasi_sistem_beli'] = totalValuasiSistemBeli;
    data['total_valuasi_sistem_jual'] = totalValuasiSistemJual;
    data['total_valuasi_fisik_beli'] = totalValuasiFisikBeli;
    data['total_valuasi_fisik_jual'] = totalValuasiFisikJual;
    data['total_valuasi_selisih_beli'] = totalValuasiSelisihBeli;
    data['total_valuasi_selisih_jual'] = totalValuasiSelisihJual;
    return data;
  }
}
