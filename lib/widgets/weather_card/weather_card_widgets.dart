import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/weather/weather_view.dart';
import 'package:flutter_cryptocrest_app/viewmodel/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class WeatherCardWidgets extends StatelessWidget {
  WeatherCardWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherView()));
        },
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.appBarColor, borderRadius: BorderRadius.circular(16)),
          child: Center(
            child:
                viewModel.weather == null
                    ? CircularProgressIndicator(color: Theme.of(context).iconTheme.color, strokeWidth: 2)
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Icon(
                          viewModel.getWeatherIcon(viewModel.weather!.currentWeatherCode),
                          size: 30,
                          color: AppColors.cardColor1,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          viewModel.weather!.cityName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.cardColor1,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '${viewModel.weather!.currentTemperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.cardColor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          viewModel.weather!.currentDescription,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.cardColor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
