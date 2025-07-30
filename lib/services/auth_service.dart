import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/user.dart';

class AuthService {
  static const String baseUrl = AppConstants.baseUrl;

  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String userType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'userType': userType,
        }),
      ).timeout(const Duration(seconds: 10));

      final data = json.decode(response.body);
      
      if (response.statusCode == 201) {
        return {'success': true, 'user': User.fromJson(data['user'])};
      }
      return {'success': false, 'error': data['error'] ?? 'Registration failed'};
    } catch (e) {
      return {'success': false, 'error': 'Network error'};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 10));

      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        return {'success': true, 'user': User.fromJson(data['user'])};
      }
      return {'success': false, 'error': data['error'] ?? 'Login failed'};
    } catch (e) {
      return {'success': false, 'error': 'Network error'};
    }
  }
}