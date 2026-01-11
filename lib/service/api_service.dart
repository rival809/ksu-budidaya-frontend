import 'dart:convert';
import 'package:ksu_budidaya/core.dart';

class ApiService {
  //CONFIG API
  static const String _baseUrl = AppConfig.domain; // DOMAIN DEV

  static final CancelToken cancelToken = CancelToken();
  static final Options options = Options(
    headers: {
      "Content-Type": "application/json",
      'Authorization': "Bearer ${AppSession.token}",
    },
  );

  static Dio dio = Dio(
    BaseOptions(
      // baseUrl: Endpoints.baseURL,
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      DioInterceptors(),
    ]);

  //END CONFIG API

  //API USER
  static Future<LoginResult> login({
    required String username,
    required String password,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/users/login",
      data: {
        "username": username,
        "password": password,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return LoginResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to doLogin');
    }
  }

  ///END API Auth
  ///
  ///Start API Role
  static Future<ListRoleResult> listRole({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/roles/list-roles",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ListRoleResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listRole');
    }
  }

  static Future<CreateRoleResult> createRole({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/roles/create-role",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CreateRoleResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createRole');
    }
  }

  static Future<CreateRoleResult> removeRole({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/roles/remove-role",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CreateRoleResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeRole');
    }
  }

  static Future<CreateRoleResult> updateRole({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/roles/update-role",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CreateRoleResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateRole');
    }
  }

  static Future<ListUserResult> listUser({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/users/list-users",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ListUserResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listUser');
    }
  }

  static Future<DetailUserResult> detailUser({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/users/detail-user",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailUserResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailUser');
    }
  }

  static Future<DetailUserResult> updateUser({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/users/update-user",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailUserResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateUser');
    }
  }

  static Future<DetailUserResult> createUser({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/users",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailUserResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createUser');
    }
  }

  static Future<DetailUserResult> removeUser({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/users/remove-user",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailUserResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeUser');
    }
  }

  static Future<DivisiResult> listDivisi({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/divisi/list-divisi",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DivisiResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listUser');
    }
  }

  static Future<DivisiResult> createDivisi({
    required String nmDivisi,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/divisi/create-divisi",
      options: options,
      data: {
        "nm_divisi": nmDivisi,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DivisiResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createUser');
    }
  }

  static Future<DivisiResult> updateDivisi({
    required String nmDivisi,
    required String idDivisi,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/divisi/update-divisi",
      options: options,
      data: {
        "nm_divisi": nmDivisi,
        "id_divisi": idDivisi,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DivisiResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateDivisi');
    }
  }

  static Future<DivisiResult> removeDivisi({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/divisi/remove-divisi",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DivisiResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeUser');
    }
  }

  static Future<AnggotaResult> listAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/anggota/list-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return AnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listAnggota');
    }
  }

  static Future<DetailAnggotaResult> detailAnggota({
    required String idAnggota,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/anggota/detail-anggota",
      options: options,
      data: {
        "id_anggota": idAnggota,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailAnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailAnggota');
    }
  }

  static Future<AnggotaResult> createAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/anggota/create-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return AnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createAnggota');
    }
  }

  static Future<AnggotaResult> removeAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/anggota/remove-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return AnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeAnggota');
    }
  }

  static Future<AnggotaResult> updateAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/anggota/update-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return AnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateAnggota');
    }
  }

  static Future<SupplierResult> listSupplier({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/suppliers/list-suppliers",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return SupplierResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listSupplier');
    }
  }

  static Future<SupplierResult> createSupplier({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/suppliers/create-supplier",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return SupplierResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createSupplier');
    }
  }

  static Future<SupplierResult> removeSupplier({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/suppliers/remove-supplier",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return SupplierResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeSupplier');
    }
  }

  static Future<SupplierResult> updateSupplier({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/suppliers/update-supplier",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return SupplierResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateSupplier');
    }
  }

  static Future<ProductResult> listProduct({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/products/list-products",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ProductResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listProduct');
    }
  }

  static Future<ProductResult> createProduct({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/products/create-product",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ProductResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createProduct');
    }
  }

  static Future<DetailProductResult> detailProduct({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/products/detail-product",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailProductResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailProduct');
    }
  }

  static Future<ProductResult> removeProduct({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/products/remove-product",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ProductResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeProduct');
    }
  }

  static Future<ProductResult> updateProduct({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/products/update-product",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ProductResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateProduct');
    }
  }

  static Future<CashInOutResult> listCashInOut({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/list-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CashInOutResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listCashInOut');
    }
  }

  static Future<RefCashResult> listRefCashInOut({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/list-ref-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return RefCashResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listCashInOut');
    }
  }

  static Future<RefJenisCashResult> listRefJenis({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/list-jenis-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return RefJenisCashResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listRefJenis');
    }
  }

  static Future<RefDetailCashResult> listRefDetail({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/list-detail-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return RefDetailCashResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listRefDetail');
    }
  }

  static Future<CashInOutResult> createCashInOut({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/create-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CashInOutResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createCashInOut');
    }
  }

  static Future<CashInOutResult> removeCashInOut({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/remove-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CashInOutResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeCashInOut');
    }
  }

  static Future<CashInOutResult> updateCashInOut({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/cash-in-out/update-cash",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return CashInOutResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateCashInOut');
    }
  }

  static Future<PembelianResult> listPembelian({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/purchase/list-purchase",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return PembelianResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listPembelian');
    }
  }

  static Future<DetailPembelianResult> detailPembelian({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/purchase/detail-purchase",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailPembelianResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailPembelian');
    }
  }

  static Future<PembelianResult> removePembelian({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/purchase/remove-purchase",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return PembelianResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removePembelian');
    }
  }

  static Future<PembelianResult> createPembelian({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/purchase/create-purchase",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return PembelianResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createPembelian');
    }
  }

  //Retur
  static Future<ReturResult> listRetur({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/retur/list-retur",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ReturResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listRetur');
    }
  }

  static Future<DetailReturResult> detailRetur({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/retur/detail-retur",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailReturResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailRetur');
    }
  }

  static Future<ReturResult> removeRetur({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/retur/remove-retur",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ReturResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeRetur');
    }
  }

  static Future<ReturResult> createRetur({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/retur/create-retur",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ReturResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createRetur');
    }
  }

  static Future<PenjualanResult> listPenjualan({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/sale/list-sale",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return PenjualanResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listPenjualan');
    }
  }

  static Future<ListTutupKasirResult> listTutupKasir({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/tutup-kasir/list-tutup-kasir",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ListTutupKasirResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listTutupKasir');
    }
  }

  static Future<TutupKasirResult> createTutupKasir({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/tutup-kasir/create-tutup-kasir",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return TutupKasirResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createTutupKasir');
    }
  }

  static Future<TutupKasirResult> updateTutupKasir({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/tutup-kasir/update-tutup-kasir",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return TutupKasirResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateTutupKasir');
    }
  }

  static Future<TotalPenjualanResult> totalPenjualan({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/tutup-kasir/total-penjualan",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return TotalPenjualanResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to totalPenjualan');
    }
  }

  static Future<TutupKasirResult> removeTutupKasir({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/tutup-kasir/remove-tutup-kasir",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return TutupKasirResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removeTutupKasir');
    }
  }

  static Future<TutupKasirResult> refreshTutupKasir({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/tutup-kasir/refresh-tutup-kasir",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return TutupKasirResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to refreshTutupKasir');
    }
  }

  static Future<DetailPenjualanResult> detailPenjualan({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/sale/detail-sale",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailPenjualanResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailPembelian');
    }
  }

  static Future<PenjualanResult> createPenjualan({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/sale/create-sale",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return PenjualanResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createPenjualan');
    }
  }

  static Future<PenjualanResult> removePenjualan({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/sale/remove-sale",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return PenjualanResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to removePenjualan');
    }
  }

  static Future<IncomeDashboardResult> incomeDashboard() async {
    var response = await dio.post(
      "$_baseUrl/api/dashboard/income-dashboard",
      options: options,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return IncomeDashboardResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to incomeDashboard');
    }
  }

  static Future<IncomeMonthlyResult> incomeMonthly({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/dashboard/income-monthly",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return IncomeMonthlyResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to incomeMonthly');
    }
  }

  static Future<LaporanHasilUsahaResult> laporanHasilUsaha({
    required String month,
    required String year,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/laporan/hasil-usaha",
      options: options,
      data: {
        "month": month,
        "year": year,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return LaporanHasilUsahaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to laporanHasilUsaha');
    }
  }

  static Future<LaporanNeracaModel> laporanNeraca({
    required String month,
    required String year,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/laporan/neraca",
      options: options,
      data: {
        "month": month,
        "year": year,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return LaporanNeracaModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to laporanNeraca');
    }
  }

  static Future<LaporanNeracaLajurModel> laporanNeracaLajur({
    required String month,
    required String year,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/laporan/neraca-lajur",
      options: options,
      data: {
        "month": month,
        "year": year,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        // final mockResponse = await rootBundle.loadString('assets/res_neraca_lajur.json');
        // return LaporanNeracaLajurModel.fromJson(json.decode(mockResponse));
        return LaporanNeracaLajurModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to load laporanNeracaLajur');
    }
  }

  static Future<LaporanRealisasiPendapatanResult> laporanRealisasiPendapatan({
    required String year,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/laporan/realisasi-pendapatan",
      options: options,
      data: {
        "year": year,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return LaporanRealisasiPendapatanResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to laporanRealisasiPendapatan');
    }
  }

  static Future<LaporanPenjualanModel> laporanPenjualan({
    required String startDate,
    required String endDate,
    String? metodePembayaran,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/laporan/penjualan",
      options: options,
      data: metodePembayaran == null
          ? {
              "start_date": startDate,
              "end_date": endDate,
            }
          : {
              "start_date": startDate,
              "end_date": endDate,
              "metode_pembayaran": metodePembayaran,
            },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return LaporanPenjualanModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to laporanPenjualan');
    }
  }

  //HutangDAgang
  static Future<HutangDagangResult> listHutangDagang({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/hutang-dagang/list-hutang-dagang",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return HutangDagangResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listHutangDagang');
    }
  }

  static Future<HistoryHutangDagangResult> listHistoryHutangDagang({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/hutang-dagang/list-history-bayar-hutang-dagang",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return HistoryHutangDagangResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listHistoryHutangDagang');
    }
  }

  static Future<BayarHutangDagangResult> bayarHutangDagang({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/hutang-dagang/bayar-hutang-dagang",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return BayarHutangDagangResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to bayarHutangDagang');
    }
  }

  // //HutangDAgang
  static Future<HutangAnggotaResult> listHutangAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/hutang-anggota/list-hutang-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return HutangAnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listHutangDagang');
    }
  }

  static Future<HistoryHutangAnggotaResult> listHistoryHutangAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/hutang-anggota/list-history-bayar-hutang-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return HistoryHutangAnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listHistoryHutangAnggota');
    }
  }

  static Future<BayarHutangAnggotaResult> bayarHutangAnggota({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/hutang-anggota/bayar-hutang-anggota",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return BayarHutangAnggotaResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to bayarHutangDagang');
    }
  }

  static Future<StockOpnameModel> createStockOpname({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stock/create-stock-opname",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return StockOpnameModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createStockOpname');
    }
  }

  static Future<HistoryStockOpnameModel> listHistoryStockOpname({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stock/history-stock-opname",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return HistoryStockOpnameModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listHistoryStockOpname');
    }
  }

  static Future<AktivitasStockModel> listAktivitasStock({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/products/aktivitas-stock",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return AktivitasStockModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listAktivitasStock');
    }
  }

  static Future<StockTakeResult> listStockTake({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stock/list-stock-take",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return StockTakeResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listStockTake');
    }
  }

  static Future<DetailStockTakeResult> detailStockTake({
    required DataMap data,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stock/detail-stock-take",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailStockTakeResult.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listStockTake');
    }
  }

  static Future<ListSessionModel> listSession({
    required DataMap data,
  }) async {
    var response = await dio.get(
      "$_baseUrl/api/stocktake/v2/sessions",
      options: options,
      queryParameters: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return ListSessionModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listSession');
    }
  }

  static Future<DetailSessionModel> detailSession({
    required String idSession,
  }) async {
    var response = await dio.get(
      "$_baseUrl/api/stocktake/v2/sessions/$idSession",
      options: options,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      if (response.data["success"] == true) {
        return DetailSessionModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to detailSession');
    }
  }

  static Future<DetailSessionModel> createSession({
    required String stocktakeType,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stocktake/v2/sessions",
      options: options,
      data: {
        "stocktake_type": stocktakeType,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return DetailSessionModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to createSession');
    }
  }

  static Future<ListStocktakeItemsModel> listStocktakeV2({
    required String idSession,
    required DataMap data,
  }) async {
    var response = await dio.get(
      "$_baseUrl/api/stocktake/v2/sessions/$idSession/items",
      options: options,
      queryParameters: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return ListStocktakeItemsModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to listStocktakeV2');
    }
  }

  static Future<UpdateSingleModel> updateSingleItem({
    required String idItem,
    //contoh isinya { "stok_fisik": 19, "notes": "0" }
    required DataMap data,
  }) async {
    var response = await dio.patch(
      "$_baseUrl/api/stocktake/v2/items/$idItem",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return UpdateSingleModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to updateSingleItem');
    }
  }

  static Future<UpdateSingleModel> cancelSo({
    required String reason,
    required String idSession,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stocktake/v2/sessions/$idSession/cancel",
      options: options,
      data: {
        "cancel_reason": reason,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return UpdateSingleModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to cancelSo');
    }
  }

  static Future<UpdateSingleModel> submitSo({
    required String reason,
    required String idSession,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stocktake/v2/sessions/$idSession/submit",
      options: options,
      data: {
        "notes_kasir": reason,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return UpdateSingleModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to submitSo');
    }
  }

  static Future<UpdateSingleModel> reviewSo({
    required String reason,
    required String action,
    required String idSession,
    List? revisionItems,
  }) async {
    DataMap data = {
      "action": action,
      "notes_reviewer": reason,
    };

    if (revisionItems?.isNotEmpty ?? false) {
      data["revision_items"] = revisionItems;
    }

    var response = await dio.post(
      "$_baseUrl/api/stocktake/v2/sessions/$idSession/review",
      options: options,
      data: data,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return UpdateSingleModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to reviewSo');
    }
  }

  static Future<UpdateSingleModel> finalizeSo({
    required String reason,
    required String idSession,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stocktake/v2/sessions/$idSession/finalize",
      options: options,
      data: {
        "confirmation": true,
        "notes_reviewer": reason,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return UpdateSingleModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to finalizeSo');
    }
  }

  static Future<ListHighRiskModel> getListHighRisk() async {
    var response = await dio.get(
      "$_baseUrl/api/stocktake/v2/high-risk-products",
      options: options,
      queryParameters: {
        "is_active": true,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return ListHighRiskModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to getListHighRisk');
    }
  }

  static Future<AddHighRiskModel> addHighRisk({
    required String id,
    required String category,
    required String reason,
  }) async {
    var response = await dio.post(
      "$_baseUrl/api/stocktake/v2/high-risk-products",
      options: options,
      data: {
        "id_product": id,
        "category": category,
        "reason": reason,
      },
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return AddHighRiskModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to addHighRisk');
    }
  }

  static Future<AddHighRiskModel> editHighRisk({
    required String id,
    required String category,
    required String reason,
  }) async {
    var response = await dio.patch(
      "$_baseUrl/api/stocktake/v2/high-risk-products/$id",
      options: options,
      data: {"category": category, "reason": reason, "is_active": true},
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return AddHighRiskModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to editHighRisk');
    }
  }

  static Future<DeleteHighRiskModel> deleteHighRisk({
    required String id,
  }) async {
    var response = await dio.delete(
      "$_baseUrl/api/stocktake/v2/high-risk-products/$id",
      options: options,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data["success"] == true) {
        return DeleteHighRiskModel.fromJson(json.decode(response.toString()));
      } else {
        throw Exception(response.data["message"]);
      }
    } else {
      throw Exception('Failed to deleteHighRisk');
    }
  }
}
