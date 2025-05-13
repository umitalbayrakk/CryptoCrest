import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/viewmodel/weather_viewmodel.dart';
import 'package:flutter_cryptocrest_app/widgets/google_nav_bar_widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create:(_) => WeatherViewModel())
    ],
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home: const ModernGoogleNavBar(),
       title: "CryptoCrest",
     ),
    );
  }
}



