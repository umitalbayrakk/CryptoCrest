import 'dart:convert';
import 'package:flutter_cryptocrest_app/model/weather_model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> getWeather(double latitude, double longitude, String cityName) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl?latitude=$latitude&longitude=$longitude'
        '&current=temperature_2m,weathercode'
        '&daily=weathercode,temperature_2m_max,temperature_2m_min'
        '&timezone=Europe%2FIstanbul'
        '&forecast_days=7',
      ),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body), cityName);
    } else {
      throw Exception('Hava durumu verisi alınamadı: ${response.statusCode}');
    }
  }
}
