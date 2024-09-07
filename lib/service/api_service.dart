import 'dart:convert';
import 'package:ksu_budidaya/core.dart';

class ApiService {
  //CONFIG API
  //  static const String _baseUrl = AppConfig.baseUrl; // PROD
  // static const String _baseUrl = AppConfig.baseUrl; // DEV
  static const String _baseUrl = AppConfig.domain; // DOMAIN DEV
  // static final String idUser =
  //     UserDatabase.loginResult?.data?.dataUser?.id ?? "";

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
  //END CONFIG API

  //API USER MANAGEMENT
  static Future<LoginResult> login({
    required String username,
    required String password,
  }) async {
    Dio dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          throw Exception(error.response?.statusMessage);
        },
      ),
    );

    var response = await dio.post(
      "$_baseUrl/api/users/login",
      // options: Options(
      //     // headers: {
      //     //   "Content-Type": "application/json",
      //     // },
      //     ),
      data: {
        "username": "admin",
        "password": "rahasia",
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
