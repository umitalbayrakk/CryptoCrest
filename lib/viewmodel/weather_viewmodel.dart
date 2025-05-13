// weather_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/model/weather_model/weather_model.dart';
import 'package:flutter_cryptocrest_app/service/weather_service.dart/weather_service.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherViewModel with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedCity = 'İstanbul';
  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedCity => _selectedCity;

  final Map<String, Map<String, double>> _cities = {
    'Adana': {'lat': 37.0000, 'lon': 35.3213},
    'Adıyaman': {'lat': 37.7648, 'lon': 38.2786},
    'Afyonkarahisar': {'lat': 38.7507, 'lon': 30.5567},
    'Ağrı': {'lat': 39.7191, 'lon': 43.0503},
    'Aksaray': {'lat': 38.3687, 'lon': 34.0254},
    'Amasya': {'lat': 40.6499, 'lon': 35.8353},
    'Ankara': {'lat': 39.9334, 'lon': 32.8597},
    'Antalya': {'lat': 36.8969, 'lon': 30.7133},
    'Ardahan': {'lat': 41.1105, 'lon': 42.7022},
    'Artvin': {'lat': 41.1828, 'lon': 41.8183},
    'Aydın': {'lat': 37.8450, 'lon': 27.8396},
    'Balıkesir': {'lat': 39.6484, 'lon': 27.8826},
    'Bartın': {'lat': 41.5811, 'lon': 32.4601},
    'Batman': {'lat': 37.8812, 'lon': 41.1351},
    'Bayburt': {'lat': 40.2552, 'lon': 40.2249},
    'Bilecik': {'lat': 40.0567, 'lon': 30.0665},
    'Bingöl': {'lat': 38.8853, 'lon': 40.4983},
    'Bitlis': {'lat': 38.3938, 'lon': 42.1232},
    'Bolu': {'lat': 40.7363, 'lon': 31.5784},
    'Burdur': {'lat': 37.7203, 'lon': 30.2908},
    'Bursa': {'lat': 40.1828, 'lon': 29.0670},
    'Çanakkale': {'lat': 40.1553, 'lon': 26.4142},
    'Çankırı': {'lat': 40.6013, 'lon': 33.6134},
    'Çorum': {'lat': 40.5506, 'lon': 34.9556},
    'Denizli': {'lat': 37.7765, 'lon': 29.0864},
    'Diyarbakır': {'lat': 37.9144, 'lon': 40.2306},
    'Düzce': {'lat': 40.8438, 'lon': 31.1567},
    'Edirne': {'lat': 41.6771, 'lon': 26.5557},
    'Elazığ': {'lat': 38.6810, 'lon': 39.2225},
    'Erzincan': {'lat': 39.7507, 'lon': 39.4928},
    'Erzurum': {'lat': 39.9050, 'lon': 41.2769},
    'Eskişehir': {'lat': 39.7767, 'lon': 30.5206},
    'Gaziantep': {'lat': 37.0662, 'lon': 37.3833},
    'Giresun': {'lat': 40.9128, 'lon': 38.3895},
    'Gümüşhane': {'lat': 40.4386, 'lon': 39.5086},
    'Hakkari': {'lat': 37.5833, 'lon': 43.7333},
    'Hatay': {'lat': 36.4018, 'lon': 36.3498},
    'Iğdır': {'lat': 39.9237, 'lon': 44.0450},
    'Isparta': {'lat': 37.7648, 'lon': 30.5566},
    'İstanbul': {'lat': 41.0082, 'lon': 28.9784},
    'İzmir': {'lat': 38.4237, 'lon': 27.1428},
    'Kahramanmaraş': {'lat': 37.5858, 'lon': 36.9371},
    'Karabük': {'lat': 41.2061, 'lon': 32.6204},
    'Karaman': {'lat': 37.1759, 'lon': 33.2287},
    'Kars': {'lat': 40.6167, 'lon': 43.0833},
    'Kastamonu': {'lat': 41.3887, 'lon': 33.7827},
    'Kayseri': {'lat': 38.7312, 'lon': 35.4787},
    'Kilis': {'lat': 36.7184, 'lon': 37.1212},
    'Kırıkkale': {'lat': 39.8468, 'lon': 33.5153},
    'Kırklareli': {'lat': 41.7351, 'lon': 27.2252},
    'Kırşehir': {'lat': 39.1458, 'lon': 34.1600},
    'Kocaeli': {'lat': 40.8533, 'lon': 29.8815},
    'Konya': {'lat': 37.8713, 'lon': 32.4846},
    'Kütahya': {'lat': 39.4167, 'lon': 29.9833},
    'Malatya': {'lat': 38.3552, 'lon': 38.3095},
    'Manisa': {'lat': 38.6191, 'lon': 27.4289},
    'Mardin': {'lat': 37.3212, 'lon': 40.7245},
    'Mersin': {'lat': 36.8121, 'lon': 34.6415},
    'Muğla': {'lat': 37.2153, 'lon': 28.3636},
    'Muş': {'lat': 38.9462, 'lon': 41.7539},
    'Nevşehir': {'lat': 38.6240, 'lon': 34.7233},
    'Niğde': {'lat': 37.9667, 'lon': 34.6833},
    'Ordu': {'lat': 40.9839, 'lon': 37.8764},
    'Osmaniye': {'lat': 37.0742, 'lon': 36.2478},
    'Rize': {'lat': 41.0201, 'lon': 40.5234},
    'Sakarya': {'lat': 40.7731, 'lon': 30.3948},
    'Samsun': {'lat': 41.2867, 'lon': 36.3300},
    'Şanlıurfa': {'lat': 37.1671, 'lon': 38.7955},
    'Siirt': {'lat': 37.9333, 'lon': 41.9500},
    'Sinop': {'lat': 42.0231, 'lon': 35.1531},
    'Sivas': {'lat': 39.7477, 'lon': 37.0179},
    'Şırnak': {'lat': 37.4188, 'lon': 42.4918},
    'Tekirdağ': {'lat': 40.9833, 'lon': 27.5167},
    'Tokat': {'lat': 40.3167, 'lon': 36.5500},
    'Trabzon': {'lat': 41.0050, 'lon': 39.7269},
    'Tunceli': {'lat': 39.1083, 'lon': 39.5471},
    'Uşak': {'lat': 38.6823, 'lon': 29.4082},
    'Van': {'lat': 38.4946, 'lon': 43.3800},
    'Yalova': {'lat': 40.6500, 'lon': 29.2667},
    'Yozgat': {'lat': 39.8181, 'lon': 34.8147},
    'Zonguldak': {'lat': 41.4564, 'lon': 31.7987},
  };

  Map<String, Map<String, double>> get cities => _cities;

  WeatherViewModel() {
    fetchWeather('İstanbul');
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final coords = _cities[city]!;
      _weather = await _weatherService.getWeather(coords['lat']!, coords['lon']!, city);
      _selectedCity = city;
    } catch (e) {
      _errorMessage = 'Hata: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  IconData getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
      case 2:
      case 3:
        return WeatherIcons.day_cloudy;
      case 45:
      case 48:
        return WeatherIcons.fog;
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
        return WeatherIcons.umbrella;
      case 71:
      case 73:
      case 75:
        return WeatherIcons.snow;
      case 80:
      case 81:
      case 82:
        return WeatherIcons.storm_showers;
      case 95:
        return WeatherIcons.thunderstorm;
      default:
        return Icons.help_outline;
    }
  }

  String formatDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    const monthNames = ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];
    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return 'Bugün';
    } else if (date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day) {
      return 'Yarın';
    } else {
      final shortYear = date.year.toString().substring(2);
      return '${date.day} ${monthNames[date.month - 1]} $shortYear'; // 5 May 25 formatı
    }
  }
}
