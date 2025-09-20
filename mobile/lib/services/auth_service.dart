import 'package:dio/dio.dart';
import 'package:mobile/middleware/api_interceptor.dart';
import '../config/app_config.dart';
import '../models/user.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl))
    ..interceptors.add(ApiInterceptor());

  Future<User> login(String email, String password) async {
    final response = await _dio.post(
      "/api/auth/login",
      data: {"email": email, "password": password},
    );
    // return User.fromJson(response.data);
    return response.data;
  }
}
