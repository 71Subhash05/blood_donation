import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/donor.dart';
import '../constants/app_constants.dart';

class ApiService {
  static const String baseUrl = AppConstants.baseUrl;

  static Future<List<Donor>> fetchDonors({String? village, String? bloodGroup}) async {
    try {
      String url = '$baseUrl/api/donors';
      List<String> params = [];
      
      if (village?.isNotEmpty == true) params.add('village=${Uri.encodeComponent(village!)}');
      if (bloodGroup?.isNotEmpty == true) params.add('bloodGroup=${Uri.encodeComponent(bloodGroup!)}');
      
      if (params.isNotEmpty) url += '?${params.join('&')}';
      
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Donor.fromJson(json)).toList();
      }
      throw Exception('Server error: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error: Please check connection');
    }
  }

  static Future<bool> addDonor(Donor donor) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/donors'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(donor.toJson()),
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}