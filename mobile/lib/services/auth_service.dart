import 'package:dio/dio.dart';
import 'package:mobile/middleware/api_interceptor.dart';
import '../config/app_config.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// class AuthService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl))
//     ..interceptors.add(ApiInterceptor());

//   Future<User> login(String email, String password) async {
//     final response = await _dio.post(
//       "/api/auth/login",
//       data: {"email": email, "password": password},
//     );
//     // return User.fromJson(response.data);
//     return response.data;
//   }
// }

class AuthService {
  static const String baseUrl =
      'http://localhost:5000/api/user'; // change for real device

  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> register(
    String username,
    String password,
    String dept,
  ) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'dept': dept,
      }),
    );

    return jsonDecode(response.body);
  }
}
