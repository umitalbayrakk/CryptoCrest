import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/viewmodel/weather_viewmodel.dart';
import 'package:flutter_cryptocrest_app/widgets/abbar/abbar_widgets.dart';
import 'package:provider/provider.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBarWidgets(),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hava Durumu',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Customdropdown(viewModel: viewModel),
              const SizedBox(height: 20),
              if (viewModel.isLoading)
                const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
              if (viewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    viewModel.errorMessage!,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (viewModel.weather != null) ...[
                Container(
                  decoration: BoxDecoration(color: AppColors.appBarColor, borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(
                          viewModel.getWeatherIcon(viewModel.weather!.currentWeatherCode),
                          size: 50,
                          color: AppColors.cardColor1,
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                viewModel.weather!.cityName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.cardColor1,
                                ),
                              ),
                              Text(
                                '${viewModel.weather!.currentTemperature.toStringAsFixed(1)}°C',
                                style: const TextStyle(fontSize: 20, color: AppColors.cardColor1),
                              ),
                              Text(
                                viewModel.weather!.currentDescription,
                                style: const TextStyle(fontSize: 16, color: AppColors.cardColor1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '7 Günlük Hava Durumu',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (viewModel.weather!.dailyForecasts.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.weather?.dailyForecasts.length ?? 0,
                      itemBuilder: (context, index) {
                        final forecast = viewModel.weather!.dailyForecasts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              //color: AppColors.appBarColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      viewModel.formatDay(forecast.date),
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(
                                    viewModel.getWeatherIcon(forecast.weatherCode),
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${forecast.maxTemp.toStringAsFixed(1)}° / ${forecast.minTemp.toStringAsFixed(1)}°',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      forecast.description,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  const Center(child: Text('Günlük tahmin verisi bulunamadı.')),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Customdropdown extends StatelessWidget {
  const Customdropdown({super.key, required this.viewModel});

  final WeatherViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textColor),
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: viewModel.selectedCity,
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColor),
        underline: const SizedBox(),
        onChanged: (value) {
          if (value != null) {
            viewModel.fetchWeather(value);
          }
        },
        items:
            viewModel.cities.keys.map((city) {
              return DropdownMenuItem<String>(value: city, child: Text(city));
            }).toList(),
      ),
    );
  }
}
