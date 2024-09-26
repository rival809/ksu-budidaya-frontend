import 'dart:developer';

import 'package:ksu_budidaya/core.dart';

class GlobalReference {
  roleReference() async {
    try {
      ListRoleResult result = await ApiService.listRole(
        data: {
          "page": "1",
          "size": "1000",
        },
      ).timeout(const Duration(seconds: 30));

      RoleDatabase.save(result.data ?? DataListRole());
    } catch (e) {
      log(e.toString());
    }
  }

  supplierReference() async {
    try {
      SupplierResult result = await ApiService.listSupplier(
        data: {
          "page": "1",
          "size": "1000",
        },
      ).timeout(const Duration(seconds: 30));

      SupplierDatabase.save(result.data ?? DataSupplier());
    } catch (e) {
      log(e.toString());
    }
  }

  divisiReference() async {
    try {
      DivisiResult result = await ApiService.listDivisi(
        data: {
          "page": "1",
          "size": "1000",
        },
      ).timeout(const Duration(seconds: 30));

      DivisiDatabase.save(result.data ?? DataDivisi());
    } catch (e) {
      log(e.toString());
    }
  }

  cashReference() async {
    try {
      RefCashResult result = await ApiService.listRefCashInOut(
        data: {
          "page": "1",
          "size": "1000",
        },
      ).timeout(const Duration(seconds: 30));

      RefCashDatabase.save(result);
    } catch (e) {
      log(e.toString());
    }
  }
}

getNamaRole({String? idRole}) {
  try {
    var dataRole = RoleDatabase.dataListRole.dataRoles;

    for (var i = 0; i < (dataRole?.length ?? 0); i++) {
      if (trimString(dataRole?[i].idRole) == trimString(idRole)) {
        return dataRole?[i].roleName;
      }
    }

    return idRole;
  } catch (e) {
    return idRole;
  }
}

getNamaSupplier({String? idSupplier}) {
  try {
    var dataSupplier = SupplierDatabase.dataSupplier.dataSupplier;

    for (var i = 0; i < (dataSupplier?.length ?? 0); i++) {
      if (trimString(dataSupplier?[i].idSupplier) == trimString(idSupplier)) {
        return dataSupplier?[i].nmSupplier;
      }
    }

    return idSupplier;
  } catch (e) {
    return idSupplier;
  }
}

getNamaDivisi({String? idDivisi}) {
  try {
    var dataDivisi = DivisiDatabase.dataDivisi.dataDivisi;

    for (var i = 0; i < (dataDivisi?.length ?? 0); i++) {
      if (trimString(dataDivisi?[i].idDivisi) == trimString(idDivisi)) {
        return dataDivisi?[i].nmDivisi;
      }
    }

    return idDivisi;
  } catch (e) {
    return idDivisi;
  }
}

getNamaCash({String? idCash}) {
  try {
    var dataCash = RefCashDatabase.refCashResult.data;

    for (var i = 0; i < (dataCash?.length ?? 0); i++) {
      if (trimString(dataCash?[i].idCash) == trimString(idCash)) {
        return dataCash?[i].nmCash;
      }
    }

    return idCash;
  } catch (e) {
    return idCash;
  }
}

getNamaJenis({String? idJenis, List<DataRefJenisCash>? data}) {
  try {
    for (var i = 0; i < (data?.length ?? 0); i++) {
      if (trimString(data?[i].idJenis.toString()) == trimString(idJenis)) {
        return data?[i].nmJenis;
      }
    }

    return idJenis;
  } catch (e) {
    return idJenis;
  }
}
