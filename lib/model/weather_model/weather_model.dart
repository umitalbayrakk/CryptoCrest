class WeatherModel {
  final String cityName;
  final double currentTemperature;
  final String currentDescription;
  final int currentWeatherCode;
  final List<DailyForecast> dailyForecasts;

  WeatherModel({
    required this.cityName,
    required this.currentTemperature,
    required this.currentDescription,
    required this.currentWeatherCode,
    required this.dailyForecasts,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    final current = json['current'];
    final daily = json['daily'];

    final dailyForecasts = <DailyForecast>[];
    if (daily != null) {
      final timeList = daily['time'] as List<dynamic>? ?? [];
      final maxTempList = daily['temperature_2m_max'] as List<dynamic>? ?? [];
      final minTempList = daily['temperature_2m_min'] as List<dynamic>? ?? [];
      final weatherCodeList = daily['weathercode'] as List<dynamic>? ?? [];

      for (int i = 0; i < timeList.length; i++) {
        dailyForecasts.add(
          DailyForecast(
            date: DateTime.parse(timeList[i].toString()),
            maxTemp: maxTempList.isNotEmpty ? double.parse(maxTempList[i].toString()) : 0.0,
            minTemp: minTempList.isNotEmpty ? double.parse(minTempList[i].toString()) : 0.0,
            weatherCode: weatherCodeList.isNotEmpty ? int.parse(weatherCodeList[i].toString()) : 0,
          ),
        );
      }
    }

    return WeatherModel(
      cityName: cityName,
      currentTemperature: current['temperature_2m'] != null ? double.parse(current['temperature_2m'].toString()) : 0.0,
      currentDescription: _mapWeatherCode(current['weathercode'] ?? 0),
      currentWeatherCode: current['weathercode'] != null ? int.parse(current['weathercode'].toString()) : 0,
      dailyForecasts: dailyForecasts,
    );
  }

  static String _mapWeatherCode(int code) {
    switch (code) {
      case 0:
        return 'Açık';
      case 1:
      case 2:
      case 3:
        return 'Parçalı Bulutlu';
      case 45:
      case 48:
        return 'Sisli';
      case 51:
      case 53:
      case 55:
        return 'Çiseleyen Yağmur';
      case 61:
      case 63:
      case 65:
        return 'Yağmurlu';
      case 71:
      case 73:
      case 75:
        return 'Karlı';
      case 80:
      case 81:
      case 82:
        return 'Sağanak Yağmur';
      case 95:
        return 'Fırtınalı';
      default:
        return 'Bilinmiyor';
    }
  }
}

class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;

  DailyForecast({required this.date, required this.maxTemp, required this.minTemp, required this.weatherCode});

  String get description => WeatherModel._mapWeatherCode(weatherCode);
}
