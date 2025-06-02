import 'dart:convert';
import 'package:flutter_cryptocrest_app/model/news_model/news_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN';

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['Type'] == 100 && data['Data'] != null) {
          return (data['Data'] as List).map((json) => NewsModel.fromJson(json)).toList();
        } else {
          throw Exception(data['Message'] ?? 'Veri alınamadı');
        }
      } else {
        throw Exception('HTTP Hatası: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Hata oluştu: $e');
    }
  }
}
