import 'dart:convert';
import 'package:ksu_budidaya/core.dart';

class ApiService {
  //CONFIG API
  static const String _baseUrl = AppConfig.domain; // DOMAIN DEV

  static final CancelToken cancelToken = CancelToken();
  static final Options options = Options(
    headers: {
      "Content-Type": "application/json",
      'Authorization': AppSession.token,
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

  //API USER MANAGEMENT
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

  ///END API CONTROL
}
