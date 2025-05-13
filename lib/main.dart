import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/widgets/google_nav_bar/google_nav_bar_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const ModernGoogleNavBar(), title: "CryptoCrest");
  }
}
