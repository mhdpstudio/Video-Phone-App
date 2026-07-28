import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  static const String baseUrl =
      "https://raw.githubusercontent.com/mhdpstudio/Vexora-data/main/data.json";

  static Future<Map<String, dynamic>> getData() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to load data (${response.statusCode})",
      );
    }

    return jsonDecode(response.body);
  }
}