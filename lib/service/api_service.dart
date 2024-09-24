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

  static final Interceptor interceptor = InterceptorsWrapper(
    onError: (DioException error, ErrorInterceptorHandler handler) {
      throw Exception(error.response?.statusMessage);
    },
  );

  static Dio dio = Dio(
    BaseOptions(
      // baseUrl: Endpoints.baseURL,
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 5),
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
}
