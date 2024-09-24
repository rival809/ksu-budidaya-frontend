import 'dart:developer';

import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/database/suplier/supplier_database.dart';

class GlobalReference {
  roleReference() async {
    try {
      ListRoleResult result = await ApiService.listRole(
        data: {
          "page": "1",
          "size": "100",
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
          "size": "100",
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
          "size": "100",
        },
      ).timeout(const Duration(seconds: 30));

      DivisiDatabase.save(result.data ?? DataDivisi());
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
